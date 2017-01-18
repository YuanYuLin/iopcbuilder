################################################################################
#
# msgpack-c
#
################################################################################

MSGPACK_C_SOURCE = msgpack-1.4.2.tar.gz
MSGPACK_C_SITE = file:///tmp
MSGPACK_C_LICENSE = Apache-2.0
MSGPACK_C_LICENSE_FILES = COPYING

$(eval $(autotools-package))
