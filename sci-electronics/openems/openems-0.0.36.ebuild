# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..12})
 
DESCRIPTION="openEMS - a free and open electromagnetic field solver"
HOMEPAGE="https://www.openems.de/"
EGIT_REPO_URI="https://github.com/thliebig/openEMS"
EGIT_COMMIT="v${PVR}"

DISTUTILS_USE_PEP517=setuptools
DISTUTILS_OPTIONAL=1
DISTUTILS_EXT=1

inherit git-r3 cmake distutils-r1

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="python"
 
DEPEND=""
BDEPEND="dev-libs/tinyxml
dev-build/cmake
sci-libs/hdf5
sci-mathematics/cgal
sci-electronics/csxcad[python?]
python? (
	${PYTHON_DEPS}
	${DISTUTILS_DEPS}
)
"
RDEPEND="${DEPEND}"

src_prepare() {
	cmake_src_prepare
	if use python; then
		cd python
		PATCHES+=( "${FILESDIR}/${PVR}-remove_unnecessary_import.patch" )
		distutils-r1_src_prepare
		cd ..
	fi
	default
}

src_compile() {
	cmake_src_compile
	if use python; then
		cd python
		distutils-r1_src_compile
		cd ..
	fi
	default
}

src_install() {
	cmake_src_install
	if use python; then
		cd python
		distutils-r1_src_install
		cd ..
	fi
	default
}
