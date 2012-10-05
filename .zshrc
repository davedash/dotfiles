# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
export EDITOR=vim
ZSH_THEME="cloud"
var="immacomputer"
if [[ $HOST == $var* ]] ; then
    ZSH_THEME="clean"
    ZSH_CLASS="macbook $ZSH_CLASS"
    PROJECT_HOME=$HOME/Projects
    source /usr/local/bin/virtualenvwrapper.sh
elif [[ $HOST == 'devapp002' ]] ; then
    ZSH_CLASS="devapp ec2 $ZSH_CLASS"
elif [[ $HOST == 'puppet-dave' ]] ; then
    ZSH_CLASS="puppet ec2 $ZSH_CLASS"
    ZSH_THEME="af-magic"
else # dev boxes
    ZSH_CLASS="ec2"
fi

# Uncomment following line if you want red dots to be displayed while waiting
# for completion
COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in
# ~/.oh-my-zsh/plugins/*) Custom plugins may be added to
# ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git,ssh-agent)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games
export PATH=$PATH:$HOME/.dotfiles/bin
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

function dsh5 {
    # Make sure to run tools/puppet/puppet-to-dsh.py beforehand to
    # update the groups
    usage="$0 group cmd"
    [ -z "$1" ] && echo $usage && return 1
    [ -z "$2" ] && echo $usage && return 1
    dsh -r ssh -o "-o ConnectTimeout=10" -o "-o CheckHostIP=no" \
        -o "-o StrictHostKeyChecking=no" -F 4 -M -c -g "$1" "$2"
}


function dsh20 {
    # Make sure to run tools/puppet/puppet-to-dsh.py beforehand to
    # update the groups
    usage="$0 group cmd"
    [ -z "$1" ] && echo $usage && return 1
    [ -z "$2" ] && echo $usage && return 1
    dsh -r ssh -o "-o ConnectTimeout=10" -o "-o CheckHostIP=no" -o "-o StrictHostKeyChecking=no" -F 20 -M -c -g "$1" "$2"
}

function dsh_update {
    cd ~/work/pinboard
    tools/puppet/puppet-to-dsh.py
}

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
    eval `awk '/^[^# ]/ {print "alias " $0}' ${HOME}/.aliases.${ZSH_CLASS}`
fi

export AUTOSSH_PORT=0
