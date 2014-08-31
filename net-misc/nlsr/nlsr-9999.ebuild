# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit waf-utils

DESCRIPTION="Named Data Link State Routing Protocol"
HOMEPAGE="http://www.named-data.net/doc/NLSR"

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/named-data/${PN}.git"
else
	SRC_URI="http://named-data.net/downloads/ndn-platform-0.3/${P}.tar.bz2"
fi

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS=""

IUSE="c++11 debug test"

RDEPEND="
	>=dev-libs/boost-1.48:=
	dev-libs/log4cxx
	dev-libs/protobuf:=
	~net-libs/ndn-cxx-${PV}[c++11=]
"
DEPEND="${RDEPEND}
	virtual/pkgconfig
"

DOCS=( AUTHORS.md README.md docs/{RELEASE-NOTES,ROUTER-CONFIG,SECURITY-CONFIG}.rst )

src_configure() {
	waf-utils_src_configure \
		--sysconfdir="${EPREFIX}/etc" \
		$(use c++11 && echo --with-c++11) \
		$(use debug && echo --debug) \
		$(use test && echo --with-tests)
}
