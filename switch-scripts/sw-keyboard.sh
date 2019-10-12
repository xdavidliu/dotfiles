#!/usr/bin/env bash
wmctrl -a Keyboard || cinnamon-settings keyboard
# note for keyboard this is subtle, because if I do -x -a, the class is
# cinnamon-settings.py.Cinnamon-settings.py, so I need to grab by name, not
# class.
