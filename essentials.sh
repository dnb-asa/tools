#!/bin/bash

xcode-select --install || true
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
brew tap caskroom/cask
brew cask install intune-company-portal
brew cask install microsoft-office
brew cask install microsoft-teams
brew cask install slack
