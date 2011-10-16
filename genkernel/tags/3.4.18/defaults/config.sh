# $Id: d135e0e861a2a17604868d0d81180f3e39f8c606 $
#
# Arch-specific options that normally shouldn't be changed.
#
KERNEL_MAKE_DIRECTIVE="bzImage"
# since "" is allowed (this will translate in `make `, which is nice
# for xen-based kernels, the default value of
# KERNEL_MAKE_DIRECTIVE_OVERRIDE cannot be ""
DEFAULT_KERNEL_MAKE_DIRECTIVE_OVERRIDE="--INVALID--"
KERNEL_MAKE_DIRECTIVE_OVERRIDE="${DEFAULT_KERNEL_MAKE_DIRECTIVE_OVERRIDE}"
KERNEL_MAKE_DIRECTIVE_2=""
KERNEL_BINARY="arch/i386/boot/bzImage"
KERNEL_BINARY_OVERRIDE=""

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
