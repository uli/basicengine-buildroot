SUNXI_DT_OVERLAYS_VERSION = $(LINUX_VERSION)
SUNXI_DT_OVERLAYS_DEPENDENCIES = host-dtc linux
SUNXI_DT_OVERLAYS_INSTALL_IMAGES = YES

define SUNXI_DT_OVERLAYS_INSTALL_IMAGES_CMDS
	cd $(@D)/../linux-$(LINUX_VERSION)/arch/arm/boot/dts/overlay ; for i in *.dtbo ; do x="`echo "$$i"|sed 's,^\([^-]*-[^-]*\)-,\1/,'`" ; $(INSTALL) -D -m 0644 "$$i" $(BINARIES_DIR)/overlays/"$$x" ; done
endef

$(eval $(generic-package))
