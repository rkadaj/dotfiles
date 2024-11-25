export HOMEBREW_NO_GOOGLE_ANALYTICS=true

alias gg=lazygit

# fpath=("${HOME}/.zsh/completions" $fpath)

if [ -f ~/.antigen.zsh ]; then
  source ~/.antigen.zsh
  antigen init ~/.antigenrc
fi

PATH=$HOME/dotfiles/binaries:$PATH

if command -v rbenv &> /dev/null; then
  eval "$(rbenv init - zsh)"
fi

if [ -f ~/dotfiles/setup ]; then
  ~/dotfiles/setup
fi

eval "$(starship init zsh)"

[[ -f /opt/dev/sh/chruby/chruby.sh ]] && { type chruby >/dev/null 2>&1 || chruby () { source /opt/dev/sh/chruby/chruby.sh; chruby "$@"; } }

[[ -x /opt/homebrew/bin/brew ]] && eval $(/opt/homebrew/bin/brew shellenv)

if [ -f ~/.atuin/bin/env ]; then
  . "$HOME/.atuin/bin/env"
  eval "$(atuin init zsh)"
fi
# to sync atuin
# if command -v atuin &> /dev/null; then
#   atuin sync
# fi

if [ $SPIN ]; then
  source /etc/zsh/zshrc.default.inc.zsh
  alias devr="dev reup && dev restart --procs"
fi
