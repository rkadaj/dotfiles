# typed: strict
# frozen_string_literal: true

class Git < Base
  extend T::Sig

  sig { override.void }
  def run
    debug("")
    debug("Setting up git config")

    Link.new(source: "git/config", target: "~/.gitconfig").run
    Link.new(source: "git/config.shopify", target: "~/.gitconfig.shopify").run if work?
    return unless personal?

    Link.new(source: "git/config.personal", target: "~/.gitconfig.personal").run
  end
end
