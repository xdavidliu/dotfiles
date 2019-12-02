#!/usr/bin/env bash

# TODO: have commands and aliases that open emacsclient also use wmctrl
# to switch to the emacs window

REMINDERS=~/Documents/reminders.txt
if [ -f "$REMINDERS" ]; then
  cat $REMINDERS
fi

# TODO: add ssh key for git pushing to my github dotfiles

alias a=alias
alias t=type
alias h=generalized_help
alias p=copy_path_to_clipboard
alias u=pull_dotfiles_from_github
alias y=commit_and_push
alias e=open_emacsclient_ampersand
alias gs='git status'
alias xo=xdg-open


alias cdd=cd_to_containing_dir

cd_to_containing_dir () {
  cd $(dirname "$1")
}

# TODO: Use org-mode to collapse comments.
# TODO: Remove existing PS1 settings and write new ones using this.
ansi_colorize () {
  # Make text colored. Usages:
  # echo -e "$(ansi_colorize foo bar baz)"
  #   ^ prints 'foo bar baz' in red
  # printf "$(ansi_colorize foo bar baz)\n"
  #   ^ prints 'foo bar baz' in red
  # PS1="$(ansi_colorize ' \W \@ ')"
  #   ^ sets PS1 prompt to red with current directory and time.
  # TODO: Use a switch statement or associative array to get the "main" colors.
  local code=31 # Red; see Wikipedia for 'Ansi Escape Codes'.
  echo "\033[01;${code}m$*\033[0m"
  # We use echo, without -e, in order to return the raw string when used with
  # $(...), since bash has no return statements.
  # The $* allows colorizing unquoted multiple arguments.
  # The double quotes may prevent arbitrary code execution, though I currently
  # cannot think of any examples.
  # This format was taken from the default bashrc from Ubuntu.
  # Note the original had \[ and \], which are optional for PS1, but
  # printed literally if used with printf or echo -e, so it's strictly better
  # to omit them.
  # \033 is the octal for the ESC ASCII character.
  # Using \x1b instead of the octal works exactly the same.
}

open_emacsclient_ampersand () {
  emacsclient ${1-~/Documents} -a emacs >& /dev/null &
}

pull_dotfiles_from_github () {
  (
    cd ~/dotfiles
    git pull origin master
  )
}

commit_and_push () {
  git commit -a -m 'change some stuff' && git push origin master
}

copy_path_to_clipboard () {
  # usage: path foo.txt
  FILE="$(readlink -f $1)"
  printf "$FILE\ncopied to clipboard\n"
  printf "$FILE" | xsel -bi
}

generalized_help () {
  if type $1 | grep 'shell builtin' >& /dev/null; then
    help $1 |& less
  elif command -v $1 > /dev/null; then
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
