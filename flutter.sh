#!/bin/bash

cyan='\033[4;36m'
red='\033[0;31m'
no_color='\033[0m'

git clone https://github.com/flutter/flutter.git

config="export PATH=\$PATH:$(pwd)/flutter/bin"

if [ $SHELL = '/bin/bash' ]; then
	echo -e "\n$config" >>~/.bash_profile
elif [ $SHELL = '/bin/zsh' ]; then
	echo -e "\n$config" >>~/.zshrc
else
	echo -e "Could not find shell. Add the following to your shell config: \n${cyan}$config${no_color}\n"
	exit
fi

eval $config

flutter doctor -v
