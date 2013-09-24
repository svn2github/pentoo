# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:

EAPI=5
PYTHON_DEPEND="2"
#GUI interface is disabled in this version
#PYTHON_USE_WITH="tk"
#PYTHON_USE_WITH_OPT="tk"

inherit python eutils versionator

AVC=( $(get_version_components) )

DESCRIPTION="Mass WEP/WPA cracker"
HOMEPAGE="http://code.google.com/p/wifite/"
SRC_URI="http://wifite.googlecode.com/svn-history/r${AVC[1]}/trunk/wifite.py -> ${P}.py"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="arm amd64 x86"
IUSE="dict cuda extra"

DEPEND=""
RDEPEND="net-wireless/aircrack-ng
	dev-python/pexpect
	dict? ( sys-apps/cracklib-words )
	extra? ( app-crypt/pyrit[cuda?]
		net-wireless/cowpatty
		net-analyzer/macchanger
		net-wireless/reaver )"
#	tk? ( x11-terms/xterm )"

S=${WORKDIR}/${PN}

src_unpack() {
	mkdir "${S}"
	cp "${DISTDIR}"/${A} "${S}/${PN}"
}

src_prepare() {
	epatch "${FILESDIR}"/${PN}-noupgrade.patch
	epatch "${FILESDIR}"/${PN}-tshark.patch
	python_convert_shebangs 2 "${S}"/${PN}
}

src_install() {
	dosbin wifite
}
