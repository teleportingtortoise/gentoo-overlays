EAPI=8
inherit git-r3 xdg-utils

DESCRIPTION="Simple GTK+1/2/3 painting program designed for creating icons and pixel art."

HOMEPAGE="https://github.com/wjaguar/mtPaint"
EGIT_REPO_URI="https://github.com/wjaguar/mtPaint.git"
EDIT_COMMIT="a50460bacadfc522705648c1367541974c5d109d"

LISCENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="-gtk1 -gtk2 +gtk3 imagick nls jpeg tiff webp -thread"

DEPEND="dev-libs/glib
		media-libs/libpng
		sys-devel/gettext
		sys-libs/zlib
		x11-libs/pango
		media-gfx/gifsicle
		gtk1? ( >=x11-libs/gtk+-1 )
		gtk2? ( >=x11-libs/gtk+-2 )
		gtk3? ( >=x11-libs/gtk+-3 )
		jpeg? ( virtual/jpeg )
		tiff? ( media-libs/tiff )
		imagick? ( media-gfx/imagemagick !media-gfx/gifsicle )
		webp? ( media-libs/webp )"

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
