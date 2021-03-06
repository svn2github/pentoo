# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: blshkv$

EAPI=5

inherit eutils multilib

DESCRIPTION="A lightweight multi-platform, multi-architecture disassembly framework"
HOMEPAGE="http://www.capstone-engine.org/"
SRC_URI="https://github.com/aquynh/capstone/archive/${PV}.tar.gz -> ${P}.tar.gz"
IUSE="python"

LICENSE="BSD"
SLOT="0/2"
KEYWORDS="~amd64 ~arm ~x86"

RDEPEND="python? ( ~dev-python/capstone-python-${PV} )"
DEPEND=""

#TODO: add java and ocaml bindings

src_prepare() {
	#upstream bug: https://github.com/aquynh/capstone/issues/92
	sed -i '/$(MAKE) -C tests/d' Makefile || die "sed failed"
	sed -i '/$(INSTALL_DATA) lib$(LIBNAME).$(EXT) tests/d' Makefile || die "sed failed"
}

#Do not compile tests/* files. Let users do it
#src_compile() {
#	emake
#	cd tests
#	emake
#}

src_install() {
	emake DESTDIR="${D}" install
	dodir /usr/share/"${PN}"/
	cp -R "${S}"/tests "${D}/usr/share/${PN}/" || die "Install failed!"
	dodoc README
}
