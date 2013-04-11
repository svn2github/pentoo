# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

DESCRIPTION="eselect module for metasploit"
HOMEPAGE="http://www.pentoo.ch/"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE=""

DEPEND="app-admin/eselect
	!<net-analyzer/metasploit-4.6"
RDEPEND="${DEPEND}"

S=${WORKDIR}

src_install() {
	#force to use the outdated bundled version of metasm
	doenvd "${FILESDIR}"/91metasploit

	newinitd "${FILESDIR}"/msfrpcd.initd msfrpcd
	newconfd "${FILESDIR}"/msfrpcd.confd msfrpcd

	insinto /usr/share/eselect/modules
	newins "${FILESDIR}/metasploit.eselect-${PV}" metasploit.eselect
}

pkg_postinst() {
	elog "To switch between installed slots, execute as root:"
	elog " # eselect metasploit set [slot number]"
}
