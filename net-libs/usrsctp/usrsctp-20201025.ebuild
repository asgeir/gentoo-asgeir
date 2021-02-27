# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake flag-o-matic

DESCRIPTION="A cross-platform userland SCTP stack"
HOMEPAGE="https://github.com/sctplab/usrsctp"
USRSCTP_VERSION="862f4f5c561bc12b0b9f80b302d53736c6b2507e"
SRC_URI="https://github.com/sctplab/usrsctp/archive/${USRSCTP_VERSION}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE="static-libs"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

S="${WORKDIR}/${PN}-${USRSCTP_VERSION}"

src_configure() {
	local mycmakeargs=(
		-Dsctp_werror=0
		-Dsctp_build_programs=0
	)
	cmake_src_configure
}

src_install() {
	cmake_src_install
	use static-libs || rm "${ED}"/usr/lib*/*.a
}