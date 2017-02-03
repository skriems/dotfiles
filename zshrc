HISTFILE=~/.histfile
HISTSIZE=50000
SAVEHIST=50000
unsetopt beep
bindkey -v

zstyle :compinstall filename '/home/skr/.zshrc'

# prompt theme
autoload -Uz promptinit
promptinit
prompt walters

# completion
autoload -Uz compinit
compinit
setopt COMPLETE_ALIASES
source /usr/share/doc/pkgfile/command-not-found.zsh
# make newly installed executables available to completion
zstyle ':completion:*' rehash true

alias l='ls --color=auto'
alias ls='ls --color=auto'
alias ll="ls -l --color=auto"
alias la="ls -a --color=auto"
alias lla="ls -la --color=auto"
alias df="df -h"
alias du="du -h"

# history search
autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

[[ -n "${key[Up]}"   ]] && bindkey "${key[Up]}"   up-line-or-beginning-search
[[ -n "${key[Down]}" ]] && bindkey "${key[Down]}" down-line-or-beginning-search

#
# [start] remember the DIRSTACKSIZE last visited folders
# use "dirs -v"
DIRSTACKFILE="$HOME/.cache/zsh/dirs"
if [[ -f $DIRSTACKFILE ]] && [[ $#dirstack -eq 0 ]]; then
  dirstack=( ${(f)"$(< $DIRSTACKFILE)"} )
  [[ -d $dirstack[1] ]] && cd $dirstack[1]
fi
chpwd() {
  print -l $PWD ${(u)dirstack} >$DIRSTACKFILE
}
DIRSTACKSIZE=20
setopt AUTO_PUSHD PUSHD_SILENT PUSHD_TO_HOME
## Remove duplicate entries
setopt PUSHD_IGNORE_DUPS
## This reverts the +/- operators.
setopt PUSHD_MINUS
#
# [end] remember the DIRSTACKSIZE last visited folders
#

archey3
export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python
export WORKON_HOME=~/.virtualenvs
source /usr/bin/virtualenvwrapper.sh

