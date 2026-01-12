EAPI=8
inherit git-r3 xdg-utils

DESCRIPTION="OKlab color picker that takes input color and outputs edits to stdout. Alternative to installing it by cargo."

HOMEPAGE="https://github.com/eero-lehtinen/oklch-color-picker"
EGIT_REPO_URI="https://github.com/eerolehtinen/oklch-color-picker.git"

LISCENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-libs/rust"

RDEPEND="${DEPEND}"
BDEPEND=""

DOCS=("README" "NEWS")

usex_no() {
	usex "$1" "${2:-$1}" "no${2:-$1}"
}

usex_null() {
	usex "$1" "${2:-$1}" ""
}

src_prepare() {
	default
}

src_configure() {
	# debug needed for custom CFLAGS
	econf \
		debug \
		man \
		$(usex_null gtk1) \
		$(usex_null gtk2) \
		$(usex_null gtk3) \
		$(usex_no thread) \
		$(usex_null imagick) \
		$(usex_no nls "intl") \
		$(usex_no jpeg) \
		$(usex_no tiff) \
		$(usex_no webp)

	# append custom CFLAGS
	echo "CFLAG += ${CFLAGS}" >> _conf.txt || die "Faild to add CFLAGS."
}

src_compile() {
	emake
}

src_install() {
	emake DESTDIR="${D}" install
}

pkg_postinst() {
	xdg_desktop_database_update
}

pkg_postrm() {
	xdg_desktop_database_update
}
