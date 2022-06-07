if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi

if [ -e ~/pt_linux_amd64 ]; then
    export PATH=$PATH:~/pt_linux_amd64
fi

if [ -e ~/tools ]; then
    export PATH=$PATH:~/tools
fi

if [ -z "${BASH_EXECUTION_STRING}" ]; then
    ZSH="/usr/local/bin/zsh"
    [ -x "${ZSH}" ] && SHELL="${ZSH}" exec "${ZSH}" -l
fi
