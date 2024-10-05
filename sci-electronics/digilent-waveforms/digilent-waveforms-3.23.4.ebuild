EAPI=8

inherit desktop xdg-utils

S="${WORKDIR}"
DESCRIPTION="WaveForms virutal instrument suite for Diligent Test and Measurement devices"
HOMEPAGE="https://cloud.digilent.com/"
SRC_URI="https://digilent.s3.us-west-2.amazonaws.com/Software/Waveforms2015/${PV}/digilent.waveforms_${PV}_amd64.deb"

LICENSE="Digilent-EULA"
SLOT=0
KEYWORDS="~amd64"
IUSE=""

RDEPEND="sci-electronics/digilent-adept-runtime
dev-qt/qtcore:5
dev-qt/qtgui:5
dev-qt/qtscript:5[scripttools]
dev-qt/qtnetwork:5
dev-qt/qtwidgets:5
dev-qt/qtserialport:5
dev-qt/qtmultimedia:5
"

# dev-qt/qtmultimedia:5
DEPEND=""
BDEPEND=""

src_unpack() {
	default
	unpack "${WORKDIR}/data.tar.xz"
}

src_prepare() {
	default
	sed -i 's/Version=3.0/Version=1.5/' usr/share/applications/digilent.waveforms.desktop || die 'Fixing .desktop version failed'
	sed -i 's/Safe Shortcut Group/X-Safe Shortcut Group/' usr/share/applications/digilent.waveforms.desktop || die 'Fixing [Safe Shortcut Group] convention for .desktop failed'
}

src_install() {

	dobin usr/bin/*

	doheader -r usr/include/digilent

	dolib.so usr/lib/libdwf.so
	dolib.so usr/lib/libdwf.so.3
	dolib.so usr/lib/libdwf.so.3.23.4

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

