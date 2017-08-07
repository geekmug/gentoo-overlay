EAPI=6

PYTHON_COMPAT=( python2_7 )

inherit autotools eutils python-any-r1

DESCRIPTION="oVirt Guest Agent"
HOMEPAGE="http://www.ovirt.org"
SRC_URI="https://github.com/oVirt/ovirt-guest-agent/archive/${PV}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}
	${PYTHON_DEPS}"

src_prepare() {
	eapply_user
	eautoreconf
}

src_configure() {
	econf --without-gdm --without-kdm
}

src_compile() {
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	find "${D}" -name '*.la' -delete || die
	find "${D}" -name '*.a' -delete || die
	rm -rf ${D}/etc/dbus-1
	rm -rf ${D}/etc/udev
	rm -rf ${D}/var/lib/log/ovirt-guest-agent

	chmod a+x ${D}/usr/share/ovirt-guest-agent/ovirt-guest-agent.py

	dodir /var/log/ovirt-guest-agent

	# Replace consolehelper with direct symlinks
	rm -rf ${D}/etc/pam.d
	rm -rf ${D}/etc/security/console.apps
	ln -sf /usr/share/ovirt-guest-agent/container-list ${D}/usr/share/ovirt-guest-agent/ovirt-container-list
	ln -sf /usr/share/ovirt-guest-agent/scripts/hooks/defaults/flush-caches ${D}/usr/share/ovirt-guest-agent/ovirt-flush-caches
	ln -sf /usr/share/ovirt-guest-agent/hibernate ${D}/usr/share/ovirt-guest-agent/ovirt-hibernate
	ln -sf /usr/share/ovirt-guest-agent/LockActiveSession.py ${D}/usr/share/ovirt-guest-agent/ovirt-locksession
	ln -sf /usr/share/ovirt-guest-agent/LogoutActiveUser.py ${D}/usr/share/ovirt-guest-agent/ovirt-logout
	ln -sf /sbin/shutdown ${D}/usr/share/ovirt-guest-agent/ovirt-shutdown

        # Normal init stuff
        newinitd "${FILESDIR}/ovirt-guest-agent.init" ovirt-guest-agent
        newconfd "${FILESDIR}/ovirt-guest-agent.conf" ovirt-guest-agent

	# Log rotation
        insinto /etc/logrotate.d
        newins "${FILESDIR}/ovirt-guest-agent.logrotate" ovirt-guest-agent
}
