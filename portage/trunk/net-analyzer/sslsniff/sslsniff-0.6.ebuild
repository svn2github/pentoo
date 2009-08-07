# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="sslstrip remove https and forwards http"
HOMEPAGE="http://www.thoughtcrime.org/software/sslsniff/"
SRC_URI="http://www.thoughtcrime.org/software/${PN}/${P}.tar.gz"

inherit eutils
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""
EAPI=2

DEPEND="dev-libs/log4cpp
	dev-libs/openssl
	dev-libs/boost"
RDEPEND=">=dev-lang/python-2.5"

src_install() {
        dodir /usr/share/"${PN}"
	insinto /usr/share/"${PN}"
	doins IPSCACLASEA1.crt leafcert.pem certs/wildcard updates/Darwin_Universal-gcc3.xml 
	doins updates/Linux_x86-gcc3.xml updates/WINNT_x86-msvc.xml
	dosbin sslsniff
        dodoc README Changelog
}
