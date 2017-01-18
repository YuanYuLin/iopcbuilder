################################################################################
#
# cpupower
#
################################################################################

LINUX_TOOLS += cpupower

CPUPOWER_DEPENDENCIES = pciutils

LINUX_TOOLS_PACKAGE_DIR = $(BASE_DIR)/packages/linux_tools

CPUPOWER_MAKE_OPTS = CROSS=$(TARGET_CROSS) \
	CPUFREQ_BENCH=false \
	DEBUG=false

define CPUPOWER_BUILD_CMDS
	$(Q)if test ! -f $(@D)/tools/power/cpupower/Makefile ; then \
		echo "Your kernel version is too old and does not have the cpupower tool." ; \
		echo "At least kernel 3.4 must be used." ; \
		exit 1 ; \
	fi

	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D)/tools \
		$(CPUPOWER_MAKE_OPTS) \
		cpupower
endef

define CPUPOWER_INSTALL_STAGING_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D)/tools \
		$(CPUPOWER_MAKE_OPTS) \
		DESTDIR=$(STAGING_DIR) \
		cpupower_install
endef

define CPUPOWER_INSTALL_TARGET_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D)/tools \
		$(CPUPOWER_MAKE_OPTS) \
		DESTDIR=$(LINUX_TOOLS_PACKAGE_DIR) \
		cpupower_install
endef
