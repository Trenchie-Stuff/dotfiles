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
#alias ll="ls -lA"
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
autoload -Uz compinit
zstyle ':completion:*' menu select
fpath+=~/.zfunc
export BW_SESSION="dlklt8L/o6KUgkQku5iDtzTZll1bALuT87PQf/6VIMBgiX8B/0yHdZPV5eVptuz8pAZgFgxO0wlmYiuBqMvLmw=="
source /usr/share/nvm/init-nvm.sh
nvm use default 1> /dev/null

export HSA_OVERRIDE_GFX_VERSION=10.3.0

alias lt='eza --icons -abo --group-directories-first --git --no-permissions --color always -lh --sort=size --tree --level'
alias ls='eza --icons -abo --group-directories-first --git --no-permissions --color-scale all --color always -lh --sort=size'
alias lls='eza --icons -abo --group-directories-first --git --no-permissions --color-scale all --color always -lh --total-size --sort=size'
alias less='less -r'

alias ff="firefox"

function lalias
{
  local verbose=0
  local prefix=""
  while test $# != 0
  do
    case "$1" in
    --verbose|-v) local verbose=1 ;;
    --help|-h)
      echo "Show single letter extensions to the first argument string"
      echo
      echo " ___________________ "
      echo " |                  | "
      echo " | $ lalias \"l\"     | "
      echo " | la               | "
      echo " | lb               | "
      echo " | lc               | "
      echo " | le               | "
      echo " | [...]            | "
      echo " | lx               | "
      echo " | ly               | "
      echo " |                  | "
      echo " | $                | "
      echo " |                  | "
      echo " ------------------- "
      echo
      echo "(ld and lz are not showing because the command already exists)"
      return 0 ;;
    *) local prefix="$1"
    esac
    shift
  done
  local ww=$(tput cols)
  if [ -z "$prefix" ]
  then
    echo "-h for help"
    return 1
  else    
    for c in a b c d e f g h i j k l m n o p q r s t u v w x y z
    do
      local posCmd="$prefix$c"
      local res=$(which $posCmd)
      which $posCmd > /dev/null
      if [[ $? == 1 ]]
      then
        echo $posCmd
      elif [[ $verbose == 1 ]]
      then
        local resLen=${#res}
        local maxLen=$(( $ww - ${#posCmd} - 1 ))
        alias $posCmd > /dev/null
        if [[ $? == 1 ]]
        then
          echo "\033[3;31m$posCmd: $res\033[0m"
        else
          if (( $resLen >= $maxLen ));
          then
            echo "\033[3;31m${res:0:$maxLen}...\033[0m"
          else
            echo "\033[3;31m${res:0:$maxLen}\033[0m"
          fi
        fi        
      fi
    done
  fi
}


# Load Angular CLI autocompletion.
source <(ng completion script)

alias mmenu="bemenu -c -p 'LCARS' -P '>' -i -l 20 -w --fixed-height --scrollbar always -B 4 --bdr '#2266DD' --margin 500 --fn 'Antonio 20' --scb '#000000' --scf '#b59cce' --tb '#000000' --tf '#b59cce' --fb '#000000' --ff '#b59cce' --cf '#000000' --cb '#b59cce' --nb '#b59cce' --nf '#000000' --hb '#553c6e' --hf '#ffffff' --sb '#f6ef95' --sf '#000000' --ab '#c5Acde' --af '#000000' "
