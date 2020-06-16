#!/bin/bash

cyan='\033[4;36m'
red='\033[0;31m'
no_color='\033[0m'

default_version="android-29"
default_build_tools="29.0.3"
android_version=${1:-$default_version}
build_tools=${2:-$default_build_tools}

brew tap adoptopenjdk/openjdk
brew cask install adoptopenjdk8
brew install ant
brew install maven
brew install gradle
brew cask install android-sdk
brew cask install android-ndk
brew cask install flipper
brew cask install intel-haxm
brew cask install figma

touch ~/.android/repositories.cfg || true
sdkmanager --update
sdkmanager "platform-tools" "platforms;$android_version"
sdkmanager "build-tools;$build_tools"

config="\nexport ANDROID_HOME=/usr/local/opt/android-sdk
export ANDROID_NDK_HOME=/usr/local/opt/android-ndk"

if [ $SHELL = '/bin/bash' ]; then
	echo -e "\n$config" >>~/.bash_profile
elif [ $SHELL = '/bin/zsh' ]; then
	echo -e "\n$config" >>~/.zshrc
else
	echo -e "\nCould not find shell. Add ${cyan}ANDROID_HOME${no_color} to your ${cyan}PATH${no_color} manually"
fi
