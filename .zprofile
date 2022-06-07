source ~/.zshrc

# ------- export
export SVN_SSH="ssh -2"

if [ -e ~/tools/pt_darwin_amd64 ] ; then
    export PATH=~/tools/pt_darwin_amd64:$PATH
fi

which peco > /dev/null 2>&1
if [ $? -eq 0 ] ; then
    zle -N peco-history-selection
    bindkey '^R' peco-history-selection
else
    bindkey "^R" history-incremental-search-backward
fi

if [ ! `echo $PATH | grep /home/ygoda/bin` ] ; then
    export PATH="$PATH:/home/ygoda/bin"
fi

which tmux > /dev/null 2>&1
if [ $? -eq 0 ] ; then
    tmux ls
fi
