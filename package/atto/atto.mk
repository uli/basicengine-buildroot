################################################################################
#
# atto
#
################################################################################

ATTO_VERSION = 5ec936bcab8a7ceb54794125037fc7c8cf0cc366
ATTO_SITE = $(call github,hughbarney,atto,$(ATTO_VERSION))
ATTO_LICENSE = Public Domain

ATTO_DEPENDENCIES = ncurses

define ATTO_BUILD_CMDS
	$(MAKE) -C $(@D) CC="$(TARGET_CC)" LD="$(TARGET_CC)" CFLAGS="$(TARGET_CFLAGS)"
endef

define ATTO_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0755 $(@D)/atto $(TARGET_DIR)/usr/bin/atto
endef

$(eval $(generic-package))
