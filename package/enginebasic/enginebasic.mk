################################################################################
#
# Engine BASIC
#
################################################################################

ENGINEBASIC_VERSION = sdl2
ENGINEBASIC_SITE = $(call github,uli,basicengine-firmware,$(ENGINEBASIC_VERSION))
#ENGINEBASIC_SITE = $(HOME)/devel/basic/enginebasic
ENGINEBASIC_SITE_METHOD = git
ENGINEBASIC_LICENSE = GPL-3.0+
ENGINEBASIC_LICENSE_FILES = README.md
ENGINEBASIC_DEPENDENCIES = sdl2 host-ninja libgpiod

ENGINEBASIC_EXTRA_DOWNLOADS += \
	$(call github,uli,basicengine-demos,refs/heads/master.tar.gz)

define ENGINEBASIC_BUILD_CMDS
    test -e $(HOME)/basic_engine_pcx_official.h && cp -p $(HOME)/basic_engine_pcx_official.h $(@D)/ttbasic/basic_engine_pcx.h || true
    rm -fr $(@D)/build_* $(@D)/demos
    mkdir $(@D)/demos ; tar --strip-components=1 -C $(@D)/demos -xzf $(ENGINEBASIC_DL_DIR)/master.tar.gz
    cd $(@D) ; PATH="$(STAGING_DIR)/usr/bin:$(PATH)" CC="$(TARGET_CC)" CXX="$(TARGET_CXX)" DEMOS_DIR=$(@D)/demos ./configure.sh
    mkdir -p $(@D)/.git ; touch $(@D)/.git/index
    cd $(@D) ; ninja -f build.ninja.sdl ttbasic/version.h
    echo "#define STR_VARSION \"$(shell git -C $(ENGINEBASIC_DL_DIR)/git describe --abbrev=4 --dirty --always --tags)\"" >$(@D)/ttbasic/version.h
    cd $(@D) ; ninja -f build.ninja.sdl ; ninja -f build.ninja.sdl init_dir
endef

define ENGINEBASIC_INSTALL_TARGET_CMDS
    $(INSTALL) -D -m 0755 $(@D)/basic.sdl $(TARGET_DIR)/usr/bin/enginebasic
    mkdir -p $(TARGET_DIR)/basic
    mkdir -p $(TARGET_DIR)/usr/share/enginebasic
    mkdir -p $(@D)/init_dir/sys/etc/dropbear
    tar -C $(@D)/init_dir -czf $(TARGET_DIR)/usr/share/enginebasic/basic_sys.tar.gz .
endef

$(eval $(generic-package))
