# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit git-r3

DESCRIPTION="Extensible Wayland compositor inspired by AwesomeWM."

HOMEPAGE="https://github.com/Cudiph/cwcwm"
EGIT_REPO_URI="https://github.com/Cudiph/cwcwm.git"

LISCENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-libs/wayland
		>=gui-libs/wlroots-9999[x11-backend,xcb-errors]
		>=dev-libs/wayland-protocols-9999
		>=x11-libs/libdrm-9999
		dev-python/pywlroots
		gui-libs/hyprcursor
		x11-libs/cairo
		dev-python/xkbcommon
		dev-libs/libinput
		dev-libs/xxhash
		dev-lang/luajit
		x11-base/xwayland
		x11-misc/xcb
		dev-lua/lgi
		dev-lua/ldoc
		x11-libs/pango
		dev-build/meson
		dev-build/ninja"

RDEPEND="${DEPEND}"
BDEPEND=""


src_compile() {
	meson setup build -Dplugins=true --buildtype=release
	ninja -C build
	make docs
}

src_install() {
	emake DESTDIR="${D}" PREFIX="/usr" install
}