# typed: strict
# frozen_string_literal: true

class VSCodeExtension < Base
  extend T::Sig

  sig { params(name: String).void }
  def initialize(name:)
    super()

    @name = name
  end

  sig { override.void }
  def run
    debug("Installing VS Code extension #{@name}")

    return debug("Already installed, skipping") if manifest_exists?(@name)

    `code --install-extension #{@name}`

    create_manifest(@name)
  end
end
