command_not_found_handle() {
	/data/data/com.termux/files/usr/libexec/termux/command-not-found "$1"
}

#aliases

alias l='ls --color=auto'
alias ls='ls --color=auto'
alias ll='ls -l --color=auto'
alias la='ls -A --color=auto'
alias lla='ls -lA --color=auto'
alias df='df -h'
alias du='du -h'
alias gs='git status -s'
alias ga='git add'
alias gaa='git add --all'
alias gc='git commit -m'

export WORKON_HOME=$HOME/.virtualenvs
source /data/data/com.termux/files/usr/bin/virtualenvwrapper.sh

echo 'knock, knock...'
