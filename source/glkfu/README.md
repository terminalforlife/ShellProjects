# GLKFU - Get Latest Kernel for Ubuntu

Despite its name, this tool is actually useful on much more than just straight Ubuntu.

Simplify the process of compiling and building Debian images and headers for the latest available stable Linux kernel, so downloaded from the official kernel.org website.

While this is still more of an advanced approach to setting up the Linux kernel in Debian- and Ubuntu-based distributions of Linux, **GLKFU** does make this process much easier, quicker, and more user-friendly.

No actual installation of the resulting Debian packages will be performed; this is intentionally left to the responsibility of the user.

A series of compilation and package building dependencies will be required in order to correctly use **GLKFU**, but a helpful check is performed before doing anything important, to see if these packages are installed.

You don't even have to compile & build packages for Linux using **GLKFU**, as you can choose to simply download the tarball, or even simply check if a new version is available. Plenty of options are available.

# Dependencies for Compilation & Package Building

**bc** - GNU bc arbitrary precision calculator language\
**bison** - YACC-compatible parser generator\
**build-essential** - Informational list of build-essential packages\
**fakeroot** - tool for simulating superuser privileges\
**flex** - fast lexical analyzer generator\
**libelf-dev** - libelf1 development libraries and header files\
**libssl-dev** - Secure Sockets Layer toolkit - development files\
**rsync** - fast, versatile, remote (and local) file-copying tool

If you spot a dependency neither listed here nor checked for by **GLKFU**, please get in touch so this can be addressed.

# Video Demonstration & Thoughts

If you'd like a demonstration of, some thoughts on, or updates about **GLKFU**, check out **Learn Linux** on **YouTube**, available here [here](https://www.youtube.com/c/learnlinux). Perform a search for 'GLKFU' and you're sure to find relevant videos.

# Bugs

Bugs will be handled as soon as possible, but you can speed things up by reporting them. I cannot fix what I don't know exists! Please refer to the **GLKFU** man page (`man glkfu`) and refer to the **BUGS** section.
