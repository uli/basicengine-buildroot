################################################################################
#
# Engine BASIC
#
################################################################################

ENGINEBASIC_VERSION = nextgen_jh
ENGINEBASIC_SITE = $(call github,uli,basicengine-firmware,$(ENGINEBASIC_VERSION))
ENGINEBASIC_LICENSE = GPL-3.0+
ENGINEBASIC_LICENSE_FILES = README.md
ENGINEBASIC_DEPENDENCIES = host-allwinner-bare-metal host-ninja

ENGINEBASIC_EXTRA_DOWNLOADS += \
	$(call github,uli,basicengine-demos,refs/heads/master.tar.gz)

define ENGINEBASIC_CONFIGURE_CMDS
    test -e $(HOME)/basic_engine_pcx_official.h && cp -p $(HOME)/basic_engine_pcx_official.h $(@D)/ttbasic/basic_engine_pcx.h || true
    rm -fr $(@D)/build_* $(@D)/demos
    mkdir $(@D)/demos ; tar --strip-components=1 -C $(@D)/demos -xzf $(ENGINEBASIC_DL_DIR)/master.tar.gz
    cd $(@D) ; PATH="$(STAGING_DIR)/usr/bin:$(PATH)" \
    	H3_OSDIR="$(HOST_DIR)/allwinner-bare-metal" \
    	DEMOS_DIR=$(@D)/demos JAILHOUSE=1 ./configure.sh
    mkdir -p $(@D)/.git ; touch $(@D)/.git/index
    cd $(@D) ; ninja -f build.ninja.h3 ttbasic/version.h
    echo "#define STR_VARSION \"$(shell git -C $(ENGINEBASIC_DL_DIR)/git describe --abbrev=4 --dirty --always --tags)\"" >$(@D)/ttbasic/version.h
endef

define ENGINEBASIC_BUILD_CMDS
    cd $(@D) ; ninja -v -f build.ninja.h3 && ninja -f build.ninja.h3 init_dir
endef

define ENGINEBASIC_INSTALL_TARGET_CMDS
    $(INSTALL) -D -m 0755 $(@D)/basic.bin $(TARGET_DIR)/lib/firmware/basic.bin
    $(INSTALL) -D -m 0755 $(@D)/basic.elf $(TARGET_DIR)/lib/firmware/basic.elf
    mkdir -p $(TARGET_DIR)/sd
    mkdir -p $(TARGET_DIR)/usr/share/enginebasic
    mkdir -p $(@D)/init_dir/sys/etc/dropbear
    tar -C $(@D)/init_dir -czf $(TARGET_DIR)/usr/share/enginebasic/basic_sys.tar.gz .
endef

$(eval $(generic-package))
