EAPI=7

DESCRIPTION="FUSE filesystem for reading macOS sparse-bundle disk images."
HOMEPAGE="https://github.com/torarnv/sparsebundlefs"

EGIT_REPO_URI="https://github.com/torarnv/sparsebundlefs.git"
inherit git-r3

LICENSE="BSD"
SLOT="0"
IUSE=""

DEPEND="
	sys-fs/fuse:0=
"
RDEPEND="${DEPEND}"

src_compile() {
	emake || die "emake failed"
}

src_install() {
	newbin sparsebundlefs sparsebundlefs
}
