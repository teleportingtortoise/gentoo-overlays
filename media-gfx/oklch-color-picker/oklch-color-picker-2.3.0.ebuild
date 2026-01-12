EAPI=8
inherit xdg-utils

DESCRIPTION="OKlab color picker that takes input color and outputs edits to stdout. Alternative to installing it by cargo."

HOMEPAGE="https://github.com/eero-lehtinen/oklch-color-picker"
SRC_URI="https://github.com/eero-lehtinen/oklch-color-picker/releases/download/${P}/oklch-color-picker-${P}-x86_64-unknown-linux-gnu.tar.gz"

LISCENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="virtual/rust"
RDEPEND="${DEPEND}"
BDEPEND=""

src_configure() {
	econf --with-popt
}

pkg_postinst() {
	xdg_desktop_database_update
}

pkg_postrm() {
	xdg_desktop_database_update
}
