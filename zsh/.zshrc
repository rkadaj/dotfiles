# plugins=(
#   autojump
#   fzf
#   git
#   yarn
#   history
#   last-working-dir
#   zsh-autosuggestions
#   zsh-syntax-highlighting # Note: This plugin must be added last
# )

export HOMEBREW_NO_GOOGLE_ANALYTICS=true

alias gg=lazygit

if command -v rbenv &> /dev/null; then
  eval "$(rbenv init - zsh)"
fi

if [ -f ~/dotfiles/setup ]; then
  ~/dotfiles/setup
fi

eval "$(starship init zsh)"

[[ -f /opt/dev/sh/chruby/chruby.sh ]] && { type chruby >/dev/null 2>&1 || chruby () { source /opt/dev/sh/chruby/chruby.sh; chruby "$@"; } }

[[ -x /opt/homebrew/bin/brew ]] && eval $(/opt/homebrew/bin/brew shellenv)
eval "$(atuin init zsh)"

# to sync atuin
# if command -v atuin &> /dev/null; then
#   atuin sync
# fi

if [ $SPIN ]; then
  alias jc="journalctl"
  alias sc="systemctl"
fi

source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
