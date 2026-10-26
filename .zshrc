export EDITOR=vim

ZSH_CLASS="macbook $ZSH_CLASS"
PROJECT_HOME=$HOME/code

# Custom completions
fpath=(~/.zsh/completion $fpath)

# Plugins are listed in ~/.zsh_plugins.txt and managed by antidote.
if [[ -r ~/.antidote/antidote.zsh ]]; then
    source ~/.antidote/antidote.zsh
    antidote load
else
    autoload -Uz compinit
    compinit
fi

# Customize to your needs...
export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:$PATH
export PATH=$PATH:$HOME/.dotfiles/bin:$HOME/bin
if [[ -x /opt/homebrew/bin/brew ]]; then eval "$(/opt/homebrew/bin/brew shellenv)"; fi

# Ruby:
zstyle ':completion:*:(all-|)files' ignored-patterns "(*.pyc|*~)"
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


function ai {
    autopep8 -i $1
    pep8 $1
}

# Local configs, keys, etc should go in ~/.local.
if [[ -f ${HOME}/.local ]]; then
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

# Tools installed by uv, pipx, Claude Code, etc.
export PATH="$HOME/.local/bin:$PATH"

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


autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /opt/homebrew/bin/terraform terraform

# Local Graphite subcommands. gt's own alias system only resolves alias
# words to other gt subcommands; it can't run external scripts, so we
# intercept here.
#   worktree-cleanup — ~/.config/graphite/worktree-cleanup.sh
#   sync-all         — ~/.dotfiles/bin/gt-sync-all (cleanup + per-worktree gt sync)
gt() {
    case "${1-}" in
        worktree-cleanup)
            shift
            "$HOME/.config/graphite/worktree-cleanup.sh" "$@"
            return $?
            ;;
        sync-all)
            shift
            "$HOME/.dotfiles/bin/gt-sync-all" "$@"
            return $?
            ;;
    esac
    command gt "$@"
}

# After `brew install` or `brew uninstall`, offer to add or remove the package
# from ~/.dotfiles/.Brewfile.
brew() {
    command brew "$@" || return $?
    [[ -t 0 ]] || return 0
    local cmd=$1
    case $cmd in
        install|uninstall|remove|rm) ;;
        *) return 0 ;;
    esac
    shift
    local brewfile=~/.dotfiles/.Brewfile
    local kind arg name
    local -a names
    for arg in "$@"; do
        case $arg in
            --cask|--casks) kind=cask ;;
            --formula|--formulae) kind=formula ;;
            -*) ;;
            *) names+=($arg) ;;
        esac
    done
    for name in $names; do
        if [[ $cmd == install ]]; then
            grep -qE "^(brew|cask) \"$name\"" $brewfile && continue
            if read -q "?Add $name to .Brewfile? [y/N] "; then
                echo
                if [[ $kind == cask ]] || { [[ -z $kind ]] && command brew list --cask $name &> /dev/null; }; then
                    command brew bundle add --file=$brewfile --cask $name
                else
                    command brew bundle add --file=$brewfile $name
                fi
            else
                echo
            fi
        else
            grep -qE "^(brew|cask) \"$name\"" $brewfile || continue
            if read -q "?Remove $name from .Brewfile? [y/N] "; then
                echo
                command brew bundle remove --file=$brewfile $name
            else
                echo
            fi
        fi
    done
}

# Prompt, smarter cd, fuzzy finder, and shell history.
if command -v starship > /dev/null; then eval "$(starship init zsh)"; fi
if command -v zoxide > /dev/null; then eval "$(zoxide init zsh)"; fi
if command -v fzf > /dev/null; then source <(fzf --zsh); fi
# atuin loads after fzf so it owns Ctrl-R; the up arrow stays plain history.
if command -v atuin > /dev/null; then eval "$(atuin init zsh --disable-up-arrow)"; fi
# direnv loads per-directory environments, like the repl-it-web Nix devshell.
# Its hook goes last so it wraps the prompt hooks above.
if command -v direnv > /dev/null; then eval "$(direnv hook zsh)"; fi
