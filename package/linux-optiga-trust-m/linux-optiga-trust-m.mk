################################################################################
#
# linux-optiga-trust-m
#
################################################################################

LINUX_OPTIGA_TRUST_M_VERSION = 1.0.3-sabanto

#LINUX_OPTIGA_TRUST_M_SITE = /home/pawel/github-work/pfm-secure/linux-optiga-trust-m
#LINUX_OPTIGA_TRUST_M_SITE_METHOD = local

# uese wget
#LINUX_OPTIGA_TRUST_M_SOURCE = linux-optiga-trust-m-$(LINUX_OPTIGA_TRUST_M_VERSION).tar
#LINUX_OPTIGA_TRUST_M_SITE = file:///home/pawel/github-work/pfm-secure

# git method does not work due to submodules
LINUX_OPTIGA_TRUST_M_SITE = git@github.com:sabantoag/linux-optiga-trust-m.git
LINUX_OPTIGA_TRUST_M_SITE_METHOD = git
LINUX_OPTIGA_TRUST_M_GIT_SUBMODULES = YES
LINUX_OPTIGA_TRUST_M_INSTALL = YES
LINUX_OPTIGA_TRUST_M_LICENSE = MIT
LINUX_OPTIGA_TRUST_M_LICENSE_FILES = LICENSE
#	LINUX_OPTIGA_TRUST_M_DEPENDENCIES = $(TARGET_NLS_DEPENDENCIES)


ifeq ($(BR2_STATIC_LIBS),y)
LINUX_OPTIGA_TRUST_M_MAKE_OPTS += LDFLAGS_USER=-static
endif

define LINUX_OPTIGA_TRUST_M_BUILD_CMDS
	$(TARGET_CONFIGURE_OPTS) $(MAKE) -C $(@D) $(LINUX_OPTIGA_TRUST_M_MAKE_OPTS) AARCH64=YES
endef

define LINUX_OPTIGA_TRUST_M_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0755 $(@D)/bin/libtrustm.so* $(TARGET_DIR)/usr/lib
	$(INSTALL) -D -m 0755 $(@D)/bin/trustm* $(TARGET_DIR)/usr/sbin	
	$(INSTALL) -D -m 0755 $(@D)/bin/trustm_engine.so* $(TARGET_DIR)/usr/lib/engines-1.1
	
endef

$(eval $(generic-package))