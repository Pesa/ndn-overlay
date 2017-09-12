# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

PYTHON_COMPAT=( python2_7 )
PYTHON_REQ_USE="threads(+)" # required by waf

inherit python-any-r1 waf-utils

DESCRIPTION="Named Data Link State Routing Protocol"
HOMEPAGE="http://www.named-data.net/doc/NLSR"

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/named-data/${PN}.git"
else
	SRC_URI="http://named-data.net/downloads/${P}.tar.bz2"
fi

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS=""

IUSE="debug test"

RDEPEND="
	>=dev-libs/boost-1.48:=
	dev-libs/log4cxx
	dev-libs/protobuf:=
	~net-libs/ndn-cxx-${PV}
"
DEPEND="${RDEPEND}
	${PYTHON_DEPS}
	virtual/pkgconfig
"

DOCS=( AUTHORS.md README{,-dev}.md docs/{RELEASE-NOTES,ROUTER-CONFIG,SECURITY-CONFIG}.rst )

pkg_setup() {
	python-any-r1_pkg_setup
}

src_configure() {
	waf-utils_src_configure \
		--sysconfdir="${EPREFIX}/etc" \
		$(use debug && echo --debug) \
		$(use test && echo --with-tests)
}
