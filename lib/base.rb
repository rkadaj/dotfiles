# typed: strict
# frozen_string_literal: true

require "socket"
require "sorbet-runtime"
require "fileutils"

class Base
  extend T::Helpers
  extend T::Sig
  abstract!

  sig { void }
  def initialize
    @hostname = T.let(nil, T.nilable(String))
  end

  sig { abstract.void }
  def run; end

  sig { params(sub_directory: T.nilable(String)).returns(String) }
  def directory(sub_directory: nil)
    base = File.expand_path(File.join(__dir__, ".."))

    return base if sub_directory.nil?

    File.join(base, sub_directory)
  end

  sig { params(message: String).void }
  def debug(message)
    log(message, level: :debug)
  end

  sig { params(message: String, level: Symbol).void }
  def log(message, level: :info)
    puts(message) if level != :debug || debug?
    File.write(File.join(directory, ".log"), "#{message}\n", mode: "a+")
  end

  sig { returns(T::Boolean) }
  def macos?
    os == "MacOS"
  end

  sig { returns(T::Boolean) }
  def linux?
    os == "Linux"
  end

  sig { params(executable: String).returns(T::Boolean) }
  def executable_exists?(executable)
    ENV.fetch("PATH", "").split(File::PATH_SEPARATOR).any? do |directory|
      File.executable?(File.join(directory, executable.to_s))
    end
  end

  sig { returns(T::Boolean) }
  def work?
    return true if spin?

    hostname_matches(/shopify/i)
  end

  sig { params(regex: Regexp).returns(T::Boolean) }
  def hostname_matches(regex)
    regex.match?(hostname)
  end

  sig { returns(T::Boolean) }
  def personal?
    !work?
  end

  sig { returns(T::Boolean) }
  def spin?
    ENV.fetch("SPIN", nil) != nil
  end

  private

  sig { returns(String) }
  def hostname
    @hostname ||= Socket.gethostname
  end

  sig { returns(String) }
  def os
    `uname -s`.strip.gsub("Darwin", "MacOS")
  end

  sig { returns(T::Boolean) }
  def debug?
    ENV.fetch("DEBUG", nil) == "true"
  end

  sig { params(name: String).void }
  def create_manifest(name)
    FileUtils.touch(File.join(directory, ".manifests", name))
  end

  sig { params(name: String).returns(T::Boolean) }
  def manifest_exists?(name)
    File.exist?(File.join(directory, ".manifests", name))
  end
end
