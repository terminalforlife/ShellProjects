**MASTER** - _Hopefully stable branch._\
**DEV** - _Development Branch (latest changes)_

# Introduction to Extra

Thank you for your interest. Despite the non-descript name of this repository, it's actually full of a _lot_ of presentable, carefully-written shell programs.

Some of the programs within this repository were written and are maintained for a Bourne POSIX-compliant shell (with [Yash](https://yash.osdn.jp/) as guidance), and others are written for the Bourne Again Shell.

As of 2019-12-06, here are some highlights:

  * backmeup - A simple tool to quickly and easily back up your HOME.
  * libtflbp-sh - Bourne POSIX function library used by TFL programs.
  * lspkg - Test for, describe, and list out installed packages.
  * purgerc - Purge all 'rc' packages, as marked by DPKG.
  * rmne - POSIX Bourne method to remove non-essential Debian packages.
  * roks - Remove old kernel versions on an Ubuntu- or Debian-based system.
  * shlides - Present a project on your terminal via formatted slides.
  * ubuntu-syschk - Performs various non-root system health checks on Ubuntu and similar.

Continue to the next section to see how you can get them...

# Instructions for Installation

Some of the following commands tell you to use [sudo](https://en.wikipedia.org/wiki/Sudo), but not everybody _has_ that utility; if you're one of those special snowflakes, then you'll likely want to use [su](https://en.wikipedia.org/wiki/Su_\(Unix\)) prior to running the commands otherwise ran with sudo.

You have three options available to you, at the time of writing this:

  * You can install via one of the many Debian packages I've built and stored within the [DEB-Packages](https://github.com/terminalforlife/DEB-Packages) repository. This won't guarantee the latest version, however, but it's the easiest method, provided you're on a Debian-based installation of Linux.

    1. Browse [here](https://github.com/terminalforlife/DEB-Packages) to the DEB-Packages repository.
    2. Left-click on the package filename you want to download.
    3. Left-click on the 'Download' button or 'View raw' link.
    4. Choose location to download and store the Debian package.
    5. Open up a terminal either at or then browse to that location.
    6. Run: `sudo dpkg -i PKG` (where `PKG` is the package to install)

  * You can install via the new, exhaustive [Cito](https://github.com/terminalforlife/Extra/blob/master/cito) program I've written for just this purpose. It's lightweight, portable, and installable with a few commands, after which many one-file programs on GitHub are quick and painless to install -- not just my own!

    1. Open up a terminal, and keep it open until this is done.
    2. Run: `TempFile=$(mktemp); DomLink='https://raw.githubusercontent.com'`
    3. Run: `wget -qO "$TempFile" "$DomLink/terminalforlife/Extra/master/cito"`
    4. Run: `sudo chown 0:0 "$TempFile; sudo chmod 755 "$TempFile"`
    5. Run: `sudo mv "$TempFile" /usr/bin/`

  * It's clunky and it's inconvenient, but if you must, you can clone this repository then install them yourself, line-by-line.

    1. Open up a terminal, and keep it open until this is done.
    2. Make sure you have git installed. IE: `sudo apt-get install git`
    3. Run: `git clone 'https://github.com/terminalforlife/Extra'`
    4. Run: `cd Extra` to change to the newly-cloned directory.
    5. From here, it depends on the file you want. Hence: clunky method.

You should be ready to go, now. If you have any problems, don't hesitate to let me know, either here on GitHub, YouTube, or via the following E-Mail address: terminalforlife@yahoo.com
