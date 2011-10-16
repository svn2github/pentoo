# $Id: 3e2049f02d2f9c242ee910c84b6362583c2710ec $
#
# Arch-specific options that normally shouldn't be changed.
#
KERNEL_MAKE_DIRECTIVE="vmlinux"
KERNEL_MAKE_DIRECTIVE_2=""
KERNEL_BINARY="vmlinux"

COMPRESS_INITRD=yes

#
# Arch-specific defaults that can be overridden in the config file or on the
# command line.
#
DEFAULT_MAKEOPTS="-j2"

DEFAULT_KERNEL_MAKE=make
DEFAULT_UTILS_MAKE=make

DEFAULT_KERNEL_CC=gcc
DEFAULT_KERNEL_AS=as
DEFAULT_KERNEL_LD=ld

DEFAULT_UTILS_CC=gcc
DEFAULT_UTILS_AS=as
DEFAULT_UTILS_LD=ld
