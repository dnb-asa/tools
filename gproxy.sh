#!/bin/bash

red='\033[0;31m'
no_color='\033[0m'

if [ "$EUID" -ne 0 ]; then
    echo "${red}Error: Please run as root${no_color}"
    exit
fi

if [ -f "~/.ssh/id_rsa.pub" ]; then
    $(ssh-keygen -t rsa -b 4096 && ssh-add ~/.ssh/id_rsa)
fi

pbcopy <~/.ssh/id_rsa.pub
echo -e "Copied public key to clipboard\n"

echo -e "\nHost gitproxy
    Hostname gitproxy.ccoe.cloud
    ServerAliveInterval 10
    ServerAliveCountMax 3
    LocalForward 9000 git.tech-01.net:22
	LocalForward 443 sonar.tech.dnb.no:443
	LocalForward 443 nexus.tech.dnb.no:443
    ControlMaster auto
    ControlPath ~/.ssh/sockets/%r@%h:%p
    Port 443
    User git

Host git.tech-01.net
    HostName localhost
    StrictHostKeyChecking no
    Port 9000
" >>~/.ssh/config

echo '127.0.0.1 localhost sonar.tech.dnb.no nexus.tech.dnb.no' >>/etc/hosts

config="\nalias gproxy='sudo ssh -f -nNT gitproxy'
alias gproxy-status='sudo ssh -O check gitproxy'
alias gproxy-off='sudo ssh -O exit gitproxy'\n"

echo -e "Copy the below to your shell profile: \n$config"

echo "
Restart your shell for the changes to take effect.
To run gproxy, type gproxy in your terminal.
"
