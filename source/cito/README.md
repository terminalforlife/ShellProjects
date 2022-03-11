# Installation Instructions

Your best bet is one of two options:

  * Install via [Cito's DEB package](https://github.com/terminalforlife/DEB-Packages/tree/master/cito) for Debian- and Ubuntu-based systems.
  * Install via Cito's [installation script](https://github.com/terminalforlife/Extra/blob/master/source/cito/cito-installer).

For a quick terminal one-liner, using the aforementioned installation script, you should be able to execute the following, assuming you have sudo(8):

```sh
(cd /tmp; curl -so cito-installer 'https://raw.githubusercontent.com/terminalforlife/Extra/master/source/cito/cito-installer' && sudo \sh cito-installer; rm cito-installer)
```

If that fails, you probably don't have curl(1), so try wget(1):

```sh
(cd /tmp; wget -qO cito-installer 'https://raw.githubusercontent.com/terminalforlife/Extra/master/source/cito/cito-installer' && sudo \sh cito-installer; rm cito-installer)
```

If you don't have sudo(8), just omit it from the command(s) above, and run them as the `root` user, however you gain such privileges.

# Removing Cito

If you've used a Debian package to install Cito, refer to your package manager. However, if you've used the installer, then you can run the following to delete the files it creates:

```
sudo rm /usr/bin/cito /usr/share/man/man8/cito.8.gz /usr/share/bash-completion/completions/cito
```

If you don't have sudo(8), you'll have to acquire root privileges by other means.

```
sudo rm /usr/bin/cito /usr/share/man/man8/cito.8.gz /usr/share/bash-completion/completions/cito
```

Provided you have access to sudo(8), of course.

# Updating Cito

You can update Cito by installing Cito _with_ Cito, as you would anything else. This one-liner will update '/usr/bin/cito' itself:

```
sudo cito -r terminalforlife Extra master source/cito/cito
```

As above, provided you have access to sudo(8).

But a better method is to just use the 'cito-installer' again, because that will install everything anew.

# Dependencies

  * coreutils (>= 8.25-2)
  * curl (>= 7.47.0-1) | wget (>= 1.17.1-1)
