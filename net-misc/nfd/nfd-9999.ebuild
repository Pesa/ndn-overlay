# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python2_7 )
PYTHON_REQ_USE="threads(+)" # required by waf

inherit python-any-r1 waf-utils

DESCRIPTION="NDN Forwarding Daemon"
HOMEPAGE="http://www.named-data.net/doc/NFD"

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/named-data/${PN}.git"
else
	SRC_URI="http://named-data.net/downloads/${P}.tar.bz2"
fi

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS=""

IUSE="debug +pcap +pch test +websocket"

RDEPEND="
	>=dev-libs/boost-1.48:=
	~net-libs/ndn-cxx-${PV}
	pcap? ( net-libs/libpcap )
"
DEPEND="${RDEPEND}
	${PYTHON_DEPS}
	virtual/pkgconfig
"

DOCS=( AUTHORS.md README{,-dev}.md docs/{FAQ,RELEASE_NOTES}.rst )

pkg_setup() {
	python-any-r1_pkg_setup
}

src_configure() {
	waf-utils_src_configure \
		--sysconfdir="${EPREFIX}/etc" \
		$(use debug && echo --debug) \
		$(use pcap || echo --without-libpcap) \
		$(use pch || echo --without-pch) \
		$(use test && echo --with-tests) \
		$(use websocket || echo --without-websocket)
}
