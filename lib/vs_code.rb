# typed: strict
# frozen_string_literal: true

class VSCode < Base
  sig { override.void }
  def run
    return unless macos?

    Link.new(source: "vscode/settings.json",
             target: "~/Library/Application Support/Code/User/settings.json").run
    Link.new(source: "vscode/keybindings.json",
             target: "~/Library/Application Support/Code/User/keybindings.json").run

    install_extensions(general_extensions)
    install_extensions(personal_extensions) if personal?
  end

  private

  sig { params(extensions: T::Array[String]).void }
  def install_extensions(extensions)
    extensions.each do |extension|
      VSCodeExtension.new(name: extension).run
    end
  end

  sig { returns(T::Array[String]) }
  def general_extensions
    [
      "itarato.byesig", "Shopify.ruby-lsp", "sorbet.sorbet-vscode-extension", "wwm.better-align",
      "orepor.color-tabs-vscode-ext", "usernamehw.errorlens", "oderwat.indent-rainbow", "johnpapa.vscode-peacock",
      "Gruntfuggly.todo-tree", "redhat.vscode-yaml"
    ]
  end

  sig { returns(T::Array[String]) }
  def personal_extensions
    []
  end
end
