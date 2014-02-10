# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python2_{6,7} )
inherit python-r1 git-2

DESCRIPTION="A tool that automates the process of detecting and exploiting SQL injection flaws"
HOMEPAGE="http://sqlmap.org"
EGIT_REPO_URI="https://github.com/sqlmapproject/sqlmap.git"
EGIT_COMMIT="fe0ff6e679f13546377cb0f58f38b000054fefad"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND=""

QA_PREBUILT="
	usr/share/${PN}/udf/mysql/linux/32/lib_mysqludf_sys.so
	usr/share/${PN}/udf/mysql/linux/64/lib_mysqludf_sys.so
	usr/share/${PN}/udf/postgresql/linux/32/8.2/lib_postgresqludf_sys.so
	usr/share/${PN}/udf/postgresql/linux/32/8.3/lib_postgresqludf_sys.so
	usr/share/${PN}/udf/postgresql/linux/32/8.4/lib_postgresqludf_sys.so
	usr/share/${PN}/udf/postgresql/linux/32/9.0/lib_postgresqludf_sys.so
	usr/share/${PN}/udf/postgresql/linux/64/8.2/lib_postgresqludf_sys.so
	usr/share/${PN}/udf/postgresql/linux/64/8.3/lib_postgresqludf_sys.so
	usr/share/${PN}/udf/postgresql/linux/64/8.4/lib_postgresqludf_sys.so
	usr/share/${PN}/udf/postgresql/linux/64/9.0/lib_postgresqludf_sys.so"

src_install () {
	# fix broken tarball
	find ./ -name .git | xargs rm -rf
	# Don't forget to disable the revision check since we removed the SVN files
	sed -i -e 's/= getRevisionNumber()/= "Unknown revision"/' lib/core/settings.py

	dodoc doc/* || die "failed to add docs"
	rm -rf doc/
	dodir /usr/share/"${PN}"/

	cp -R * "${D}"/usr/share/"${PN}"/
	dosym /usr/share/"${PN}"/sqlmap.py /usr/sbin/${PN}
}
