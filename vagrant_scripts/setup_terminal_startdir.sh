#!/usr/bin/env bash

# This script needs to run with option privileged: false

# START_DIR
if [ -z ${START_DIR+x} ]; then START_DIR=~; else echo "Override START_DIR='$START_DIR'."; fi


if [[ ! -s "$HOME/.bash_profile" && -s "$HOME/.profile" ]] ; then
  profile_file="$HOME/.profile"
else
  profile_file="$HOME/.bash_profile"
fi

profile_line="cd \"${START_DIR}\""

if ! grep -q "${profile_line}" "${profile_file}" ; then
  echo "Editing ${profile_file} to start in directory ${START_DIR} after Terminal launch."
  echo "${profile_line}" >> "${profile_file}"
  echo "ls" >> "${profile_file}"
fi