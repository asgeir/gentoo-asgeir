# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3 cmake

DESCRIPTION="C/C++ WebRTC Data Channels and Media Transport lightweight library"
HOMEPAGE="https://github.com/paullouisageneau/libdatachannel"
EGIT_REPO_URI="https://github.com/paullouisageneau/libdatachannel"
EGIT_COMMIT="v${PV}"
EGIT_SUBMODULES=( '*' )

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

PATCHES=(
	"${FILESDIR}/${P}-avoid-installing-plog-and-json.patch"
	"${FILESDIR}/${P}-lib64-install.patch"
	"${FILESDIR}/${P}-video-orientation-support.patch"
)

src_install() {
	cmake_src_install

	sed -e "s@%LIB%@$(get_libdir)@g" -e "s@%PREFIX%@${EPREFIX}/usr@g" \
		-e "s@%VERSION%@${PV}@g" "${FILESDIR}/libdatachannel.pc.in" > "${T}/libdatachannel.pc"
	insinto "/usr/$(get_libdir)/pkgconfig"
	doins "${T}/libdatachannel.pc"
}
