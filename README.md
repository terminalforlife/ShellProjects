**MASTER** - _Hopefully stable branch._\
**DEV** - _Development Branch (latest changes)_

# Introduction to Extra

Thank you for your interest. Despite the non-descript name of this repository, it's actually full of a _lot_ of presentable, carefully-written shell programs.

Some of the programs within this repository were written and are maintained for a Bourne POSIX-compliant shell (with [Yash](https://yash.osdn.jp/) as guidance), and others are written for the Bourne Again Shell.

As of 2019-12-07, here are some highlights:

  * backmeup - A simple tool to quickly and easily back up your HOME.
  * cito - Bourne POSIX installer for local or GitHub files.
  * libtflbp-sh - Bourne POSIX function library used by TFL programs.
  * lspkg - Test for, describe, and list out installed packages.
  * purgerc - Purge all 'rc' packages, as marked by DPKG.
  * rmne - POSIX Bourne method to remove non-essential Debian packages.
  * roks - Remove old kernel versions on an Ubuntu- or Debian-based system.
  * shlides - Present a project on your terminal via formatted slides.
  * ubuntu-syschk - Performs various non-root system health checks on Ubuntu and similar.

Continue to the next section to see how you can get them...

# Instructions for Installation

Before I begin, some of these programs, including Cito, depend on `libtflbp-sh` (get it [here](https://github.com/terminalforlife/Extra/tree/master/source/libtflbp-sh)).

Some of the following commands tell you to use [sudo](https://en.wikipedia.org/wiki/Sudo), but not everybody _has_ that utility; if you're one of those special snowflakes, then you'll likely want to use [su](https://en.wikipedia.org/wiki/Su_\(Unix\)) prior to running the commands otherwise ran with sudo.

You have four options available to you, at the time of writing this:

  * You can install via one of the many Debian packages I've built and stored within the [DEB-Packages](https://github.com/terminalforlife/DEB-Packages) repository. This won't guarantee the latest version, however, but it's the easiest method, provided you're on a Debian-based installation of Linux, and as of 2019-12-10, multiple versions will become available for the foreseeable future.

  * You can install via the new, exhaustive [Cito](https://github.com/terminalforlife/Extra/blob/master/source/cito) program I've written for just this purpose. It's lightweight, portable, and installable with the following one-liner, after which many programs or files on GitHub or locally are quick, robust, and painless to install -- not just my own!

    ```bash
    wget -qO cito 'https://raw.githubusercontent.com/terminalforlife/Extra/master/source/cito'; sudo sh cito cito
    ```

  * If you're on a Debian- or Ubuntu-based distribution of Linux:

    ```bash
    wget -qO cito.deb 'https://raw.githubusercontent.com/terminalforlife/DEB-Packages/master/cito/cito.deb'; sudo dpkg -i cito.deb; rm cito.deb
    ```

  * It's clunky and it's inconvenient, but if you must, you can clone this repository then install them yourself, line-by-line.

    1. Open up a terminal, and keep it open until this is done.
    2. Make sure you have git installed. IE: `sudo apt-get install git`
    3. Run: `git clone 'https://github.com/terminalforlife/Extra'`
    4. Run: `cd Extra` to change to the newly-cloned directory.
    5. From here, it depends on the file you want. Hence: clunky method.

You should be ready to go, now. If you have any problems, don't hesitate to let me know, either here on GitHub, YouTube, or via the following E-Mail address: terminalforlife@yahoo.com
