# typed: strict
# frozen_string_literal: true

require "find"
require_relative "base"

Find.find(File.join(File.expand_path(__dir__))) do |file|
  next if File.extname(file) != ".rb"

  next if file =~ %r{/base.rb$}
  next if file =~ %r{/dotfiles.rb$}

  load(file)
end

class Dotfiles
  extend T::Sig

  sig { void }
  def run
    run_once do
      Apt.new.run
      Homebrew.new.run

      Kitty.new.run
      Git.new.run
      Atuin.new.run
      Zsh.new.run
      LazyGit.new.run
      VSCode.new.run

      LastRun.instance.update
    end
  end

  private

  sig { params(blk: T.proc.void).void }
  def run_once(&blk)
    called = false
    if File.exist?(run_file)
      puts("Aborting since it is already running")
      return
    end

    File.write(run_file, "")

    blk.call
    called = true
  ensure
    File.delete(run_file) if called
  end

  sig { returns(String) }
  def run_file
    File.join(__dir__, ".running")
  end
end

Dotfiles.new.run
