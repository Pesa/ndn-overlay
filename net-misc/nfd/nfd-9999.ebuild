# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit waf-utils
[[ ${PV} == *9999 ]] && inherit git-r3

DESCRIPTION="NDN Forwarding Daemon"
HOMEPAGE="http://www.named-data.net/doc/NFD"
EGIT_REPO_URI="https://github.com/named-data/NFD.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""

IUSE="c++11 debug +pcap +pch test +websocket"

RDEPEND="
	>=dev-libs/boost-1.48:0=
	~net-libs/ndn-cxx-9999[c++11=]
	pcap? ( net-libs/libpcap )
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
		$(use pcap || echo --without-libpcap) \
		$(use pch || echo --without-pch) \
		$(use test && echo --with-tests) \
		$(use websocket || echo --without-websocket)
}
