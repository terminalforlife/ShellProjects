# Introduction

Simple, lightweight, and portable command-line `i3-wm` and `i3-gaps` cheat sheet, supporting the ability to filter output.

# Caveat(s)

Unfortunately, CSi3 may not work on everyone's configuration file. If you have standard 'config' syntax and use the `bindsym` command, it should work swimmingly, but note that `$mod` and other variables, if used, will themselves be displayed in the list of bindings — for now. For an example of a configuration file with which CSi3 well behaves, check out my _i3Config_ repository here on my GitHub.

Modes are not currently (if ever) supported. Although the bindings should be listed, it would be without the context of the mode, unfortunately.

# Installation Instructions

Installation can be done with [Cito](https://github.com/terminalforlife/Extra/blob/master/source/cito). Your best bet, however, is to install via CSi3's [installation script](https://github.com/terminalforlife/Extra/blob/master/source/csi3/csi3-installer).

For a quick terminal one-liner, using the aforementioned installation script, you should be able to execute the following, assuming you have sudo(8):

```sh
(cd /tmp; curl -so csi3-installer 'https://raw.githubusercontent.com/terminalforlife/Extra/master/source/csi3/csi3-installer' && sudo \sh csi3-installer; rm csi3-installer)
```

If that fails, you probably don't have curl(1), so try wget(1):

```sh
(cd /tmp; wget -qO csi3-installer 'https://raw.githubusercontent.com/terminalforlife/Extra/master/source/csi3/csi3-installer' && sudo \sh csi3-installer; rm csi3-installer)
```

If you don't have sudo(8), just omit it from the command(s) above, and run them as the `root` user, however you gain such privileges.

# Removing CSi3

If you've used the installer, then you can run the following to delete the files it creates:

```
sudo rm -v /usr/share/man/man1/csi3.1.gz /usr/share/bash-completion/completions/csi3 /usr/bin/csi3
```

If you don't have sudo(8), you'll have to acquire root privileges by other means.
