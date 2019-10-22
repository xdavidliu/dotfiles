#!/usr/bin/env bash

REMINDERS=~/Documents/reminders.txt
if [ -f "$REMINDERS" ]; then
  cat $REMINDERS
fi

# TODO: add ssh key for git pushing to my github dotfiles

alias t='type'
alias h='generalized_help'
alias p='copy_path_to_clipboard'
alias u='pull_dotfiles_from_github'
alias y='commit_and_push_dotfiles_to_github'

pull_dotfiles_from_github () {
  cd ~/dotfiles
  git pull origin master
}

commit_and_push_dotfiles_to_github () {
  cd ~/dotfiles
  git commit -a && git push origin master
}

copy_path_to_clipboard () {
  # usage: path foo.txt
  FILE="$(readlink -f $1)"
  printf "$FILE\ncopied to clipboard\n"
  printf "$FILE" | xsel -bi
}

generalized_help () {
  if command -v $1 > /dev/null; then
    $1 --help |& less
  else
    echo "command $1 doesn't exist"
  fi
}

# the if statement checks if we are on a laptop
# this works for Debian at least, not sure if works for Arch
# superuser.com/questions/877677/
# checking battery gives false positive for ubuntu desktop
if [ $(cat /sys/class/dmi/id/chassis_type) -eq 10 ]; then
  # display battery percentage before each PS1
  PROMPT_COMMAND='echo -n $(</sys/class/power_supply/BAT0/capacity)'
  night () {
    local temp=${2:-4800}
    local bright=${1:-1}
    redshift -P -O $temp -b $bright > /dev/null
    echo "setting color temperature to $temp"
    echo "setting brightness to $bright"
    echo "if brightness is less than 1, make sure 'dim 1' is done first"
  }
  dim () {
    local FILE=/sys/class/backlight/intel_backlight/brightness
    echo "current brightness is $(cat $FILE)"
    if [ $# -ne 0 ]; then
      echo "setting brightness to $1..."
      sudo su -c "echo $1 > $FILE"
      echo 'done!'
    fi
  }
fi
