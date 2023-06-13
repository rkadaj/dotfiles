# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set Theme - https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="agnoster"

# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Add wisely, as too many plugins slow down shell startup.

plugins=(git)

source $ZSH/oh-my-zsh.sh

# ==================== MY ADDITIONS ====================

# Custom User config
alias ll="ls -lAhG"
alias reload-zsh="source ~/.zshrc"
alias gitlogs="git log --graph --pretty=format:'%C(auto)%h%d %s %C(green)(%cr) %C(cyan)[%an]%C(reset)'"
alias gitlog="gitlogs -n 25"
alias groot="cd \$(git rev-parse --show-toplevel)"
alias devstyle="dev style --include-branch-commits"
alias devtest="dev test --include-branch-commits"
alias devtc="dev tc --include-branch-commmits"

if [ $SPIN ]; then
  alias jc="journalctl"
  alias sc="systemctl"

  PROMPT="😵‍💫 $PROMPT"
fi
