# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit cmake-utils

DESCRIPTION="GammaRay is a free software introspection tool for Qt applications"
HOMEPAGE="http://www.kdab.com/gammaray"

MY_PN="GammaRay"
SRC_URI="https://github.com/KDAB/${MY_PN}/archive/v${PV}.tar.gz"
S="${WORKDIR}/${MY_PN}-${PV}"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="3d qml doc dot gui script"
REQUIRED_USE="
	3d? ( gui )
	qml? ( gui )
"

# minimum Qt version required
QT_PV="5.9.4:5"

CDEPEND="
	>=dev-qt/qtconcurrent-${QT_PV}
	>=dev-qt/qtcore-${QT_PV}
	>=dev-qt/qtnetwork-${QT_PV}

	gui? (
		>=dev-qt/qtgui-${QT_PV}

		3d? ( >=dev-qt/qt3d-${QT_PV}[qml?] )

		qml? (
			>=dev-qt/qtdeclarative-${QT_PV}[widgets]
		)
	)

	script? ( >=dev-qt/qtscript-${QT_PV}[scripttools] )
"

DEPEND="${CDEPEND}
	doc? (
		>=app-doc/doxygen-1.8.13[dot?]

		dot? ( >=dev-haskell/graphviz-2999.18.0.2 )

		>=dev-qt/qthelp-${QT_PV}
		>=dev-qt/linguist-tools-${QT_PV}
	)
"

RDEPEND="${CDEPEND}
"
