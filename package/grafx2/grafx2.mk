################################################################################
#
# grafX2
#
################################################################################

GRAFX2_VERSION = aab99d474b9d775f3403c847600871a495901fad
GRAFX2_SITE = https://gitlab.com/GrafX2/grafX2.git
GRAFX2_SITE_METHOD = git
GRAFX2_DEPENDENCIES = sdl2 sdl2_image libpng tiff
GRAFX2_GIT_SUBMODULES = YES

GRAFX2_EXTRA_DOWNLOADS = https://github.com/redcode/6502/releases/download/v0.1/6502-v0.1.tar.xz

define GRAFX2_BUILD_CMDS
	mkdir -p $(@D)/3rdparty/archives
	cp -p $(GRAFX2_DL_DIR)/6502-v0.1.tar.xz $(@D)/3rdparty/archives/

	# disable online version checks
	sed -i '/shell curl/d' $(@D)/3rdparty/Makefile

	cd $(@D) ; $(MAKE) unicodefonts
	cd $(@D) ; PATH="$(STAGING_DIR)/usr/bin:$(HOST_DIR)/bin:$(PATH)" $(MAKE) CC="$(TARGET_CC)" LIBPNGCONFIG="pkg-config libpng" API=sdl2 NO_X11=1 NORECOIL=1 NOTTF=1 PREFIX=/usr V=1
endef

define GRAFX2_INSTALL_TARGET_CMDS
	cd $(@D)/src ; PATH="$(STAGING_DIR)/usr/bin:$(HOST_DIR)/bin:$(PATH)" $(MAKE) install API=sdl2 NO_X11=1 NORECOIL=1 NOTTF=1 PREFIX=/usr V=1 DESTDIR=$(TARGET_DIR)
endef

$(eval $(generic-package))
