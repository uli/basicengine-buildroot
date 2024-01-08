################################################################################
#
# allwinner-bare-metal
#
################################################################################

HOST_ALLWINNER_BARE_METAL_VERSION = jh
HOST_ALLWINNER_BARE_METAL_SITE = $(call github,uli,allwinner-bare-metal,$(HOST_ALLWINNER_BARE_METAL_VERSION))
HOST_ALLWINNER_BARE_METAL_LICENSE = GPL-2.0
HOST_ALLWINNER_BARE_METAL_LICENSE_FILES = COPYING
HOST_ALLWINNER_BARE_METAL_DEPENDENCIES = \
	host-allwinner-bare-metal-toolchain host-ninja sdl2

define HOST_ALLWINNER_BARE_METAL_CONFIGURE_CMDS
	cd $(@D) ; JAILHOUSE=1 GDBSTUB=on \
		CROSS_COMPILE="$(HOST_DIR)/x-tools/bin/arm-unknown-eabihf-" \
		JAILHOUSE_CC="$(TARGET_CC)" \
		JAILHOUSE_SYSROOT="$(STAGING_DIR)" \
		PLATFORM="$(BR2_PACKAGE_ALLWINNER_BARE_METAL_PLATFORM)" \
		./configure.sh
endef

define HOST_ALLWINNER_BARE_METAL_BUILD_CMDS
	cd $(@D) ; $(HOST_MAKE_ENV) ninja
endef

define HOST_ALLWINNER_BARE_METAL_INSTALL_CMDS
	rsync -av --delete "$(@D)/" "$(HOST_DIR)/allwinner-bare-metal/"
	cp -p "$(@D)"/*_server "$(@D)"/jailgdb "$(@D)"/video_recorder "$(@D)"/init_comms "$(TARGET_DIR)/usr/bin"
endef

$(eval $(host-generic-package))
