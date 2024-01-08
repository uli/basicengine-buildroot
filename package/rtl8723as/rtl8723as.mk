################################################################################
#
# rtl8723as
#
################################################################################

RTL8723AS_VERSION = 4.1.3_6044.20121224
RTL8723AS_SITE = https://github.com/gabrielepmattia/RTL8723A_WiFi_linux_v$(RTL8723AS_VERSION)/raw/master/driver
RTL8723AS_SOURCE = rtl8723A_WiFi_linux_v$(RTL8723AS_VERSION).tar.gz
RTL8723AS_LICENSE = GPL-2.0	# maybe...

RTL8723AS_MODULE_MAKE_OPTS = \
	KSRC=$(LINUX_DIR) \
	USER_EXTRA_CFLAGS="-Wno-error"

#	CONFIG_RTL8723AS=m \
#	KVER=$(LINUX_VERSION_PROBED) \

define RTL8723AS_LINUX_CONFIG_FIXUPS
	$(call KCONFIG_ENABLE_OPT,CONFIG_NET)
	$(call KCONFIG_ENABLE_OPT,CONFIG_WIRELESS)
	$(call KCONFIG_ENABLE_OPT,CONFIG_CFG80211)
	$(call KCONFIG_ENABLE_OPT,CONFIG_MMC)
endef

define RTL8723AS_BUILD_CMDS
	cd $(@D) ; make ARCH=$(NORMALIZED_ARCH) CROSS_COMPILE="$(TARGET_CROSS)" KSRC=$(LINUX_DIR) -j12
endef

define RTL8723AS_INSTALL_TARGET_CMDS
	cd $(@D) ; make ARCH=$(NORMALIZED_ARCH) CROSS_COMPILE="$(TARGET_CROSS)" KSRC=$(LINUX_DIR) install MODDESTDIR=$(TARGET_DIR)/lib/modules/$(LINUX_VERSION_PROBED)/extra
endef

#$(eval $(kernel-module))
$(eval $(generic-package))
