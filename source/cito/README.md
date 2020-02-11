# Cito Installation Instructions

If you already have Cito, you can update it with:

```
sudo cito -M 644 -O 0 -G 0 -T /usr/share/man/man8/cito.8.gz -r terminalforlife Extra master source/cito/cito.8.gz
sudo cito -r terminalforlife Extra master source/cito/{cito,completions}
```

If you're not sure what UbuChk is, check out [this](https://youtu.be/CZ4Kn0gtHaM) video, over on YouTube.

# Dependencies

  * coreutils (>= 8.25-2)
  * curl (>= 7.47.0-1) | wget (>= 1.17.1-1)
  * [libtflbp-sh](https://github.com/terminalforlife/Extra/tree/master/source/libtflbp-sh) (>= 2019-12-10)
