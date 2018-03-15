#!/bin/sh
# Basic bootstrap script that installs librarian-puppet and uses it to fetch
# Puppet modules. This script assumes a RedHat-derived or Debian-derived distribution.

    
OS=$(cat /etc/os-release  | grep "ID_LIKE" | cut -d"=" -f 2)

BINGIT=$(type -p git)

# Install 
if [ $OS = "debian" ] && [ ! -x /usr/bin/git ]; then
    echo "Install on Debian like system"
    apt-get install -y -q git rubygems ruby-dev gcc
    sleep 4 
elif [ ! $OS = "debian" ] && [ ! -x /usr/bin/git ]; then
    echo "Install in RedHat like system"
    yum install -y -q git-core rubygems ruby-devel gcc
    sleep 4
fi

# vim: set ft=sh ts=2 sw=2 ei: