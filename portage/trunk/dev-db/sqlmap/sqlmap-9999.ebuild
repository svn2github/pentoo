# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /root/portage/net-analyzer/sqlinject/sqlinject-1.1.ebuild,v 1.1.1.1 2006/03/21 14:30:26 grimmlin Exp $

EAPI=3
PYTHON_DEPEND="2"

inherit python git-2

DESCRIPTION="Python based fuzzer for multi protocols, and faultinject"
HOMEPAGE="http://sqlmap.org"
EGIT_REPO_URI="https://github.com/sqlmapproject/sqlmap.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND=""
RDEPEND=""

QA_PRESTRIPPED="
	/usr/share/${PN}/lib/contrib/upx/linux/upx
	/usr/share/${PN}/udf/mysql/linux/32/lib_mysqludf_sys.so
	/usr/share/${PN}/udf/mysql/linux/64/lib_mysqludf_sys.so
	/usr/share/${PN}/udf/postgresql/linux/32/8.3/lib_postgresqludf_sys.so
	/usr/share/${PN}/udf/postgresql/linux/32/8.4/lib_postgresqludf_sys.so
	/usr/share/${PN}/udf/postgresql/linux/32/8.2/lib_postgresqludf_sys.so
	/usr/share/${PN}/udf/postgresql/linux/64/8.3/lib_postgresqludf_sys.so
	/usr/share/${PN}/udf/postgresql/linux/64/8.4/lib_postgresqludf_sys.so
	/usr/share/${PN}/udf/postgresql/linux/64/8.2/lib_postgresqludf_sys.so
	/usr/share/${PN}/udf/postgresql/linux/32/9.0/lib_postgresqludf_sys.so
	/usr/share/${PN}/udf/postgresql/linux/64/9.0/lib_postgresqludf_sys.so
	/usr/share/${PN}/extra/shellcodeexec/linux/shellcodeexec.x32
	/usr/share/${PN}/extra/shellcodeexec/linux/shellcodeexec.x64"

QA_DT_HASH="${QA_PRESTRIPPED}"

QA_TEXTRELS="
	usr/share/${PN}/udf/mysql/linux/32/lib_mysqludf_sys.so
	usr/share/${PN}/udf/postgresql/linux/32/8.3/lib_postgresqludf_sys.so
	usr/share/${PN}/udf/postgresql/linux/32/8.4/lib_postgresqludf_sys.so
	usr/share/${PN}/udf/postgresql/linux/32/8.2/lib_postgresqludf_sys.so"

S="${WORKDIR}"/$PN

src_compile () {
	einfo "Nothing to compile"
}

src_install () {
	# fix broken tarball
	find ./ -name .git | xargs rm -rf
	# Don't forget to disable the revision check since we removed the SVN files
	sed -i -e 's/= getRevisionNumber()/= "Unknown revision"/' lib/core/settings.py

	dodoc doc/* || die "failed to add docs"
	rm -rf doc/
	dodir /usr/share/"${PN}"/
	cp -R * "${D}"/usr/share/"${PN}"/
	dosym /usr/share/"${PN}"/sqlmap.py /usr/sbin/sqlmap
}