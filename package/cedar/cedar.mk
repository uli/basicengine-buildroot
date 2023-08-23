################################################################################
#
# cedar-mainline
#
################################################################################

CEDAR_VERSION = 9333efb3a7f9faff3809345cd748621a90ed9701
CEDAR_SITE = $(call github,Rexarrior,sunxi-cedar-mainline,$(CEDAR_VERSION))
CEDAR_LICENSE = GPL-2.0
CEDAR_LICENSE_FILES = LICENSE

$(eval $(kernel-module))
$(eval $(generic-package))
