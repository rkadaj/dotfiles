# typed: true
# frozen_string_literal: true

class Atuin < Base
  extend T::Sig

  sig { override.void }
  def run
    return if executable_exists?("atuin")

    debug("Installing atuin")

    `curl --proto '=https' --tlsv1.2 -sSf https://setup.atuin.sh | bash`

    # sync your shell history between computers 
    # `atuin login`
    # `atuin sync`
  end
end
