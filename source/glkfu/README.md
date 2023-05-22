### Description

Simplify the process of compiling and building Debian images and headers for the latest available stable Linux kernel. While this is still more of an advanced approach to setting up the Linux kernel in Debian- and Ubuntu-based distributions of Linux, **GLKFU** does make this process much easier, quicker, and more user-friendly.

No actual installation of the resulting Debian packages will be performed; this is intentionally left to the responsibility of the user. At any point in the process, you can leave GLKFU and take over the installation yourself, if you wish to do something different.

### Requirements

Written for Linux.

Depends:

* BASH (>= 4.3)
* Wget or cURL
* coreutils
* gpg
* less
* make
* tar
* xz

Recommends:

* perl (>= 5.22)
* LWP (e.g., 'libwww-perl')

### Files

The installer provides the following:

* '/usr/local/bin/glkfu'
* '/usr/local/bin/glkfu-changes'
* '/usr/local/bin/glkfu-list'
* '/usr/share/bash-completion/completions/glkfu'
* '/usr/share/man/man1/glkfu.1.gz'

### Contributions

The best way to help is to let me know of any bugs or oversights.

If you wish to contribute any code, try to keep to the existing programming style. Avoid reaching outside of the language whenever possible or reasonable, and keep things consistent and presentable. If you're contributing a new file, such as a helper or wrapper, try to stick to similar dependencies (where reasonable) and please keep the style of the output the same.

If submitting any documentation, try to ensure the English is correct and presentable.
