# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="A remote security scanner"
HOMEPAGE="http://www.openvas.org/"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="amd64 ~ppc x86"
IUSE="cli gtk webgui"

DEPEND=">=net-analyzer/openvas-scanner-3.0.2
        gtk? ( >=net-analyzer/openvas-client-3.0.0 )
	cli? ( net-analyzer/openvas-cli )
	webgui? ( net-analyzer/greenbone-security-assistant )
"

RDEPEND="${DEPEND}"
