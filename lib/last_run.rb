# typed: strict
# frozen_string_literal: true

class LastRun < Base
  extend T::Sig

  TIME_BETWEEN_UPDATES = T.let(60 * 60 * 24 * 7, Integer)

  @instance = T.let(nil, T.nilable(LastRun))

  sig { returns(LastRun) }
  def self.instance
    @instance ||= LastRun.new
  end

  sig do
    params(
      command: String,
      manifest: T.nilable(String),
      sub_directory: T.nilable(String),
      blk: T.nilable(T.proc.void)
    ).void
  end
  def run_if_needed(command, manifest: nil, sub_directory: nil, &blk)
    debug("Checking if #{command} needs to be run #{"in #{sub_directory}" if sub_directory}")
    if was_run_recently? && !manifest_changed?(sub_directory: sub_directory, manifest: manifest)
      debug("Was run recently, skipping")
      return
    end

    log("Running #{command} #{"in #{sub_directory}" if sub_directory}")
    `cd #{directory(sub_directory: sub_directory)} && #{command}` if command

    blk.call if block_given?

    update_manifest(sub_directory: sub_directory, manifest: manifest) if manifest
  end

  sig { void }
  def update
    return if was_run_recently?

    File.write(last_run_file, Time.now.to_i)
  end

  sig { override.void }
  def run; end

  private

  sig { params(sub_directory: T.nilable(String), manifest: T.nilable(String)).void }
  def update_manifest(sub_directory:, manifest:)
    File.write(last_run_file(sub_directory: sub_directory, manifest: manifest), Time.now.to_i)
  end

  sig { params(sub_directory: T.nilable(String), manifest: T.nilable(String)).returns(T::Boolean) }
  def manifest_changed?(sub_directory:, manifest:)
    return false if manifest.nil?

    File.mtime(File.join(directory(sub_directory: sub_directory),
                         manifest)).to_i > last_run_time(sub_directory: sub_directory, manifest: manifest)
  end

  sig { returns(T::Boolean) }
  def was_run_recently?
    time_since_last_run = Time.now.to_i - last_run_time

    time_since_last_run < TIME_BETWEEN_UPDATES
  end

  sig { params(sub_directory: T.nilable(String), manifest: T.nilable(String)).returns(Integer) }
  def last_run_time(sub_directory: nil, manifest: nil)
    File.read(last_run_file(sub_directory: sub_directory, manifest: manifest)).to_i
  rescue Errno::ENOENT
    0
  end

  sig { params(sub_directory: T.nilable(String), manifest: T.nilable(String)).returns(String) }
  def last_run_file(sub_directory: nil, manifest: nil)
    File.join(File.expand_path(directory(sub_directory: sub_directory)), ".last_run#{"_#{manifest}" if manifest}")
  end
end
