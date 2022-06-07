fpath=("$HOME/.zfunctions" $fpath)
autoload -Uz promptinit
promptinit
if   [ `hostname | grep 'ygoda'` ]    ; then
    zstyle :prompt:pure:user color green
    zstyle :prompt:pure:host color green
elif [ `hostname | grep -v 'stg'` ] ; then
    zstyle :prompt:pure:user color yellow
    zstyle :prompt:pure:host color yellow
else
    zstyle :prompt:pure:user color magenta
    zstyle :prompt:pure:host color magenta
fi

prompt pure

# ------- bindkey
# Shift-Tabで候補を逆順に補完する
bindkey '^[[Z' reverse-menu-complete

# emacsモードを明示的に指定(環境変数によってviモードになるのを防ぐ)
# bindkey -e

# ------- autoload
## 補完機能
autoload -U compinit
compinit 
## 色
autoload -U colors
colors


# ------- prompt
## git status
autoload -Uz vcs_info
setopt prompt_subst
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "%F{yellow}!"
zstyle ':vcs_info:git:*' unstagedstr "%F{red}+"
zstyle ':vcs_info:*' formats "%F{green}%c%u(%b)%f"
zstyle ':vcs_info:*' actionformats '[%b|%a]'
precmd () { vcs_info }

## host color
# color="magenta"
# if   [ `hostname | grep 'prod'` ]    ; then
    # color="red"
# elif [ `hostname | grep -v 'stg` ] ; then
    # color="yellow"
# elif [ `hostname | grep 'dev'` ]    ; then
    # color="green"
# fi

# ------- option
## コマンド訂正
setopt correct

## 補完候補を詰めて表示する
setopt list_packed

## 補完候補をハイライトする
zstyle ':completion:*:default' menu select=2

## ヒストリーに重複を表示しない
setopt histignorealldups
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=$HISTSIZE

## ヒストリーファイルに実行時刻と実行時間も保存
setopt extended_history

## cdコマンドを省略して、ディレクトリ名のみの入力で移動
setopt auto_cd
chpwd() {
    ls_abbrev
}
ls_abbrev() {
    if [[ ! -r $PWD ]]; then
        return
    fi
    # -a : Do not ignore entries starting with ..
    # -C : Force multi-column output.
    # -F : Append indicator (one of */=>@|) to entries.
    local cmd_ls='ls'
    local -a opt_ls
    opt_ls=('-aCF' '--color=always')
    case "${OSTYPE}" in
        freebsd*|darwin*)
            if type gls > /dev/null 2>&1; then
                cmd_ls='gls'
            else
                # -G : Enable colorized output.
                opt_ls=('-aCFG')
            fi
            ;;
    esac

    local ls_result
    ls_result=$(CLICOLOR_FORCE=1 COLUMNS=$COLUMNS command $cmd_ls ${opt_ls[@]} | sed $'/^\e\[[0-9;]*m$/d')

    local ls_lines=$(echo "$ls_result" | wc -l | tr -d ' ')

    if [ $ls_lines -gt 10 ]; then
        echo "$ls_result" | head -n 5
        echo '...'
        echo "$ls_result" | tail -n 5
        echo "$(command ls -1 -A | wc -l | tr -d ' ') files exist"
    else
        echo "$ls_result"
    fi
}


## 補完候補を一覧で表示する
setopt auto_list

## =以降も補完
setopt magic_equal_subst

## バックグラウンド処理の状態変化を通知する
setopt notify

## zsh間で履歴を共有する
setopt share_history


# ------- stty
stty -ixon
stty erase 
stty erase 


# ------- function
## peco history
function peco-history-selection() {
    case ${OSTYPE} in
        darwin*)
            BUFFER=`history -n 1 | tail -r | awk '!a[$0]++' | peco`
        ;;
        linux*)
            BUFFER=`history -n 1 | tac | awk '!a[$0]++' | peco`
        ;;
    esac
    CURSOR=$#BUFFER
    zle reset-prompt
}

## ptvim
function ptvim() {
    t=$(pt $@ | peco --query "$LBUFFER" | awk -F : '{print "-c " $2 " " $1}')
    if [ -z $t ] ; then
        echo "\e[38;05;31mbye...\e[0m"
        return 1
    fi
    vim $(echo $t)
}

## findvim
function fvim() {
    f=$(find . -name $@ | peco --query "$LBUFFER")
    if [ -z $f ] ; then
        echo "\e[38;05;31mbye...\e[0m"
        return 1
    fi
    vim $(echo $f)
}

## wvim
function wvim() {
    which $@
    if [ $? -ne 0 ]; then
        echo "\e[38;05;31m$@ is not found...\e[0m"
        return
    fi
    vim  `which $@`
}

## color
function show-color() {
    for c in {016..255}; do echo -n "\e[38;5;${c}m $c" ; [ $(($((c-16))%6)) -eq 5 ] && echo;done;echo
}

## move directory by using z and peco
function peco-z-search
{
    which peco z > /dev/null
    if [ $? -ne 0 ]; then
      echo "Please install peco and z"
      return 1
    fi
    local res=$(z | sort -rn | cut -c 12- | peco)
    if [ -n "$res" ]; then
      BUFFER+="cd $res"
      zle accept-line
    else
      return 1
    fi
}
zle -N peco-z-search
bindkey '^o' peco-z-search
source ~/bin/z.sh

## update known_hosts(about known_hosts error -> http://qiita.com/grgrjnjn/items/8ca33b64ea0406e12938 )
function update-known-hosts() {
    ssh-keygen -R $1
}

## get UrlEncoded String
function urlencode {
  echo "$1" | nkf -WwMQ | tr = %
}

## gstart
function gstart {
    git branch | grep '* master' > /dev/null
    if [ $? -ne 0 ] ; then
        git checkout master
    fi
    if [ `git remote | grep upstream` ] ; then
        git pull upstream master
    else
        git pull origin master
    fi
    if [ -n "$1" ] ; then
        git checkout -b $1
    fi
}

# ------- alias
## common
alias ls='ls -FG --color'
alias lsa='ls -dltrFG .*'
alias ll='ls -ltrFG'
alias lsl=ll
alias grep='grep --color'
alias ssh='ssh -A'
alias hi='history'
alias ..='cd ..'
alias ...='cd ../..'
alias psp='ps aux | peco'
#alias tmake="PLATFORMS=$(build_platforms -64) make -f Makefile -j 4 "

## git
alias gl='git branch'
alias gch='git checkout'
alias grm='git clean -Xdf'
alias glog='git log --graph --date=short --decorate --pretty=format:"%Cgreen%h %Creset%cd %Cblue%cn %Cred%d %Creset%s"'
alias gc='git commit -am'
alias gs='git status'
alias gp='git push origin'
alias gpl='git pull origin'
