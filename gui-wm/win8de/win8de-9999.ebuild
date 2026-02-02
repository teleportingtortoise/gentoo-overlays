# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit git-r3

DESCRIPTION="Extensible Wayland compositor inspired by AwesomeWM."

HOMEPAGE="https://github.com/er-bharat/Win8DE"
EGIT_REPO_URI="https://github.com/er-bharat/Win8DE.git"

LISCENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="session sddm-theme"

DEPEND="dev-build/ninja
		sys-devel/gcc
		sys-libs/glibc
		dev-libs/wayland
		gui-libs/wlroots
		dev-qt/qtbase
		dev-qt/qtdeclarative
		dev-qt/qtwayland
		sys-libs/pam
		kde-plasma/layer-shell-qt
		session? ( gui-wm/labwc )"

RDEPEND="${DEPEND}"
BDEPEND=""


src_compile() {
	sh build.sh
}

src_install() {
	dobin "${S}"/build/bin/battery-daemon
	dobin "${S}"/build/bin/list-windows
	dobin "${S}"/build/bin/Win8Corner
	dobin "${S}"/build/bin/Win8Lock
	dobin "${S}"/build/bin/Win8OSD-client
	dobin "${S}"/build/bin/Win8OSD-server
	dobin "${S}"/build/bin/Win8Running
	dobin "${S}"/build/bin/Win8Settings
	dobin "${S}"/build/bin/Win8Start
	dobin "${S}"/build/bin/Win8Wall

	if use session; then
		insinto /usr/share/
		doins -r "${S}"/assets/labwc3
		insinto /usr/share/wayland-sessions/
		doins "${S}"/assets/wayland-sessions/labwc-win8.desktop
	fi

	if use sddm-theme; then
		insinto /usr/share/sddm/themes/
		doins -r "${S}"/assets/SDDM/Win8Login
	fi
}

pkg_postinst() {
	if ! use session; then
		echo "Note: If you want to install a session to use Win8DE as your desktop environment you need to set the 'session' use flag for this package."
	fi

	if ! use sddm-theme; then
		echo "Note: If you would like to install the matching SDDM theme you need to set the 'sddm-theme' use flag for this package."
	fi
}