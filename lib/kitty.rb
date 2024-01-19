# typed: strict
# frozen_string_literal: true

class Kitty < Base
  extend T::Sig

  sig { override.void }
  def run
    debug("")
    debug("Setting up kitty config")
    Link.new(source: "kitty", target: "~/.config/kitty").run
  end
end
