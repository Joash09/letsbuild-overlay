# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 cmake

DESCRIPTION="Minimal Application using the QCSXCAD library"
HOMEPAGE="https://github.com/thliebig/AppCSXCAD"
EGIT_REPO_URI="https://github.com/thliebig/AppCSXCAD.git"
EGIT_COMMIT="v${PVR}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND="
sci-electronics/qcsxcad
"
