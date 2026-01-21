# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit xdg-utils

DESCRIPTION="OKlab color picker that takes input color and outputs edits to stdout. Alternative to installing it by cargo."

PLAT="x86_64-unknown-linux-gnu"
HOMEPAGE="https://github.com/eero-lehtinen/${PN}"
SRC_URI="https://github.com/eero-lehtinen/${PN}/releases/download/${PV}/${P}-${PLAT}.tar.gz"

LISCENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""


S="${WORKDIR}/${P}-${PLAT}"

src_install() {
	dobin "${PN}"
	insinto /usr/share/applications/
	doins "${FILESDIR}"/"${PN}".desktop
}

pkg_postinst() {
	xdg_desktop_database_update
}

pkg_postrm() {
	xdg_desktop_database_update
}
