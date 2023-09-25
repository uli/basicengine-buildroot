################################################################################
#
# allwinner-bare-metal-toolchain
#
################################################################################

HOST_ALLWINNER_BARE_METAL_TOOLCHAIN_VERSION = c116c9a2cdbff69758142b395fe727c2398ac80e
HOST_ALLWINNER_BARE_METAL_TOOLCHAIN_SITE = $(call github,crosstool-ng,crosstool-ng,$(HOST_ALLWINNER_BARE_METAL_TOOLCHAIN_VERSION))
HOST_ALLWINNER_BARE_METAL_TOOLCHAIN_LICENSE = GPL-2.0
HOST_ALLWINNER_BARE_METAL_TOOLCHAIN_LICENSE_FILES = COPYING
HOST_ALLWINNER_BARE_METAL_TOOLCHAIN_DEPENDENCIES = \
	host-flex host-bison

HOST_ALLWINNER_BARE_METAL_TOOLCHAIN_MAKE_OPTS = \

#	CROSS_COMPILE="$(TARGET_CROSS)" \
#	ARCH="$(KERNEL_ARCH)" \
#	KDIR="$(LINUX_DIR)" \
#	DESTDIR="$(TARGET_DIR)"

define HOST_ALLWINNER_BARE_METAL_TOOLCHAIN_CONFIGURE_CMDS
	cd $(@D) ; $(HOST_MAKE_ENV) ./bootstrap ; $(HOST_MAKE_ENV) ./configure --enable-local && $(HOST_MAKE_ENV) $(MAKE)
	sed -e "s,^.*CT_PREFIX_DIR=.*$$,CT_PREFIX_DIR=\"$(HOST_DIR)/x-tools\"," \
	    -e "s,^.*CT_LOCAL_TARBALLS_DIR.*$$,CT_LOCAL_TARBALLS_DIR=\"$(CONFIG_DIR)/dl\"," \
	    -e "s,^.*CT_TARBALLS_BUILDROOT_LAYOUT.*$$,CT_TARBALLS_BUILDROOT_LAYOUT=y," \
	    <$(HOST_ALLWINNER_BARE_METAL_TOOLCHAIN_PKGDIR)/crosstool-ng.config >$(@D)/.config
endef

define HOST_ALLWINNER_BARE_METAL_TOOLCHAIN_BUILD_CMDS
	cd $(@D) ; ./ct-ng build
endef

define HOST_ALLWINNER_BARE_METAL_TOOLCHAIN_INSTALL_TARGET_CMDS
endef

$(eval $(host-generic-package))
