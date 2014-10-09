# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
USE_RUBY="ruby19 ruby20"

RUBY_FAKEGEM_TASK_DOC="yard"
RUBY_FAKEGEM_DOCDIR="doc"

RUBY_FAKEGEM_TASK_TEST="spec"

inherit ruby-fakegem

DESCRIPTION="EventMachine based WebSocket server"
HOMEPAGE="https://github.com/igrigorik/em-websocket"
SRC_URI="https://rubygems.org/gems/${P}.gem"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

# Tests fail with load errors, possibly due to unfulfilled
# dependencies. Needs ot be investigated before moved to main tree.
#RESTRICT="test"

#ruby_add_bdepend "doc? ( dev-ruby/yard )"
#ruby_add_bdepend "test? ( dev-ruby/rspec )"

ruby_add_rdepend "
		>=dev-ruby/eventmachine-0.12.9 
		>=dev-ruby/addressable-2.1.1
		dev-ruby/em-websocket-client
		=dev-ruby/em-http-request-1.1*"

each_ruby_prepare() {
	# We don't want to pull deps directly from a git repro.
	sed -i -e 's/, git.*//' Gemfile || die

	if [ -f Gemfile ]
	then
		BUNDLE_GEMFILE=Gemfile ${RUBY} -S bundle install --local || die
		BUNDLE_GEMFILE=Gemfile ${RUBY} -S bundle check || die
	fi
}
