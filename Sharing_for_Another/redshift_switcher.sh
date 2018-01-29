#!/bin/bash

# You need to add startup item which sets a level,
# exporting the status to log file, example:
# bash -c "redshift -o -l 0:0 -b 0.7 -t 3900:3900; echo two > $HOME/.red_status.log"
#
# Both keyboard shortcuts run this script, example:
# bash -c "$HOME'/Scripts/redshift_keyboard_shortcuts.sh' decrease"
# bash -c "$HOME'/Scripts/redshift_keyboard_shortcuts.sh' increase"
# I'm using the keys Ctrl+Shift+1 for decrease, and Ctrl+Shift+2 for increase
# or Alt + PgDn, Alt + PgUp
#
# Adjust your levels accordingly, redshift options:
#  -b is for brightness (max value is 1.0)
#  -t is for temperature (normal is 6500, set lower value for less blue).
#

log_file="$HOME/.red_status.log"
level_status=$(echo "$(<"$log_file")")

set_level_four () {
  redshift -o -l 0:0 -b 0.9 -t 4700:4700
  echo "four" > "$log_file"
}

set_level_three () {
  redshift -o -l 0:0 -b 0.8 -t 4700:4700
  echo "three" > "$log_file"
}

set_level_two () {
  redshift -o -l 0:0 -b 0.7 -t 3900:3900
  echo "two" > "$log_file"
}

set_level_one () {
  redshift -o -l 0:0 -b 0.6 -t 3200:3200
  echo "one" > "$log_file"
}

decrease_level () {
  if [ "$level_status" = "four" ]
  then
    set_level_three
  elif [ "$level_status" = "three" ]
  then
    set_level_two
  elif [ "$level_status" = "two" ]
  then
    set_level_one
  fi
}

increase_level () {
  if [ "$level_status" = "one" ]
  then
    set_level_two
  elif [ "$level_status" = "two" ]
  then
    set_level_three
  elif [ "$level_status" = "three" ]
  then
    set_level_four
  fi
}

if [ "$1" = "decrease" ]
then
  decrease_level
elif [ "$1" = "increase" ]
then
  increase_level
fi
