# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils

DESCRIPTION="Professional text and hex editing with Binary Templates technology"
HOMEPAGE="https://www.sweetscape.com/010editor/"
SRC_URI="
	amd64? ( https://www.sweetscape.com/download/010EditorLinux64Installer.tar.gz -> ${P}-amd64.tar.gz )
	x86? ( https://www.sweetscape.com/download/010EditorLinux32Installer.tar.gz -> ${P}-x86.tar.gz )"
RESTRICT="mirror strip bindist"

LICENSE="sweetscape"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="
	${DEPEND}"

MY_BASE_INSTALL_PATH="opt/${PN}"
MY_INSTALL_PATH="${MY_BASE_INSTALL_PATH}/${PV}"

pkg_setup() {
	cat > "${T}/response.txt" << _EOF
CreateDesktopShortcut: No
CreateQuickLaunchShortcut: No
InstallDir: ${D}${MY_INSTALL_PATH}
InstallMode: Silent
InstallType: Typical
LaunchApplication: No
ProgramFolderName: 010 Editor
SelectedComponents: Default Component
ViewReadme: No
_EOF
}

src_unpack() {
	if [ -n ${A} ]; then
		mkdir ${P}
		cd ${P}

		unpack ${A}
	fi
}

src_install() {
	addpredict "/var/lib/installjammer"
	addpredict "/applications-merged"
	./010EditorLinux64Installer --mode silent --prefix "${D}${MY_INSTALL_PATH}" --response-file "${T}/response.txt"

	make_wrapper "${PN}" "${PN}" "${EPREFIX}/${MY_INSTALL_PATH}"
	make_desktop_entry "${EPREFIX}/${MY_INSTALL_PATH}/${PN}" "010 Editor" "${EPREFIX}/${MY_INSTALL_PATH}/010_icon_128x128.png"
}
