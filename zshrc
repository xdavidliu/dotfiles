#!/usr/bin/zsh

PS1='%B%F{green}%@ %1d%f%b '

# for neofetch
export SHELL=/usr/bin/zsh

REMINDERS=~/Documents/reminders.txt
if [ -f "$REMINDERS" ]; then
  cat $REMINDERS
fi


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
