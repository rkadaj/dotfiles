# typed: strict
# frozen_string_literal: true

class Link < Base
  extend T::Sig

  sig { params(source: String, target: String, dir: T.nilable(String)).void }
  def initialize(source:, target:, dir: nil)
    super()

    @dir = T.let(dir || directory, String)
    @source = T.let(source, String)
    @target = T.let(target.gsub("~", Dir.home), String)
  end

  sig { override.void }
  def run
    debug("Linking #{@source} -> #{@target}")
    if File.symlink?(@target)
      debug("Already in place, skipping")
      return
    end

    if File.exist?(@target)
      debug("File exists but is no symlink, moving it")
      File.rename(@target, "#{@target}.old")
    end

    unless File.exist?(parent_dir(@target))
      debug("Parent directory does not exist, creatking")
      Dir.mkdir(parent_dir(@target))
    end

    File.symlink("#{@dir}/#{@source}", @target)
  end

  private

  sig { params(file_or_dir: String).returns(String) }
  def parent_dir(file_or_dir)
    File.expand_path(File.join(file_or_dir, ".."))
  end
end
