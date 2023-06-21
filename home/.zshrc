if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="powerlevel10k/powerlevel10k"

HIST_STAMPS="yyyy-mm-dd"

plugins=(git)

zstyle ':omz:update' mode auto      # update automatically without asking

zstyle ':omz:update' frequency 7

source $ZSH/oh-my-zsh.sh


# User configuration

if [[ ":$PATH:" != *":$HOME/.dotnet/tools:"* ]]; then
  export PATH="$PATH:$HOME/.dotnet/tools"
fi

#if [[ -n $SSH_CONNECTION ]]; then
#  export TERM="screen"
#fi
alias ll="ls -lA"
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
autoload -Uz compinit
zstyle ':completion:*' menu select
fpath+=~/.zfunc
export BW_SESSION="dlklt8L/o6KUgkQku5iDtzTZll1bALuT87PQf/6VIMBgiX8B/0yHdZPV5eVptuz8pAZgFgxO0wlmYiuBqMvLmw=="
source /usr/share/nvm/init-nvm.sh
nvm use default 1> /dev/null
