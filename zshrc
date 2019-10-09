#!/usr/bin/zsh

PS1='%B%F{green}%@ %1d%f%b '

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
