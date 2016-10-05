# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

PYTHON_COMPAT=( python2_7 python3_{3,4,5} )
PYTHON_REQ_USE="threads(+)" # required by waf

inherit python-any-r1 waf-utils

DESCRIPTION="NDN C++ library with eXperimental eXtensions"
HOMEPAGE="http://www.named-data.net/doc/ndn-cxx"

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/named-data/${PN}.git"
else
	SRC_URI="http://named-data.net/downloads/${P}.tar.bz2"
fi

LICENSE="LGPL-3+"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"

IUSE="debug examples +pch static-libs test +tools"

RDEPEND="
	dev-db/sqlite:3
	>=dev-libs/boost-1.54:=
	dev-libs/crypto++:=
	>=dev-libs/openssl-1.0.1:0=
"
DEPEND="${RDEPEND}
	${PYTHON_DEPS}
	virtual/pkgconfig
"

DOCS=( AUTHORS.md README{,-dev}.md docs/release-notes/ )

pkg_setup() {
	python-any-r1_pkg_setup
}

src_configure() {
	waf-utils_src_configure \
		--sysconfdir="${EPREFIX}/etc" \
		$(usex debug --debug '') \
		$(usex examples --with-examples '') \
		$(usex pch '' --without-pch) \
		$(use_enable static-libs static) \
		$(usex test --with-tests '') \
		$(usex tools '' --without-tools)
}
