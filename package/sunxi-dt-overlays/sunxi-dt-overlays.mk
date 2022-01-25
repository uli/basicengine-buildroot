SUNXI_DT_OVERLAYS_VERSION = master
SUNXI_DT_OVERLAYS_SITE = $(call github,armbian,sunxi-DT-overlays,$(SUNXI_DT_OVERLAYS_VERSION))
SUNXI_DT_OVERLAYS_LICENSE = GPL-3.0+
SUNXI_DT_OVERLAYS_LICENSE_FILES = LICENSE
SUNXI_DT_OVERLAYS_DEPENDENCIES = host-dtc
SUNXI_DT_OVERLAYS_INSTALL_IMAGES = YES

define SUNXI_DT_OVERLAYS_BUILD_CMDS
	for i in $(@D)/*/*.dts ; do $(HOST_DIR)/bin/dtc -O dtb -o "$${i%.dts}.dtbo" -b 0 -@ "$$i" ; done
endef

define SUNXI_DT_OVERLAYS_INSTALL_IMAGES_CMDS
	cd $(@D) ; for i in */*.dtbo ; do $(INSTALL) -D -m 0644 "$$i" $(BINARIES_DIR)/overlays/"$$i" ; done
endef

$(eval $(generic-package))
