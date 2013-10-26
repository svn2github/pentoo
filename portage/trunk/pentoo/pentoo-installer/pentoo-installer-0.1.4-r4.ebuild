# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils

DESCRIPTION="ncurses based installer for pentoo, based on the Arch Linux installer"
HOMEPAGE="http://gitorious.org/pentoo/pentoo-installer"
SRC_URI="http://dev.pentoo.ch/~zero/distfiles/${P}.tar.xz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="app-arch/xz-utils"
RDEPEND="dev-util/dialog
	|| ( <sys-boot/grub-1
	     <sys-boot/grub-static-1 )
	net-misc/rsync"

src_prepare() {
	epatch "${FILESDIR}"/clean_livecd_use_flags_correctly.patch
	epatch "${FILESDIR}"/132-and-140.patch
}

src_install() {
	dosbin ${PN}
	domenu "${FILESDIR}"/pentoo-installer.desktop
	exeinto /root/Desktop/
	doexe "${FILESDIR}"/pentoo-installer.desktop
}
