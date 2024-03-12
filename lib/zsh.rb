# typed: strict
# frozen_string_literal: true

class Zsh < Base
  extend T::Sig

  sig { override.void }
  def run
    debug("")
    Link.new(source: "zsh/.zshrc", target: "~/.zshrc").run
    Link.new(source: "zsh/.antigenrc", target: "~/.antigenrc").run
    FetchFile.new(url: "https://git.io/antigen", target: "~/.antigen.zsh").run
    Link.new(source: "zsh/starship.toml", target: "~/.config/starship.toml").run
    ExecuteFile.new(url: "https://starship.rs/install.sh", executable: "starship").run
  end
end
