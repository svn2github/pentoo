# $Id: 070602e90d15bcc9f0f239fe87feea2517439ba1 $
#
# Arch-specific options that normally shouldn't be changed.
#
KERNEL_MAKE_DIRECTIVE="linux"
KERNEL_MAKE_DIRECTIVE_2=""
KERNEL_BINARY="linux"

COMPRESS_INITRD=yes
ARCH_HAVENOPREPARE=yes

#
# Arch-specific defaults that can be overridden in the config file or on the
# command line.
#
DEFAULT_MAKEOPTS="-j2"

DEFAULT_KERNEL_MAKE="make ARCH=um"
DEFAULT_UTILS_MAKE=make

DEFAULT_KERNEL_CC=gcc
DEFAULT_KERNEL_AS=as
DEFAULT_KERNEL_LD=ld

DEFAULT_UTILS_CC=gcc
DEFAULT_UTILS_AS=as
DEFAULT_UTILS_LD=ld
