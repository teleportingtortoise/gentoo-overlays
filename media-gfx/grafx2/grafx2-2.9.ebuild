# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="A bitmap paint program inspired by the Amiga programs ​Deluxe Paint and Brilliance. Known for use in pixel art."

HOMEPAGE="http://grafx2.chez.com"
HOMEPAGE="http://pulkomandy.tk/projects/GrafX2/downloads"
SRC_URI="http://pulkomandy.tk/projects/GrafX2/downloads/81 -> ${P}.tar.gz"

LISCENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="ttf lua joystick nolayers optimizations norecoil x11 sdl2"
REQUIRED_USE="?? ( x11 sdl2 )"

DEPEND="media-libs/libsdl
		media-libs/sdl-image
		media-libs/freetype
		virtual/jpeg
		media-libs/libpng
		media-libs/tiff
		ttf? ( media-libs/sdl-ttf )
		lua? ( dev-lang/lua )
		sdl2? (
			media-libs/libsdl2
			media-libs/sdl2-image
			media-libs/sdl2-ttf
		)"

RDEPEND="${DEPEND}"
BDEPEND=""

S="${WORKDIR}/${PN}-v${PV}"

usex_no() {
	usex "$1" "${2:-$1}" "no${2:-$1}"
}

usex_null() {
	usex "$1" "${2:-$1}" ""
}

src_compile() {
	cd ${S}/src/
	emake release \
		$(usex_null ttf "TTF=1") \
		$(usex_null lua "LUA=1") \
		$(usex_no x11 "API=x11") \
		$(usex_no sdl2 "API=sdl2") \
		$(usex_no joystick "USE_JOYSTICK=1") \
		$(usex_no nolayers "NOLAYERS=1") \
		$(usex_no optimizations "OPTIM=3") \
		$(usex_no norecoil "NORECOIL=1") \
		|| die "Failed to build."
}

src_install() {
	cd ${S}/src/
	emake DESTDIR="${D}" PREFIX="/usr" install
	dobin ${D}/${PN}-* ${D}/${PN}
}

pkg_postinst() {
	xdg_desktop_database_update
}

pkg_postrm() {
	xdg_desktop_database_update
}