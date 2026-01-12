EAPI=8
inherit xdg-utils

DESCRIPTION="OKlab color picker that takes input color and outputs edits to stdout. Alternative to installing it by cargo."

PLAT="x86_64-unknown-linux-gnu"
HOMEPAGE="https://github.com/eero-lehtinen/${PN}"
SRC_URI="https://github.com/eero-lehtinen/${PN}/releases/download/${PV}/${P}-${PLAT}.tar.gz"
S="${WORKDIR}/${P}-${PLAT}"

LISCENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

src_install() {
	dobin "${PN}"
}

pkg_postinst() {
	cp "${FILESDIR}"/"${PN}".desktop /usr/share/applications/"${PN}".desktop
	xdg_desktop_database_update
}

pkg_postrm() {
	rm /usr/share/applications/"${PN}".desktop
	xdg_desktop_database_update
}
