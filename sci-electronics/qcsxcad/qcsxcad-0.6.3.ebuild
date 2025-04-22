# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 cmake

DESCRIPTION="The Qt-GUI for CSXCAD, a C++ library to describe geometrical objects and their physical or non-physical properties"
HOMEPAGE="https://github.com/thliebig/QCSXCAD"
EGIT_REPO_URI="https://github.com/thliebig/QCSXCAD.git"
EGIT_COMMIT="v${PVR}"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND="
dev-qt/qtbase
dev-qt/qt5compat
sci-electronics/csxcad
"
