# miscellaneous
Here you'll find my smaller projects, quick scripts, and some configuration files.

CONTENTS
--------

Some of these files are just quick and dirty scripts, but some are more fleshed out and program-like, so I have provided some installit installers for them. The instructions for those are as usual. Just substitute NAME for the name of the file/program you wish to install.

You'll find here my .vimrc file which I've enjoyed adding to. I'm not that great at vimscript, but I enjoy it and have written some useful plugins I now couldn't live without. I'll get better as time goes by, I'm sure, but I do tend to focus most of my attention on shell, leaving the rest on Linux in general.

I can't seem to stray far from my vim syntax highlighting color scheme. I was inspired by 256_noir. It's just so damn nice to look at, and helps me spot silly things like a forgotten brace, quote, or grave; I've included it too, if you're interested in checking that out; it's the tfl.vim file.

INSTALLATION
------------

Download and use the `install_NAME` installer by using this terminal command:

    wget -q https://raw.githubusercontent.com/terminalforlife/NAME/master/install_NAME

Now execute the installer with this:

    sudo bash install_NAME

Or if you prefer, make it executable, then more easily run it like so:

    chmod u+x install_NAME
    ./install_NAME

Example installation of NAME:

    ➤  chmod u+x install_NAME
    ➤  sudo ./install_NAME
    L096: Checking conflict: /usr/bin/NAME
    L108: Downloading here: /usr/bin/NAME
    L112: Correcting attributes: /usr/bin/NAME

Example uninstallation of NAME:

    ➤  sudo ./install_NAME --uninstall
    L087: Uninstalling program.
    L118: Sending to trash: /usr/bin/NAME
