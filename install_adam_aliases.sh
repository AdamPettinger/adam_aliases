#!/bin/bash

working_dir=$(pwd)
echo "Installing with directory: "$working_dir

# # Check for previous install by looking to see if .adam_aliases/ already exists
DIR="$working_dir/.adam_aliases/"
if [ -d "$DIR" ]; then
  echo -n -e "\e[00;31m"
  echo "It looks like you've already run this install script"
  echo "Skipping the install this time!"
  echo -n -e "\e[00m"
  exit -1 # TODO allow force install?
fi

mkdir .adam_aliases
touch .adam_aliases/current_user

read -p "Enter your desired username. Should be unique! " username
username=$(echo $username | sed 's/ //g')
echo "Setting username: " $username

echo -n -e "\e[00;31m" # red
echo "TEST"
echo -n -e "\e[00;32m" # green
echo "TEST"
echo -n -e "\e[00;34m" # blue
echo "TEST"
echo -n -e "\e[00m"    # reset
echo "TEST"
