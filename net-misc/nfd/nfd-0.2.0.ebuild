# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit waf-utils

DESCRIPTION="NDN Forwarding Daemon"
HOMEPAGE="http://www.named-data.net/doc/NFD"

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/named-data/${PN}.git"
else
	SRC_URI="http://named-data.net/downloads/ndn-platform-0.3/${P}.tar.bz2"
fi

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE="c++11 debug +pcap +pch test +websocket"

RDEPEND="
	>=dev-libs/boost-1.48:=
	~net-libs/ndn-cxx-${PV}[c++11=]
	pcap? ( net-libs/libpcap )
"
DEPEND="${RDEPEND}
	virtual/pkgconfig
"

DOCS=( AUTHORS.md README.md docs/{FAQ,RELEASE_NOTES}.rst )

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
