# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

DESCRIPTION="The ZERO (Zoning & Emotional Range Omitted) System is a technology for interfacing the brain of the pilot with the mobile suit's computer."
HOMEPAGE="http://www.pentoo.ch/"
SRC_URI=""

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="nu ozzie"

PDEPEND="
		app-admin/eselect-sh
		app-shells/zsh
		app-shells/zsh-completion
		app-shells/dash
		app-shells/mksh
		gnome-extra/gnome-media
		dev-vcs/mercurial
		app-arch/p7zip
		net-dns/dnsmasq
		app-portage/gentoolkit-dev
		app-portage/overlint
		app-misc/fslint
		app-doc/pms
		dev-vcs/cvs
		net-misc/keychain
		app-portage/pfl
		dev-util/pkgcore-checks
		app-portage/genlop
		dev-util/checkbashisms
		sys-devel/distcc
		nu? ( dev-util/catalyst
			net-p2p/mktorrent
			sys-power/cpufreqd
		)
		ozzie? ( net-print/samsung-unified-linux-driver
			mail-client/thunderbird
			media-sound/picard
			www-client/firefox
			net-ftp/filezilla
			www-client/chromium
			app-office/libreoffice
			app-emulation/virtualbox[extensions]
			sys-apps/preload
			x11-misc/slim
			www-plugins/google-talkplugin
			net-p2p/vuze
			app-emulation/wine
			media-gfx/gimp
			x11-apps/mesa-progs
			media-video/xine-ui
			media-video/mplayer
			net-wireless/hidclient
		)
"
