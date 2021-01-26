# Cito Installation Instructions

If you already have Cito, you can update it with:

```
sudo cito -M 644 -O 0 -G 0 -T /usr/share/man/man8/cito.8.gz -r terminalforlife Extra master source/cito/cito.8.gz
sudo cito -r terminalforlife Extra master source/cito/{cito,completions}
```

Provided you have access to sudo(8), of course.

You can also use the provided 'cito-installer' script.

There are Debian packages over [here](https://github.com/terminalforlife/DEB-Packages) which is a good solution for those on Debian- or Ubuntu-based distributions of Linux.

# Uninstalling Cito

This one-liner will effectively uninstall Cito:

```
sudo rm /usr/bin/cito /usr/bin/cito-list /usr/share/man/man8/cito.8.gz /usr/share/bash-completion/completions/cito
```

As above, provided you have access to sudo(8).

# Updating Cito

You can update Cito by installing Cito _with_ Cito, as you would anything else. This one-liner will update '/usr/bin/cito' itself:

```
sudo cito -r terminalforlife Extra master source/cito/cito
```

But a better method is to just use the 'cito-installer' again, because that will install everything anew.

# Dependencies

  * coreutils (>= 8.25-2)
  * curl (>= 7.47.0-1) | wget (>= 1.17.1-1)
