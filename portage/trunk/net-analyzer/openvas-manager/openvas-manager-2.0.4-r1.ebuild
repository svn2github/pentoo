# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit cmake-utils eutils

DESCRIPTION="A remote security scanner for Linux (openvas-manager)"
HOMEPAGE="http://www.openvas.org/"
SRC_URI="http://wald.intevation.org/frs/download.php/871/${P}.tar.gz"

SLOT="4"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
IUSE="pdf doc"

RDEPEND="app-crypt/gpgme
	>=dev-db/sqlite-3
	>=dev-libs/glib-2
	net-libs/gnutls
	>=dev-db/sqlite-3.0
	net-libs/libpcap
	net-analyzer/openvas-libraries:4
	pdf? ( dev-texlive/texlive-latexextra )
	"
#	dev-tex/latex2html
DEPEND="${RDEPEND}
	doc? ( app-doc/doxygen )"

CMAKE_BUILD_DIR="${S}"

src_configure() {
	mycmakeargs=(-DLOCALSTATEDIR=/var -DSYSCONFDIR=/etc)
	cmake-utils_src_configure || die
}

src_compile() {
	mycmakeargs=(-DLOCALSTATEDIR=/var -DSYSCONFDIR=/etc)
	cmake-utils_src_compile || die
}

src_install() {
	cmake-utils_src_install || die
	doinitd "${FILESDIR}"/openvasmd || die
}

pkg_postinst() {
	einfo "Dont forget to openvas-mkcert-client -n om -i"
	einfo "Or simply openvas-mkcert-client and create yourself user om"
	if [ -e /var/lib/openvas/mgr/tasks.db ] ; then
		einfo "You have already a manager database, please run openvasmd --update"
	fi
	#be sure that this is readable
	fowners -R root:openvas /usr/share/openvas/openvasmd/global_report_formats/ || die
}
