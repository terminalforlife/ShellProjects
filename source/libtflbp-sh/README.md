**MASTER** - _Hopefully stable branch._\
**DEV** - _Development Branch (latest changes)_

# Introduction to Extra/source/libtflbp-sh

These are files in each of which resides a function which _used_ to be included in various programs and standard shell scripts I'd written. These were therefore considered dependencies in those cases. However, these are actually not just any old functions, but pure-Bourne [POSIX-compliant](https://en.wikipedia.org/wiki/POSIX) functions.

# Installation Instructions

If you're on a Debian- or Ubuntu-based distribution of Linux, installation is no problem. Head on over to the [DEB-Packages](https://github.com/terminalforlife/DEB-Packages) repository, download one of the packages, then install it.

Otherwise, execute the following, assuming you have sudo(8):

```sh
(cd /tmp; curl -so tflbp-installer 'https://raw.githubusercontent.com/terminalforlife/Extra/master/source/libtflbp-sh/source/tflbp-installer' && sudo \sh tflbp-installer; rm tflbp-installer)
```

If that fails, you probably don't have curl(1), so try wget(1):

```sh
(cd /tmp; wget -qO tflbp-installer 'https://raw.githubusercontent.com/terminalforlife/Extra/master/source/libtflbp-sh/source/tflbp-installer' && sudo \sh tflbp-installer; rm tflbp-installer)
```

If you don't have sudo(8), just omit it from the command(s) above, and run them as the `root` user, however you gain such privileges.
