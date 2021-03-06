# Introduction

Add to or remove from a simple list of remote files which you can then download in bulk, with Fetcher. The actual downloading is handled by wget(1).

# Installation Instructions

Installation can be done with [Cito](https://github.com/terminalforlife/Extra/blob/master/source/cito). Your best bet, however, is to install via Fetcher's [installation script](https://github.com/terminalforlife/Extra/blob/master/source/fetcher/fetcher-installer).

For a quick terminal one-liner, using the aforementioned installation script, you should be able to execute the following, assuming you have sudo(8):

```sh
(cd /tmp; curl -so fetcher-installer 'https://raw.githubusercontent.com/terminalforlife/Extra/master/source/fetcher/fetcher-installer' && sudo \sh fetcher-installer; rm fetcher-installer)
```

If that fails, you probably don't have curl(1), so try wget(1):

```sh
(cd /tmp; wget -qO fetcher-installer 'https://raw.githubusercontent.com/terminalforlife/Extra/master/source/fetcher/fetcher-installer' && sudo \sh fetcher-installer; rm fetcher-installer)
```

If you don't have sudo(8), just omit it from the command(s) above, and run them as the `root` user, however you gain such privileges.

# Removing Fetcher

If you've used the installer, then you can run the following to delete the files it creates:

```
sudo rm -v /usr/share/man/man1/fetcher.1.gz /usr/share/bash-completion/completions/fetcher /usr/bin/fetcher
```

If you don't have sudo(8), you'll have to acquire root privileges by other means.
