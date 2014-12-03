# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

FFP_TARGETS="firefox"
inherit mozilla-addon

MOZ_FILEID="228658"
MOZ_ADDON_ID=5817
DESCRIPTION="Extension for Firefox and other apps to manage any sqlite database"
HOMEPAGE="http://code.google.com/p/sqlite-manager"
SRC_URI="http://addons.mozilla.org/firefox/downloads/file/${MOZ_FILEID} -> ${FFP_XPI_FILE}.xpi"

LICENSE="MPL-1.1"
SLOT="0"
KEYWORDS="amd64 x86"
