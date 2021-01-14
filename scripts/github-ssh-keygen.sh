#!/bin/bash

# Generating a new SSH key
if [ ! -r ~/.ssh/github_rsa ]; then
  ssh-keygen -t rsa -b 4096 -C "lynyujiang@hotmail.com" -f ~/.ssh/github_rsa -q
fi

# Downloads and installs xclip.
command_exists() {
  type "$1" &>/dev/null
}

if ! command_exists xclip; then
  echo 'xclip not installed ... installing now!'
  sudo apt-get install -y xclip
fi

# Copies the contents of the id_rsa.pub file to your clipboard
xclip -sel clip <~/.ssh/github_rsa.pub

# Add the SSH key to your GitHub account.
echo "Add the SSH key to your GitHub account."
read -n 1 -s -r -p "Press any key to continue"

# Check that you are connecting to the correct server
ssh -vT git@github.com
