################################################################################
#
# urandom-scripts
#
################################################################################

define URANDOM_SCRIPTS_INSTALL_INIT_SYSV
	$(INSTALL) -D -m 0755 $(URANDOM_SCRIPTS_PKGDIR)/S20seedrng \
		$(TARGET_DIR)/etc/init.d/S05seedrng
endef

$(eval $(generic-package))
