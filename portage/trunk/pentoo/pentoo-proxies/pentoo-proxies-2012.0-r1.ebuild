# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
KEYWORDS="-*"
DESCRIPTION="Pentoo proxy meta ebuild"
HOMEPAGE="http://www.pentoo.ch"
SLOT="0"
LICENSE="GPL"
IUSE=""

DEPEND=""

RDEPEND="${DEPEND}
	net-proxy/3proxy
	net-proxy/burpsuite
	x86? ( net-proxy/httpush )
	net-proxy/privoxy-tor
	net-proxy/proxystrike
	net-proxy/redsocks
	net-proxy/tsocks
	net-misc/proxychains
	net-misc/iodine
	net-proxy/zaproxy"
