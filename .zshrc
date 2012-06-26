# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="cloud"
if [[ $HOST == 'immacomputer.local' ]] ; then
    ZSH_THEME="clean"
    ZSH_CLASS="macbook $ZSH_CLASS"
    alias pinboard='cd $HOME/Projects/pinboard'
else
    ZSH_CLASS="ec2"
    function cd {
        if [[ -n $1 ]] ; then
            builtin cd $*
        else
            builtin cd $HOME/pinboard
        fi
    }
    cd
fi

# Uncomment following line if you want red dots to be displayed while waiting for completion
COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games
export PATH=$PATH:$HOME/.dotfiles/bin
export EDITOR=vi
zstyle ':completion:*:(all-|)files' ignored-patterns "(*.pyc|*~)"
export PYTHONPATH=$PYTHONPATH:/mnt/pinboard
export IRC_USER='davedash'
# Look at .aliasrc and steal!!!
export ALIAS_FILE=$HOME/.aliases
if [[ -r $ALIAS_FILE ]]; then
    eval `awk '/^[^# ]/ {print "alias " $0}' ${HOME}/.aliases`
fi

# Look at .aliasrc and steal!!!
for class in "${(s/ /)ZSH_CLASS}"; do
    if [[ -r ${HOME}/.aliases.${class} ]]; then
        eval `awk '/^[^# ]/ {print "alias " $0}' ${HOME}/.aliases.${ZSH_CLASS}`
    fi
done

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
