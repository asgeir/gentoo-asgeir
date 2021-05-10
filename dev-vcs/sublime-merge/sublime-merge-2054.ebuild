# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit desktop gnome2-utils

DESCRIPTION="A new Git client, from the makers of Sublime Text"
HOMEPAGE="https://www.sublimemerge.com"
SRC_URI="
	amd64? ( https://download.sublimetext.com/sublime_merge_build_${PV}_x64.tar.xz )"

LICENSE="Sublime"
SLOT="0"
KEYWORDS="amd64"
RESTRICT="bindist mirror strip"

RDEPEND="
	dev-libs/glib:2
	x11-libs/gtk+:2
	x11-libs/libX11"

QA_PREBUILT="*"
S="${WORKDIR}/sublime_merge"

src_install() {
	insinto /opt/${PN}${PV}
	doins -r Packages Icon
	doins changelog.txt

	exeinto /opt/${PN}${PV}
	doexe crash_reporter git-credential-sublime ssh-askpass-sublime sublime_merge
	dosym ../../opt/${PN}${PV}/sublime_merge /usr/bin/smerge

	local size
	for size in 16 32 48 128 256; do
		dosym ../../../../../../opt/${PN}${PV}/Icon/${size}x${size}/sublime-merge.png \
			/usr/share/icons/hicolor/${size}x${size}/apps/smerge.png
	done

	make_desktop_entry "smerge" "Sublime Merge" "smerge" \
		"Development" "StartupNotify=true"

	# needed to get WM_CLASS lookup right
	mv "${ED%/}"/usr/share/applications/smerge{-sublime-merge,}.desktop || die
}

pkg_postrm() {
	gnome2_icon_cache_update
}

pkg_postinst() {
	gnome2_icon_cache_update
}
