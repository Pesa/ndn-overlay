# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

PYTHON_COMPAT=( python2_7 python3_{4,5} )
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
	>=dev-libs/boost-1.54:=
	~net-libs/ndn-cxx-${PV}:=
	pcap? ( net-libs/libpcap )
"
DEPEND="${RDEPEND}
	${PYTHON_DEPS}
	virtual/pkgconfig
"

DOCS=( AUTHORS.md README{,-dev}.md docs/FAQ.rst docs/release-notes/ )

pkg_setup() {
	python-any-r1_pkg_setup
}

src_configure() {
	waf-utils_src_configure \
		--sysconfdir="${EPREFIX}/etc" \
		$(usex debug --debug '') \
		$(usex pcap '' --without-libpcap) \
		$(usex pch '' --without-pch) \
		$(usex test --with-tests '') \
		$(usex websocket '' --without-websocket)
}
