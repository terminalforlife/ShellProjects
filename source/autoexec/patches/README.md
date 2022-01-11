# AutoExec (AE) Patches

###'patches/simplified.patch'

This patch's primarily goal is to remove manual shebang parsing.

Pros:

* AE works more efficiently and so faster.
* You can change the shebang without relaunching AE.
* You're assured the usual control over the shebang.
* The realpath(1) and file(1) programs are no longer required.

Cons:

* You lose functionality, such as...
    - The checking options, although this can still be manually set by changing the shebang.
    - Improved error-checking, such as for an unsupported shebang/executable.
    - The ability to override the shebang with a given executable, which is a particularly useful feature not implemented with this simple patch.
* The file _must_ first be made executable.
