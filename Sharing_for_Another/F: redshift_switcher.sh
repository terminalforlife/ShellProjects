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
level_status=`< "$log_file"`

set_level_four () {
  redshift -o -b 0.9 -t 4700:4700
  echo "four" > "$log_file"
}

set_level_three () {
  redshift -o -b 0.8 -t 4700:4700
  echo "three" > "$log_file"
}

set_level_two () {
  redshift -o -b 0.7 -t 3900:3900
  echo "two" > "$log_file"
}

set_level_one () {
  redshift -o -b 0.6 -t 3200:3200
  echo "one" > "$log_file"
}

case "$1" in
  decrease)
    case "$level_status" in
      four)
        set_level_three ;;
      three)
        set_level_two ;;
      two)
        set_level_one ;;
    esac ;;
  increase)
    case "$level_status" in
      one)
        set_level_two ;;
      two)
        set_level_three ;;
      three)
        set_level_four ;;
    esac
esac
