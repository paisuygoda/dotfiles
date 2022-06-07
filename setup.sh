#!/bin/zsh

BASE_URL='https://raw.githubusercontent.com/paisuygoda/dotfiles/main'
DELETE_FILE='';

echo -e "\n \e[38;05;228m[${0##*/}] Excecuting fetch scripts..."

#-------------------------------------
#                zsh
#-------------------------------------
echo -e "\e[38;05;147m---------------->>> fetch zsh setting"
echo -e " .zprezto"
echo -e " .zprofile"
echo -e " .zshrc"

if [ -e /home/`whoami`/.zprofile ] ; then
    DELETE_FILE=$DELETE_FILE"delete old .zprofile\n"
    rm  /home/`whoami`/.zprofile*
fi
if [ -e /home/`whoami`/.zshrc ] ; then
    DELETE_FILE=$DELETE_FILE"delete old .zshrc\n"
    rm  /home/`whoami`/.zshrc*
fi
if [ -e /home/`whoami`/.zfunctions ] ; then
    DELETE_FILE=$DELETE_FILE"delete old .zfunctions\n"
    rm  /home/`whoami`/.zfunctions*
else
    mkdir ~/.zfunctions
fi
echo -e -n "\e[38;05;244m"
wget --no-verbose $BASE_URL/.zfunctions/pure.zsh -P ~/.zfunctions
wget --no-verbose $BASE_URL/.zfunctions/async.zsh -P ~/.zfunctions
ln -s ~/.zfunctions/pure.zsh ~/.zfunctions/prompt_pure_setup
ln -s ~/.zfunctions/async.zsh ~/.zfunctions/async
wget --no-verbose $BASE_URL/.zprofile
wget --no-verbose $BASE_URL/.zshrc

#-------------------------------------
#                vim
#-------------------------------------
echo -e "\n\e[38;05;147m---------------->>> fetch vim setting"
echo -e ".vimrc"
echo -e ".vim/colors"

if [ -e /home/`whoami`/.vimrc ] ; then
    DELETE_FILE=$DELETE_FILE"delete old .vimrc\n"
    rm  /home/`whoami`/.vimrc*
fi
echo -e -n "\e[38;05;244m"
wget --no-verbose $BASE_URL/.vimrc
wget --no-verbose $BASE_URL/.vim/colors/molokai.vim -P ./.vim/colors

#-------------------------------------
#                tmux
#-------------------------------------
echo -e "\n\e[38;05;147m---------------->>> fetch tmux setting"
echo -e ".tmux.conf"

if [ -e /home/`whoami`/.tmux.conf ] ; then
    DELETE_FILE=$DELETE_FILE"delete old .tmux.conf\n"
    rm  /home/`whoami`/.tmux.conf*
fi
echo -e -n "\e[38;05;244m"
wget --no-verbose $BASE_URL/.tmux.conf

#-------------------------------------
#               login.sql
#-------------------------------------
echo -e "\n\e[38;05;147m---------------->>> fetch login.sql setting"
echo -e "login.sql"

if [ -e /home/`whoami`/login.sql ] ; then
    DELETE_FILE=$DELETE_FILE"delete old login.sql\n"
    rm  /home/`whoami`/login.sql
fi
echo -e -n "\e[38;05;244m"
wget --no-verbose $BASE_URL/login.sql

#-------------------------------------
#               dir_colors
#-------------------------------------
echo -e "\n\e[38;05;147m---------------->>> fetch dir_colors setting"
echo -e ".dir_colors.conf"

if [ -e /home/`whoami`/.dir_colors ] ; then
    DELETE_FILE=$DELETE_FILE"delete old .dir_colors\n"
    rm  /home/`whoami`/.dir_colors*
fi
echo -e -n "\e[38;05;244m"
wget --no-verbose $BASE_URL/.dir_colors

#-------------------------------------
#               peco
#-------------------------------------
echo -e "\n\e[38;05;147m---------------->>> fetch peco setting"

if [ -e /home/`whoami`/.peco ] ; then
    DELETE_FILE=$DELETE_FILE"delete old peco setting\n"
    rm  /home/`whoami`/.peco/config.json
fi

echo -e -n "\e[38;05;244m"
wget --no-verbose $BASE_URL/.peco/config.json    -P ./.peco

#-------------------------------------
#                tools
#-------------------------------------
echo -e "\n\e[38;05;147m---------------->>> fetch tools(pt,peco,z)"
echo -e "tools"

if [ -e /home/`whoami`/bin/pt ] ; then
    DELETE_FILE=$DELETE_FILE"delete old pt\n"
    rm  /home/`whoami`/bin/pt*
fi
if [ -e /home/`whoami`/bin/peco ] ; then
    DELETE_FILE=$DELETE_FILE"delete old peco\n"
    rm  /home/`whoami`/bin/peco*
fi
if [ -e /home/`whoami`/bin/z.sh ] ; then
    DELETE_FILE=$DELETE_FILE"delete old z.sh\n"
    rm  /home/`whoami`/bin/z.sh*
fi
echo -e -n "\e[38;05;244m"
wget --no-verbose $BASE_URL/tools/pt             -P ./bin
wget --no-verbose $BASE_URL/tools/peco           -P ./bin
wget --no-verbose $BASE_URL/tools/z.sh           -P ./bin
chmod +x ./bin/*

if [ ! -e /home/`whoami`/multissh.sh ] ; then
    wget --no-verbose $BASE_URL/multissh.sh
    chmod +x multissh.sh
fi

#--------------------------------------------
#                bash (to start zsh)
#--------------------------------------------

if [ -e /home/`whoami`/.bashrc ] ; then
    DELETE_FILE=$DELETE_FILE"delete old .bashrc\n"
    rm  /home/`whoami`/.bashrc*
fi
wget --no-verbose $BASE_URL/.bashrc


if [ -e /home/`whoami`/.bash_profile ] ; then
    DELETE_FILE=$DELETE_FILE"delete old .bash_profile\n"
    rm  /home/`whoami`/.bash_profile*
fi

if [ $# -lt 1 ] ; then
    wget --no-verbose $BASE_URL/.bash_profile_bash -O .bash_profile
else
    wget --no-verbose $BASE_URL/.bash_profile
fi


#--------------------------------------------
#             git config
#--------------------------------------------

if [ -e /home/`whoami`/.gitconfig ] ; then
    DELETE_FILE=$DELETE_FILE"delete old .gitconfig\n"
    rm  /home/`whoami`/.gitconfig*
fi
wget --no-verbose $BASE_URL/.gitconfig

echo -e "\n\e[38;05;43m$DELETE_FILE\e[0m"
echo -e "\e[38;05;228m[${0##*/}]Done.\e[0m"
