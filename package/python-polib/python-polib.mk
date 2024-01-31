################################################################################
#
# python-polib
#
################################################################################

PYTHON_POLIB_VERSION = 1.2.0
PYTHON_POLIB_SOURCE = polib-$(PYTHON_POLIB_VERSION).tar.gz
PYTHON_POLIB_SITE = https://files.pythonhosted.org/packages/10/9a/79b1067d27e38ddf84fe7da6ec516f1743f31f752c6122193e7bce38bdbf
PYTHON_POLIB_LICENSE = BSD-3-Clause
PYTHON_POLIB_LICENSE_FILES = LICENSE
PYTHON_POLIB_SETUP_TYPE = setuptools

$(eval $(host-python-package))
