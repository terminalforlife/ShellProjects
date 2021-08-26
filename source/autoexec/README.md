# Introduction

Together with an editor like Vi-IMproved, EMACS, or even Nano, this Linux development tool allows the user the pleasure of programming in an IDE-like environment, surrounded by terminals. Simply touching (writing to) the file will result in the re-execution of it.

Flexibly, the user can make use of AutoExec in Linux when working with Perl, Python, Shell, AWK, and Ruby; this is, however, not a complete list, as it's very likely AutoExec can be used in multiple additional ways.

The user can either rely on AutoExec's own interpreter auto-detection, or override with his or her own choice of executable.

Demonstrations of AutoExec can be found all over the YouTube channel of the author of AutoExec, [Terminalforlife](https://www.youtube.com/c/terminalforlife) (formerly _Learn Linux_).

As you might've guessed by now, this tool was written for **Linux**, so likely will _not_ work on operating systems like the BSDs, Apple's offerings, and surely Windows (maybe with WSL). If you'd like to help support such a platform, get in touch, so that perhaps we can sort out a patch or some sort of compatibility update.

# Installation Instructions

Installation can be done with [Cito](https://github.com/terminalforlife/Extra/blob/master/source/cito). Your best bet, however, is to install via AutoExec's [installation script](https://github.com/terminalforlife/Extra/blob/master/source/autoexec/autoexec-installer).

For a quick terminal one-liner, using the aforementioned installation script, you should be able to execute the following, assuming you have sudo(8):

```sh
(cd /tmp; curl -so autoexec-installer 'https://raw.githubusercontent.com/terminalforlife/Extra/master/source/autoexec/autoexec-installer' && sudo \sh autoexec-installer; rm autoexec-installer)
```

If that fails, you probably don't have curl(1), so try wget(1):

```sh
(cd /tmp; wget -qO autoexec-installer 'https://raw.githubusercontent.com/terminalforlife/Extra/master/source/autoexec/autoexec-installer' && sudo \sh autoexec-installer; rm autoexec-installer)
```

If you don't have sudo(8), just omit it from the command(s) above, and run them as the `root` user, however you gain such privileges.

# Removing AutoExec

If you've used the installer, then you can run the following to delete the files it creates, including the '/usr/bin/ae' symlink created by the installer script:

```
sudo rm -v /usr/share/man/man1/autoexec.1.gz /usr/share/bash-completion/completions/autoexec /usr/bin/autoexec; [ -L /usr/bin/ae ] && sudo rm -v /usr/bin/ae; [ -L /usr/share/bash-completion/completions/ae ] && sudo rm -v /usr/share/bash-completion/completions/ae
```

If you don't have sudo(8), you'll have to acquire root privileges by other means.
