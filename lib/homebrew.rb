# typed: strict
# frozen_string_literal: true

class Homebrew < Base
  extend T::Sig

  sig { params(last_run: LastRun).void }
  def initialize(last_run: LastRun.instance)
    super()

    @last_run = last_run
  end

  sig { override.void }
  def run
    debug("")
    debug("Running brew")
    unless macos?
      debug("Not running on MacOS, skipping")
      return
    end

    @last_run.run_if_needed("brew bundle", manifest: "Brewfile")
    # @last_run.run_if_needed("brew bundle", manifest: "Brewfile", sub_directory: "personal") if personal?
    # @last_run.run_if_needed("brew bundle", manifest: "Brewfile", sub_directory: "work") if work?

    enable_auto_updates
  end

  private

  sig { void }
  def enable_auto_updates
    return if manifest_exists?("brew_auto_update")

    `brew autoupdate start --upgrade --cleanup`

    create_manifest("brew_auto_update")
  end
end
