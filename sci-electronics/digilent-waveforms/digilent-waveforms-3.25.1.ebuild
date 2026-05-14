# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop xdg-utils rpm

DESCRIPTION="WaveForms virutal instrument suite for Diligent Test and Measurement devices"
HOMEPAGE="https://cloud.digilent.com/"
SRC_URI="https://files.digilent.com/Software/Waveforms/${PV}/digilent.waveforms_${PV}.aarch64.rpm"

LICENSE="Digilent-EULA"
SLOT=0
KEYWORDS="~amd64"
IUSE=""

# Depends: libc6 (>=2.35), xdg-utils, digilent.adept.runtime (>=2.27.9), libgl1-mesa-dri, libqt6core6, libqt6widgets6, libqt6multimedia6, libqt6qml6, libqt6serialport6

RDEPEND="sci-electronics/digilent-adept-runtime
dev-qt/qtbase[gui,widgets]
dev-qt/qtmultimedia
dev-qt/qtdeclarative
dev-qt/qtserialport
"
DEPEND=""
BDEPEND="app-arch/rpm2targz"

S="${WORKDIR}"

src_install() {

	dobin usr/bin/*

	doheader -r usr/include/digilent

	dolib.so usr/lib/libdwf.so
	dolib.so usr/lib/libdwf.so.3
	dolib.so usr/lib/libdwf.so.3.25.1

	for manpage in usr/share/man/man1/*.gz; do
		gunzip "$manpage"
		doman "${manpage/.gz/}"
	done

	domenu usr/share/applications/digilent.waveforms.desktop

	(
		insinto /usr/share
		doins -r usr/share/digilent
		doins -r usr/share/mime
	)

	(
		dodoc usr/share/doc/digilent.waveforms/changelog.gz
		dodoc usr/share/doc/digilent.waveforms/copyright
	)

}

pkg_postinst() {
	xdg_icon_cache_update
	xdg_desktop_database_update
	xdg_mimeinfo_database_update
}

pkg_postrm() {
	xdg_icon_cache_update
	xdg_desktop_database_update
	xdg_mimeinfo_database_update
}

