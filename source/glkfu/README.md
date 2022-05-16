# Introduction

Simplify the process of compiling and building Debian images and headers for the latest available stable Linux kernel, so downloaded from the official kernel.org website.

While this is still more of an advanced approach to setting up the Linux kernel in Debian- and Ubuntu-based distributions of Linux, **GLKFU** does make this process much easier, quicker, and more user-friendly.

No actual installation of the resulting Debian packages will be performed; this is intentionally left to the responsibility of the user.

You don't even have to compile & build packages for Linux using **GLKFU**, as you can choose to simply download the tarball, or even simply check if a new version is available. Plenty of options are available.

# Installation Instructions

Installation can be done with [Cito](https://github.com/terminalforlife/Extra/blob/master/source/cito). Your best bet, however, is to install via GLKFU's [installation script](https://github.com/terminalforlife/Extra/blob/master/source/glkfu/glkfu-installer).

For a quick terminal one-liner, using the aforementioned installation script, you should be able to execute the following, assuming you have sudo(8):

```sh
(cd /tmp; curl -so glkfu-installer 'https://raw.githubusercontent.com/terminalforlife/Extra/master/source/glkfu/glkfu-installer' && sudo \sh glkfu-installer; rm glkfu-installer)
```

If that fails, you probably don't have curl(1), so try wget(1):

```sh
(cd /tmp; wget -qO glkfu-installer 'https://raw.githubusercontent.com/terminalforlife/Extra/master/source/glkfu/glkfu-installer' && sudo \sh glkfu-installer; rm glkfu-installer)
```

If you don't have sudo(8), just omit it from the command(s) above, and run them as the `root` user, however you gain such privileges.

# Removing GLKFU

If you've used the installer, then you can run the following to delete the files it creates, including the '/usr/bin/ae' symlink created by the installer script:

```
sudo rm -v /usr/share/bash-completion/completions/glkfu /usr/bin/glkfu /usr/bin/glkfu-list /usr/bin/glkfu-changes /usr/share/man/man1/glkfu.1.gz
```

If you don't have sudo(8), you'll have to acquire root privileges by other means.

# Dependencies for Compilation & Package Building

**bc** - GNU bc arbitrary precision calculator language\
**bison** - YACC-compatible parser generator\
**build-essential** - Informational list of build-essential packages\
**fakeroot** - tool for simulating superuser privileges\
**flex** - fast lexical analyzer generator\
**libelf-dev** - libelf1 development libraries and header files\
**libssl-dev** - Secure Sockets Layer toolkit - development files\
**rsync** - fast, versatile, remote (and local) file-copying tool

If you spot a dependency neither listed here nor checked for by **GLKFU**, please get in touch so this can be addressed.

# Bugs

Bugs will be handled as soon as possible, but you can speed things up by reporting them. I cannot fix what I don't know exists! Please refer to the **GLKFU** man page (`man glkfu`) and refer to the **BUGS** section.
