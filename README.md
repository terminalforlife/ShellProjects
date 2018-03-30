# miscellaneous
Here you'll find my smaller projects, quick scripts, and some configuration files.

**MASTER** - _Hopefully stable branch._\
**DEV** - _Development Branch (latest changes)_

## INSTALLATION

Visit the installit repository to use the easy-to-use TFL downloader.

For files unavailable in insit (likely for good reason), you can clone this repository yourself and access them that way.

### ALTERNATIVE INSTALLATIONS

#### *FILE:* compton.conf

The below one-liner will fetch and correctly place the TFL `compton` configuration file, while backing up the original.

```bash
TFL_CCF="$HOME/.config/compton.conf"; [ -f "$TFL_CCF" ] && mv "$TFL_CCF"{,.bak}; wget -cq github.com/terminalforlife/miscellaneous/raw/master/compton.conf -O "$TFL_CCF"
```

If you've got insit, it's as simple as:

```bash
sudo insit compconf
```
