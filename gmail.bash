# this is an example of a "window-dependent" bash function that you can bind to some key using xbindkeys or something
current_window_class_has_substring () {
  local id=`xdotool getactivewindow`
  if xprop WM_CLASS -id $id | grep $1 > /dev/null; then
    return 0 # true
  else
    return 1 # false
  fi
}

chrome-window-active () {
  if current_window_class_has_substring chrome; then
    return 0
  else
    return 1
  fi
}

if chrome-window-active; then
  google-chrome-stable 'https://mail.google.com/mail/u/0/#inbox'
fi
