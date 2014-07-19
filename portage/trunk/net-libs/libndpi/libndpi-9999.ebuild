# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"
inherit autotools eutils subversion

DESCRIPTION="ntop-maintained superset of the popular OpenDPI library"
HOMEPAGE="http://www.ntop.org/products/ndpi/"
SRC_URI=""

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
IUSE=""
ESVN_REPO_URI="https://svn.ntop.org/svn/ntop/trunk/nDPI"

DEPEND=""
RDEPEND=""

src_prepare() {
	epatch "${FILESDIR}"/libndpi-system201407.patch
	eautomake
}

src_install() {
	DESTDIR="${D}" emake install
}
