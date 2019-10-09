#!/usr/bin/zsh

PS1='%B%F{green}%@ %1d%f%b '

# for neofetch
export SHELL=/usr/bin/zsh

REMINDERS=~/Documents/reminders.txt
if [ -f "$REMINDERS" ]; then
  cat $REMINDERS
fi

# word boundaries in zsh different from bash; alt-d doesn't
# stop at /, see this
# https://unix.stackexchange.com/questions/258656/how-can-i-delete-to-a-slash-or-a-word-in-zsh
# update: simpler solution, though may not land on exact same character
# https://stackoverflow.com/questions/10847255/how-to-make-zsh-forward-word-behaviour-same-as-in-bash-emacs
autoload -U select-word-style
select-word-style bash

p () {
  # usage: path foo.txt
  FILE="$(readlink -f $1)"
  printf "$FILE\ncopied to clipboard\n"
  printf "$FILE" | xsel -bi
}

h () {
  if command -v $1 > /dev/null; then
    $1 --help | less
  else
    echo "command $1 doesn't exist"
  fi
}

# if laptop, show battery life in prompt
if [ $(cat /sys/class/dmi/id/chassis_type) -eq 10 ]; then
  setopt promptsubst
  PROMPT='$(</sys/class/power_supply/BAT0/capacity)'" $PS1"
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
