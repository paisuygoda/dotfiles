# export
export PS1="\[\e[0;32m\][\[\e[0;31m\]\h\[\e[00m\]:\e[00m\e[0;36m\]\w\e[00m\e[0;32m\]]\n\$ \[\e[00m\]"

# alias
## common
alias grep='grep --color'
alias ssh='ssh -A'
alias ls='ls --sort=extension --color=tty -G -F'
alias hi='history'
alias hig='history | grep '
alias lsl='ls -l'
alias ll='ls -l'
alias ..='cd ..'
alias ...='cd ../..'

## git
alias gl='git branch'
alias gc='git checkout'
alias glog='git log --graph --date=short --decorate --pretty=format:"%Cgreen%h %Creset%cd %Cblue%cn %Cred%d %Creset%s"'
