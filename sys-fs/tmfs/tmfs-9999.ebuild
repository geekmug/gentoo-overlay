# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="A read-only virtual filesystem which helps you to read your Apple's time machine backup."
HOMEPAGE="https://github.com/abique/tmfs"

inherit cmake

EGIT_REPO_URI="https://github.com/abique/tmfs.git"
inherit git-r3

LICENSE="MIT"
SLOT="0"
IUSE=""

DEPEND="
        sys-fs/fuse:0=
"
RDEPEND="${DEPEND}"

