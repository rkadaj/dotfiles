# typed: strict
# frozen_string_literal: true

class LazyGit < Base
  extend T::Sig

  sig { override.void }
  def run
    debug("")
    debug("Installing lazygit")

    Script.new(file: "install_lazygit").run if linux?
    # on macos it is installed via homebrew
  end
end
