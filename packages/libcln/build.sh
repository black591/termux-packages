TERMUX_PKG_HOMEPAGE=https://www.ginac.de/CLN/
TERMUX_PKG_DESCRIPTION="CLN is a library for efficient computations with all kinds of numbers in arbitrary precision"
TERMUX_PKG_LICENSE="GPL-2.0"
TERMUX_PKG_VERSION=1.3.5
TERMUX_PKG_SRCURL=https://www.ginac.de/CLN/cln-${TERMUX_PKG_VERSION}.tar.bz2
TERMUX_PKG_SHA256=78810064a50b4299a0a3c16cade54a7d2e72ac92a8ee295f9a9177efc81e842d
TERMUX_PKG_DEPENDS="libc++, libgmp"
TERMUX_PKG_BREAKS="libcln-dev"
TERMUX_PKG_REPLACES="libcln-dev"
TERMUX_PKG_BUILD_IN_SRC=true

termux_step_pre_configure() {
	if [ $TERMUX_ARCH = arm ]; then
		# See the following section in INSTALL:
		# "(*) On these platforms, problems with the assembler routines have been
		# reported. It may be best to add "-DNO_ASM" to CPPFLAGS before configuring."
		CPPFLAGS+=" -DNO_ASM"
		CXXFLAGS+=" -fintegrated-as"
	fi

	sed -i -e 's%tests/Makefile %%' configure.ac
	sed -i -e 's%examples/Makefile %%' configure.ac
	sed -i -e 's%benchmarks/Makefile %%' configure.ac

	autoreconf
}

termux_step_post_configure() {
	cd $TERMUX_PKG_SRCDIR
	sed -i -e 's% tests%%' Makefile
	sed -i -e 's% examples%%' Makefile
	sed -i -e 's% benchmarks%%' Makefile
}
