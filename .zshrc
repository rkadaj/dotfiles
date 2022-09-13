# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set Theme - https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  fzf
  git
  yarn
  history
  last-working-dir
  zsh-autosuggestions
  zsh-syntax-highlighting # Note: This plugin must be added last
)

source $ZSH/oh-my-zsh.sh

# ==================== MY ADDITIONS ====================

# Custom key binding for command + arrow keys
bindkey "^[^[[D" backward-word
bindkey "^[^[[C" forward-word

# FZF
export FZF_BASE=/path/to/fzf/install/dir
export FZF_DEFAULT_OPTS='--layout=reverse'
export FZF_DEFAULT_COMMAND='fd --type f'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# My Custom Exports
export SHOPIFY="/src/github.com/shopify"

# Configure Yarn global path
export PATH="$(yarn global bin):$PATH"

# Custom User config
alias ll="ls -lAhG"
alias reload-zsh="source ~/.zshrc"
alias gitlogs="git log --graph --pretty=format:'%C(auto)%h%d %s %C(green)(%cr) %C(cyan)[%an]%C(reset)'"
alias gitlog="gitlogs -n 25"
alias groot="cd \$(git rev-parse --show-toplevel)"
alias devstyle="dev style --include-branch-commits"
alias devtest="dev test --include-branch-commits"
alias devtc="dev tc --include-branch-commmits"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

if [ $SPIN ]; then
  alias jc="journalctl"
  alias sc="systemctl"

  PROMPT="😵‍💫 $PROMPT"
fi

#mcfly
eval "$(mcfly init zsh)"