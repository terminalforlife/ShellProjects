# Introduction

This seems to be an oft-requested feature in Linux Mint, so I thought I'd have a bash (pun intended) at writing something which will effectively work as a daemon to auto-set values based on the time of day.

This program is strictly for Linux Mint Cinnamon. Currently, LMDE is _not_ supported.

Originally, this was a basic script, but is now a nice little tool for Linux Mint Cinnamon users. A video on the original script can be found [here](https://www.youtube.com/watch?v=tjzuHOiwfIA), on YouTube.

# Installation Instructions

Installation can be done with [Cito](https://github.com/terminalforlife/Extra/blob/master/source/cito). Your best bet, however, is to install via LMC-DarkLight's [installation script](https://github.com/terminalforlife/Extra/blob/master/source/lmc-darklight/lmc-darklight-installer).

For a quick terminal one-liner, using the aforementioned installation script, you should be able to execute the following, assuming you have sudo(8):

```sh
(cd /tmp; curl -so lmc-darklight-installer 'https://raw.githubusercontent.com/terminalforlife/Extra/master/source/lmc-darklight/lmc-darklight-installer' && sudo \sh lmc-darklight-installer; rm lmc-darklight-installer)
```

If that fails, you probably don't have curl(1), so try wget(1):

```sh
(cd /tmp; wget -qO lmc-darklight-installer 'https://raw.githubusercontent.com/terminalforlife/Extra/master/source/lmc-darklight/lmc-darklight-installer' && sudo \sh lmc-darklight-installer; rm lmc-darklight-installer)
```

If you don't have sudo(8), just omit it from the command(s) above, and run them as the `root` user, however you gain such privileges.

# Removing LMC-DarkLight

If you've used the installer, then you can run the following to delete the files it creates:

```
sudo rm -v /usr/share/bash-completion/completions/lmc-darklight /usr/share/man/man1/lmc-darklight.1.gz /usr/bin/lmc-darklight
```

If you don't have sudo(8), you'll have to acquire root privileges by other means.
