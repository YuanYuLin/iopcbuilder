################################################################################
#
# skeleton
#
################################################################################

# source included in buildroot
SKELETON_SOURCE =

# The skeleton can't depend on the toolchain, since all packages depends on the
# skeleton and the toolchain is a target package, as is skeleton.
# Hence, skeleton would depends on the toolchain and the toolchain would depend
# on skeleton.
SKELETON_ADD_TOOLCHAIN_DEPENDENCY = NO

# The skeleton also handles the merged /usr case in the sysroot
SKELETON_INSTALL_STAGING = YES



$(eval $(generic-package))
