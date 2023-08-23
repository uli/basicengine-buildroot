################################################################################
#
# cedrus-mainline
#
################################################################################

CEDRUS_VERSION = 25b95dbc9f7cae62b6e42763584d1365d8677ed9
CEDRUS_SITE = $(call github,uboborov,cedrus,$(CEDRUS_VERSION))
CEDRUS_LICENSE = GPL-2.0
CEDRUS_LICENSE_FILES = LICENSE

define CEDRUS_BUILD_CMDS
	sed -i 's,#include.*stropts,//,' $(@D)/common/*
	cd $(@D); for i in h264enc ; do cd $$i ; $(TARGET_MAKE_ENV) $(MAKE) CC="$(TARGET_CC)" CFLAGS="$(TARGET_CFLAGS) -I../common" || break ; cd .. ; done
endef

define CEDRUS_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0755 $(@D)/h264enc/h264enc $(TARGET_DIR)/usr/bin
endef

$(eval $(generic-package))
