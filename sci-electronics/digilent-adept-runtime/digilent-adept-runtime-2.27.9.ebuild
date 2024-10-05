EAPI=8

inherit udev

S="${WORKDIR}/digilent.adept.runtime_${PV}-x86_64"
DESCRIPTION="Adept runtime for Linux"
HOMEPAGE="https://lp.digilent.com/complete-adept-runtime-download"
SRC_URI="https://digilent.s3.us-west-2.amazonaws.com/Software/Adept2+Runtime/${PV}/digilent.adept.runtime_${PV}-x86_64.tar.gz"

LICENSE="Digilent-EULA"
SLOT=0
KEYWORDS="~amd64"
IUSE=""

RDEPEND="virtual/udev
virtual/libusb
net-dns/avahi"
DEPEND="${RDEPEND}"
BDEPEND=""

src_install() {

	# Shared libraries
	insinto /usr/lib64/digilent/adept
	insopts -m0755
	doins lib64/*

	# Binary
	dosbin  bin64/dftdrvdtch

	# Application share data
	insinto /usr/share/digilent/adept
	doins -r data/

	# Configuration files
	insinto /etc
	doins digilent-adept.conf
	insinto /etc/ld.so.conf.d/
	doins digilent-adept-libraries.conf

	# udev rules
	udev_dorules 52-digilent-usb.rules

	# FTDI drivers
	insinto /usr/lib64
	dolib.so ftdi.drivers_1.4.24-x86_64/lib64/libftd2xx.so.1.4.24
	dosym libftd2xx.so.1.4.24 ${EP}/usr/lib64/libftd2xx.so.1
	dosym libftd2xx.so.1.4.24 ${EP}/usr/lib64/libftd2xx.so

}

pkg_postinst() {

	udev_reload

}

pkg_postrm() {

	udev_reload

}
