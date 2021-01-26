**MASTER** - _Hopefully stable branch._\
**DEV** - _Development Branch (latest changes)_

# Introduction

These are files in each of which resides a function which _used_ to be included in various programs and standard shell scripts I'd written. These were therefore considered dependencies in those cases. These are actually not just any old functions, but pure-Bourne [POSIX-compliant](https://en.wikipedia.org/wiki/POSIX) functions.

However, these functions are **no longer used** and so have been phased out in favor of having them (or similar) in the programs themselves; this was mainly to make things easier for both maintenance and the user.

None-the-less, this is a handy project to peruse, for educational purposes. Users inexperienced with programming in Bourne Shell may find these functions useful as well, as it takes on some of the problems particularly a pure-shell programmer often faces.

# How to Use

Using these functions in your scripts is as easy as simply sourcing the scripts found in the '/usr/lib/libtflbp' directory.

For Example:

```sh
. /usr/lib/tflbp-sh/BaseName

BaseName '/usr/bin/apt-get'
```

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

# Uninstalling

A simple one-liner for uninstalling the scripts:

```sh
rm -r /usr/lib/tflbp-sh
```

You'll of course very likely need root access to perform this operation.
