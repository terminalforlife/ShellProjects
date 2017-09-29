CONTENTS
--------

Here you'll find scripts to automatically run at given intervals, using cron. These can however be used on their own, perhaps as a keyboard shortcut, or a startup item.

INSTALLATION
------------

Installation should be pretty simple for these scripts. They will of course assume you have cron installed and set up. Some will have different requirements, per the task at hand, but they will all be primarily targeting GNU/Linux.

To set up a cron job which you see listed here in this directory under the miscellaneous repository, you can do the following to download and use it, where NAME is the filename of the script/program:

    wget -q https://raw.githubusercontent.com/terminalforlife/miscellaneous/master/Cron%20Tasks/NAME
    sudo chown 0:0 NAME
    sudo chmod 500 NAME
    sudo mv NAME /etc/cron.hourly/
