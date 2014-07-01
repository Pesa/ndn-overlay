# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit waf-utils
[[ ${PV} == *9999 ]] && inherit git-r3

DESCRIPTION="NDN C++ library with eXperimental eXtensions"
HOMEPAGE="http://www.named-data.net/doc/ndn-cxx"
EGIT_REPO_URI="https://github.com/named-data/ndn-cxx.git"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS=""

IUSE="c++11 debug +pch test +tools"

RDEPEND="
	dev-db/sqlite:3
	>=dev-libs/boost-1.48:0=
	dev-libs/crypto++
	dev-libs/openssl:0
"
DEPEND="${RDEPEND}
	virtual/pkgconfig
"

DOCS=( AUTHORS.md README{,-dev}.md )

src_configure() {
	waf-utils_src_configure \
		--sysconfdir="${EPREFIX}/etc" \
		$(use c++11 && echo --with-c++11) \
		$(use debug && echo --debug) \
		$(use pch || echo --without-pch) \
		$(use test && echo --with-tests) \
		$(use tools || echo --without-tools)
}
