**MASTER** - _Hopefully stable branch._\
**DEV** - _Development Branch (latest changes)_

# Introduction to Extra/source/libtflbp-sh

These are files in each of which resides a function used in various programs and standard shell scripts I've written and continue to write. These are therefore considered dependencies in those cases. However, these are actually not just any old functions, but pure-Bourne [POSIX-compliant](https://en.wikipedia.org/wiki/POSIX) functions.

A more detailed write-up will be here eventually -- grizzly bear with me!

# Installation Instructions

If you're on a Debian- or Ubuntu-based distribution of Linux, installation is no problem. Head on over to the [DEB-Packages](https://github.com/terminalforlife/DEB-Packages) repository, then download then install the `libtflbp-sh` package.

Otherwise, execute the following, assuming you have sudo(8):

```sh
curl -s 'https://raw.githubusercontent.com/terminalforlife/Extra/master/source/libtflbp-sh/source/tflbp-installer' | sudo sh
```

If that fails, you probably don't have curl(1), so try wget(1):

```sh
wget -qO - 'https://raw.githubusercontent.com/terminalforlife/Extra/master/source/libtflbp-sh/source/tflbp-installer' | sudo sh
```

If you don't have sudo(8), just omit it from the command(s) above, and run them as the `root` user, however you gain such privileges.
