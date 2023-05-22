### Description

Portable utility allowing the user to easily back up their _HOME_ to a pre-defined storage location, using a _Gzip_-compressed archive generated with _tar_(1).

The user can optionally have _notify-send_(1) hand over a notification to his or her notifications daemon and/or a shell command executed, when the backup routine is finished. Per _tar_(1)'s regular functionality, the user can also provide an exclusion file, with which files can be ignored by the backup process.

### Requirements

Written for Linux.

Depends:

* POSIX-compliant shell (e.g., DASH)
* notify-send
* coreutils
* gzip
* tar

### Files

The installer provides the following:

* '/usr/local/bin/backmeup'
* '/usr/share/bash-completion/completions/backmeup'
* '/usr/share/man/man1/backmeup.1.gz'

### Contributions

The best way to help is to let me know of any bugs or oversights.

If you wish to contribute any code, try to keep to the existing programming style. Avoid reaching outside of the language whenever possible or reasonable, and keep things consistent and presentable. If you're contributing a new file, such as a helper or wrapper, try to stick to similar dependencies (where reasonable) and please keep the style of the output the same.

If submitting any documentation, try to ensure the English is correct and presentable.
