# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /root/portage/net-analyzer/absinthe/absinthe-1.4.1.ebuild,v 1.1.1.1 2006/03/02 00:53:51 grimmlin Exp $

inherit mono

MY_P=Absinthe-${PV}-Linux
DESCRIPTION="Absinthe is a gui-based tool that automates the process of downloading the schema & contents of a database that is vulnerable to Blind SQL Injection."
HOMEPAGE="http://www.0x90.org/releases/absinthe/"
SRC_URI="http://www.0x90.org/releases/absinthe/${MY_P}.tar.gz"

LICENSE="GPL-2, BSD"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=">=dev-lang/mono-1"

S=${WORKDIR}/${MY_P}

src_compile() {
	sed -i -e "s:BIN_DIR.*:BIN_DIR = ${D}usr/bin/:" -e "s:LIB_DIR.*:LIB_DIR = ${D}usr/lib/:" Makefile
	sed -i -e "s:/usr/bin:${D}usr/bin:" \
	       -e "s:/usr/lib:${D}usr/lib:" \
               -e "s:/sbin:#/sbin:" \
	       -e "s:^ln.*::" install.sh
	einfo "Nothing to compile"

}

src_install() {
	dodir /usr/lib/ 
	dodir /usr/bin/
	cp -a ${FILESDIR}/LiquorCabinet.Shared.dll ${D}/usr/lib/
	./install.sh
	dosym /usr/bin/runabsinthe.sh /usr/bin/absinthe
	dodoc docs/*
}
