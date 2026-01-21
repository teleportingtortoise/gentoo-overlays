# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit xdg-utils

DESCRIPTION="An advanced freeware audio player (Wine package)"

HOMEPAGE="https://www.foobar2000.org"
SRC_URI="${HOMEPAGE}/downloads/${PN}-x64_v${PV}.exe -> ${PN}.exe"
LISCENSE="foobar2000"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="
	virtual/wine
	app-arch/7zip
	net-misc/wget
"

RDEPEND="${DEPEND}"
BDEPEND=""

S="${WORKDIR}/${PN}"


src_unpack() {
	default
	7z x "${DISTDIR}/${PN}.exe" -x'!$PLUGINSDIR' -x'!$R0' \
		-x'!icons' -x'!foobar2000 Shell Associations Updater.exe' \
		-o"${S}"
}


pkg_prepare() {
	default
	find "${S}" -type d -execdir fperms 755 {} +
}

src_install() {
	dobin "${FILESDIR}"/"${PN}"
	insinto /usr/share/
	doins -r "${S}"
	insinto /usr/share/pixmaps/
	newins "${FILESDIR}"/"${PN}".png "${PN}".png
	insinto /usr/share/foobar2000/
	doins "${FILESDIR}"/portable_mode_enabled
	insinto /usr/share/applications/
	doins "${FILESDIR}"/"${PN}".desktop
}

pkg_postinst() {
	xdg_desktop_database_update
}

pkg_postrm() {
	xdg_desktop_database_update
}