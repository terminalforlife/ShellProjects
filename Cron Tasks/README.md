CONTENTS
--------

Here you'll find scripts to automatically run at given intervals, using cron. These can however be used on their own, perhaps as a keyboard shortcut, or a startup item.

INSTALLATION
------------

Installation should be pretty simple for these scripts. They will of course assume you have cron installed and set up. Some will have different requirements, per the task at hand, but they will all be primarily targeting GNU/Linux.

How you install a cron job found here, depends on the task. If it's global (such as notify-upgrade) and needs root access, then you'll want to follow the instructions here:

    wget -q https://raw.githubusercontent.com/terminalforlife/miscellaneous/master/Cron%20Tasks/NAME
    sudo chown 0:0 NAME
    sudo chmod 500 NAME
    sudo mv NAME /etc/WHEN

Where NAME is the filename of the script, and WHEN is when the script is to be executed. Common available WHEN options:

    cron.daily/      # Every day.
    cron.hourly/     # Every hour.
    cron.weekly/     # Every week.
    cron.monthly/    # Every month.

If, however, the task is perhaps not so global and/or doesn't require root permissions, then you'll have to figure that out yourself, as I don't tend to use cron unless it's one of the /etc/cron.* directories, so I'm not too familiar with that process.
