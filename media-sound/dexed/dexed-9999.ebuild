# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit git-r3 xdg-utils

DESCRIPTION="A multi-platform, multi format plugin synth that is closely modeled on the Yamaha DX7."

HOMEPAGE="https://asb2m10.github.io/dexed/"
EGIT_REPO_URI="https://github.com/asb2m10/dexed.git"
EGIT_SUBMODULES=( '*' )

LISCENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="net-misc/curl
		media-libs/freetype
		media-libs/alsa-lib
		virtual/jack
		x11-libs/libXinerama
		x11-libs/libXcursor
		x11-libs/libXrandr"

RDEPEND="${DEPEND}"
BDEPEND=""


PNC="Dexed"

src_compile() {
	mkdir "${S}"/build
	cd "${S}"/build
	cmake .. -DJUCE_COPY_PLUGIN_AFTER_BUILD=FALSE
	cmake --build .
}

src_install() {
	newbin "${S}"/build/Source/Dexed_artefacts/Standalone/"${PNC}" "${PN}"
	libinto "/usr/lib/vst/"
	newlib "${S}"/build/Source/Dexed_artefacts/VST3/"${PNC}".vst3/Contents/x86_64-linux/"${PNC}".so "${PN}".so
	libinto "/usr/lib/clap/"
	newlib "${S}"/build/Source/Dexed_artefacts/CLAP/"${PNC}".clap "${PN}".clap
	insinto /usr/share/applications/
	doins "${FILESDIR}"/"${PN}".desktop
	insinto /usr/share/pixmaps/
	newins "${S}"/assets/ui/"${PN}"Icon.png "${PN}".png
}

pkg_postinst() {
	xdg_desktop_database_update
}

pkg_postrm() {
	xdg_desktop_database_update
}
