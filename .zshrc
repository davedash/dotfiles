# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
export EDITOR=vim

ZSH_THEME="bureau"
ZSH_CLASS="macbook $ZSH_CLASS"
PROJECT_HOME=$HOME/code

# Uncomment following line if you want red dots to be displayed while waiting
# for completion
COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in
# ~/.oh-my-zsh/plugins/*) Custom plugins may be added to
# ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git virtualenv dotenv yarn fzf)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:$PATH
export PATH=$PATH:$HOME/.dotfiles/bin:$HOME/bin

# Ruby:
zstyle ':completion:*:(all-|)files' ignored-patterns "(*.pyc|*~)"
export PYTHONPATH=$PYTHONPATH:/mnt/pinboard
export IRC_USER='davedash'
# Look at .aliasrc and steal!!!
export ALIAS_FILE=$HOME/.aliases
if [[ -r $ALIAS_FILE ]]; then
    eval `awk '/^[^# ]/ {print "alias " $0}' ${HOME}/.aliases`
fi

export AUTOCD=$HOME/.autocd
if [[ -r $AUTOCD ]]; then
    function cd {
        if [[ -n $1 ]] ; then
            builtin cd $*
        else
            eval builtin cd $(cat $AUTOCD)
        fi
    }
    cd
fi


# Look at .aliasrc and steal!!!
for class in "${(s/ /)ZSH_CLASS}"; do
    if [[ -r ${HOME}/.aliases.${class} ]]; then
        eval `awk '/^[^# ]/ {print "alias " $0}' ${HOME}/.aliases.${class}`
    fi
done

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting



function ai {
    autopep8 -i $1
    pep8 $1
}

# Custom completions
fpath=(~/.zsh/completion $fpath)

# compsys initialization
autoload -U compinit
compinit

if [[ $ZSH_CLASS == *devapp* ]] ; then
    PROMPT="$(hostname) $PROMPT"
fi

# Local configs, keys, etc should go in ~/.local.
if [[ -r ${HOME}/.local ]]; then
    source ${HOME}/.local
fi

export AUTOSSH_PORT=0

function findit {
    grep -R $1 .
}

export GOPATH=$HOME/code/go
export PATH=$PATH:$GOPATH/bin

function c {
    dir=$(find ~/Projects \( -type d -or -type l \) -maxdepth 2 -d -name $1|head -1)
    if [ -n "$dir" ]; then
        cd $dir
    fi
}

function jql {
    jq -C $@ | less -R
}

function mkgoproject {
  GOPROJECTPATH=${GOPATH}/src/github.com/davedash/$1
  mkdir ${GOPROJECTPATH}
  ln -s ${GOPROJECTPATH} ${GOPATH}/../${1}
  cd ${GOPATH}/../${1}
}

function countdown {
  count=$1
  shift
  $@
  if [ "$count" -gt "0" ]; then
      next=$(expr $count / 2)
      until=$(expr $next + 1)
      for i in {${count}..${until}}; do; echo $i; sleep 1; done
      countdown ${next} $@
  fi
}
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

function hs {
    heroku $@ -a staging-ditto-v2
}
# added by pipsi (https://github.com/mitsuhiko/pipsi)
export PATH="/Users/davedash/.local/bin:$PATH"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

autoload -U add-zsh-hook
load-nvmrc() {
  if [[ -f .nvmrc && -r .nvmrc ]]; then
    nvm use
  elif [[ $(nvm version) != $(nvm version default)  ]]; then
    echo "Reverting to nvm default version"
    nvm use default
  fi
}
add-zsh-hook chpwd load-nvmrc
load-nvmrc

# HISTORY
setopt HIST_IGNORE_ALL_DUPS

export AWS_PAGER=


#### FIG ENV VARIABLES ####
[ -s ~/.fig/fig.sh ] && source ~/.fig/fig.sh
#### END FIG ENV VARIABLES ####


