# typed: strict
# frozen_string_literal: true

class Apt < Base
  extend T::Sig

  sig { params(last_run: LastRun).void }
  def initialize(last_run: LastRun.instance)
    super()

    @last_run = last_run
  end

  sig { override.void }
  def run
    debug("")
    debug("Running apt")

    return debug("Not running on Linux, skipping") unless linux?

    return debug("No packages need to be installed, skipping") if packages_to_install.empty?

    @last_run.run_if_needed("sudo apt-get update -y")
    @last_run.run_if_needed("sudo apt-get install -y #{packages_to_install.join(' ')}")

    packages_to_install.each { |package| mark_package_as_installed(package) }
  end

  private

  sig { returns(T::Array[String]) }
  def packages
    %w[
      fzf
      zsh
    ]
  end

  sig { returns(T::Array[String]) }
  def packages_to_install
    packages.filter { |package| !package_installed?(package) }
  end

  sig { params(name: String).returns(T::Boolean) }
  def package_installed?(name)
    manifest_exists?(name)
  end

  sig { params(name: String).void }
  def mark_package_as_installed(name)
    create_manifest(name)
  end
end
