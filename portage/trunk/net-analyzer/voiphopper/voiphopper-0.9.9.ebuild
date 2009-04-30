# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="VoIP Hopper is a tool that rapidly runs a VLAN Hop into the Voice VLAN"
HOMEPAGE="http://voiphopper.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""
DEPEND="net-libs/libpcap"
RDEPEND="${DEPEND}"

src_compile() {
	emake || die "emake failed"
}

src_install() {
	dobin voiphopper
	dodoc README
}
