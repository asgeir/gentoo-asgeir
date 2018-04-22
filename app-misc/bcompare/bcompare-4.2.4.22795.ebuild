# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="Beyond Compare -- Compare, sync, and merge files and folders"
HOMEPAGE="http://www.scootersoftware.com/"
SRC_URI="
	amd64? ( http://www.scootersoftware.com/bcompare-${PV}.x86_64.tar.gz )"
RESTRICT="mirror strip bindist"

LICENSE="bcompare"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="
	dev-qt/qtgui:4
	dev-qt/qtcore:4

	${DEPEND}"

BC_HOME="opt/${PN}"
BC_BIN="${BC_HOME}/bin"
BC_LIB="${BC_HOME}/lib/${beyondcompare}"

src_install() {
	dodir "/${BC_BIN}"
	dodir "/${BC_LIB}"

	exeinto "/${BC_BIN}"
	newexe bcompare.sh bcompare

	into "/${BC_LIB}"
	exeinto "/${BC_LIB}"
	insinto "/${BC_LIB}"
	doexe BCompare bcmount32 bcmount64 bcmount.sh
	doexe libQt4Pas.so.5 lib7z.so
	doins BCompare.mad README

	local libbz2so=$(ldconfig -p | awk -F" " '$1=="libbz2.so.1" && $2~/'${LDCONFIG_ARCH}'/ {print $NF}' | head -n1)
	if [ "$libbz2so" != "" ]; then
		dosym "${EPREFIX}${libbz2so}" "/${BC_LIB}/libbz2.so.1.0"
	fi
	dosym "${EPREFIX}/${BC_BIN}/bcompare" "/usr/bin/${PN}"
}

pkg_postinst() {
	sed -i "s|^\(BC_LIB=\).*|\1${EROOT}/${BC_LIB}|" "${EROOT}/${BC_BIN}/bcompare"
	sed -i "s|^\(BC_PACKAGE_TYPE=\).*|\1archive|" "${EROOT}/${BC_BIN}/bcompare"
}
