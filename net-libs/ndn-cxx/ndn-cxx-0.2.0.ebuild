# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit waf-utils

DESCRIPTION="NDN C++ library with eXperimental eXtensions"
HOMEPAGE="http://www.named-data.net/doc/ndn-cxx"

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/named-data/${PN}.git"
else
	SRC_URI="http://named-data.net/downloads/ndn-platform-0.3/${P}.tar.bz2"
fi

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE="c++11 debug +pch test +tools"

RDEPEND="
	dev-db/sqlite:3
	>=dev-libs/boost-1.48:=
	dev-libs/crypto++
	dev-libs/openssl:0
"
DEPEND="${RDEPEND}
	virtual/pkgconfig
"

DOCS=( AUTHORS.md README.md docs/RELEASE_NOTES.rst )

src_configure() {
	waf-utils_src_configure \
		--sysconfdir="${EPREFIX}/etc" \
		$(use c++11 && echo --with-c++11) \
		$(use debug && echo --debug) \
		$(use pch || echo --without-pch) \
		$(use test && echo --with-tests) \
		$(use tools || echo --without-tools)
}
