**MASTER** - _Hopefully stable branch._\
**DEV** - _Development Branch (latest changes)_

# Introduction to Extra/source/libtflbp-sh

These are files in each of which resides a function used in various programs and standard shell scripts I've written and continue to write. These are therefore considered dependencies in those cases. However, these are actually not just any old functions, but pure-Bourne [POSIX-compliant](https://en.wikipedia.org/wiki/POSIX) functions.

A more detailed write-up will be here eventually -- grizzly bear with me!

# Installation Instructions

If you're on a Debian- or Ubuntu-based distribution of Linux, installation is no problem. Head on over to the [DEB-Packages](https://github.com/terminalforlife/DEB-Packages) repository, then download then install the `libtflbp-sh` package.

If you have [Cito](https://github.com/terminalforlife/Extra), the installation is easy, but currently cumbersome:

```bash
sudo cito -r terminalforlife Extra master source/libtflbp-sh/BaseName
sudo cito -r terminalforlife Extra master source/libtflbp-sh/ChkDep
sudo cito -r terminalforlife Extra master source/libtflbp-sh/CutStr
sudo cito -r terminalforlife Extra master source/libtflbp-sh/DirName
sudo cito -r terminalforlife Extra master source/libtflbp-sh/Err
sudo cito -r terminalforlife Extra master source/libtflbp-sh/FNSanityChk
sudo cito -r terminalforlife Extra master source/libtflbp-sh/FirstLook
sudo cito -r terminalforlife Extra master source/libtflbp-sh/GetInsPkgs
sudo cito -r terminalforlife Extra master source/libtflbp-sh/LCount
sudo cito -r terminalforlife Extra master source/libtflbp-sh/LibFChk
sudo cito -r terminalforlife Extra master source/libtflbp-sh/LibTFLBPVer
sudo cito -r terminalforlife Extra master source/libtflbp-sh/OneSearch
sudo cito -r terminalforlife Extra master source/libtflbp-sh/SplitStr
sudo cito -r terminalforlife Extra master source/libtflbp-sh/WCount
sudo cito -r terminalforlife Extra master source/libtflbp-sh/YNInput
```

Once I've ironed out how to specify multiple files with Cito, or perhaps have 'packages' of sorts used by it, then the cumbersome factor should go away. Admittedly, Cito was written mostly with programs installed to `PATH` in mind.
