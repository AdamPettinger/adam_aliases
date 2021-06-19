#!/bin/bash

function text_red {
  echo -n -e "\e[00;31m" # red
}

function text_green {
  echo -n -e "\e[00;32m" # green
}

function text_blue {
  echo -n -e "\e[00;34m" # blue
}


function text_reset {
  echo -n -e "\e[00m"    # reset
}
