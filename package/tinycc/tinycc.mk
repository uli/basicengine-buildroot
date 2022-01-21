################################################################################
#
# tinycc
#
################################################################################

TINYCC_VERSION = 4e0e9b8f210d69893b306d6b24d2dd615a22f246
TINYCC_SITE = git://repo.or.cz/tinycc.git
TINYCC_LICENSE = LGPL-2.1+
TINYCC_LICENSE_FILES = COPYING

# Calculate TINYCC_ARCH
ifeq ($(ARCH),aarch64)
TINYCC_ARCH = arm64
else
TINYCC_ARCH = $(ARCH)
endif

define TINYCC_BUILD_CMDS
  cd $(@D) ; ./configure --cc="$(HOSTCC)" --config-uClibc --cpu=$(TINYCC_ARCH) --prefix=/usr
  cd $(@D) ; $(HOST_MAKE_ENV) $(MAKE) cross-$(TINYCC_ARCH)
  cd $(@D) ; ./configure --cc="$(TARGET_CC)" --config-uClibc --cpu=$(TINYCC_ARCH) --prefix=/usr
  cd $(@D)/lib ; $(TARGET_MAKE_ENV) $(MAKE) $(TINYCC_ARCH)-libtcc1-usegcc=yes CC="$(TARGET_CC)"
  cd $(@D) ; $(TARGET_MAKE_ENV) $(MAKE)
endef

define TINYCC_INSTALL_TARGET_CMDS
  rm -f $(@D)/$(TINYCC_ARCH)-tcc $(@D)/$(TINYCC_ARCH)-libtcc1.a
  cd $(@D) ; $(MAKE) install DESTDIR=$(TARGET_DIR)
  cp -p $(STAGING_DIR)/usr/lib/crt?.o $(TARGET_DIR)/usr/lib/
  cp -p $(STAGING_DIR)/usr/lib/libc.so $(TARGET_DIR)/usr/lib/
endef

$(eval $(generic-package))
