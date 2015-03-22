#
# Copyright (C) 2014 Dog Hunter 2014
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NPM_NAME:=nitrogen-leveldb-store
PKG_NAME:=node-$(PKG_NPM_NAME)
PKG_VERSION:=0.2.0
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NPM_NAME)-mips-$(PKG_VERSION).tgz
PKG_SOURCE_URL:=http://download.linino.org/pkg-src/
PKG_MD5SUM:=6adb8bb803b2fec7c9dbd021bb7d84b8

PKG_BUILD_DEPENDS:=node
PKG_NODE_VERSION:=0.10.37

include $(INCLUDE_DIR)/package.mk

define Package/node-nitrogen-leveldb-store
  DEPENDS:=+node +node-nitrogen
  SUBMENU:=Node.js
  SECTION:=lang
  CATEGORY:=Languages
  TITLE:=This is the leveldb storage backend for devices to store credential information.
  URL:=https://www.npmjs.org/package/nitrogen-leveldb-store
endef

define Package/node-nitrogen-leveldb-store/description
	Nitrogen is a platform for building connected devices. Nitrogen provides the authentication,
	authorization, and real time message passing framework so that you can focus on your device and application
endef

define Build/Prepare
	/bin/tar xzf $(DL_DIR)/$(PKG_SOURCE) -C $(PKG_BUILD_DIR) --strip-components=1
	$(Build/Patch)
endef

define Build/Compile
	CC="$(TOOLCHAIN_DIR)/bin/mips-openwrt-linux-gcc" \
	CXX="$(TOOLCHAIN_DIR)/bin/mips-openwrt-linux-g++" \
	AR="$(TOOLCHAIN_DIR)/bin/mips-openwrt-linux-ar" \
	RANLIB="$(TOOLCHAIN_DIR)/bin/mips-openwrt-linux-ranlib" \
	LINK="$(TOOLCHAIN_DIR)/bin/mips-openwrt-linux-g++" \
	LD="$(TOOLCHAIN_DIR)/bin/mips-openwrt-linux-g++" \
	PATH="/usr/bin/:$(PATH)" \
	GYPFLAGS="-Dv8_use_mips_abi_hardfloat=false -Dv8_can_use_fpu_instructions=false" \
	LDFLAGS="-L$(TOOLCHAIN_DIR)/lib/ -Wl,-rpath-link $(TOOLCHAIN_DIR)/lib/" \
	npm_config_arch=mips \
	npm_config_nodedir=$(BUILD_DIR)/node-v$(PKG_NODE_VERSION)/ \
	PREFIX="$(PKG_INSTALL_DIR)/usr/" \
	npm install --target_arch=mips -g $(PKG_BUILD_DIR)
endef

define Package/node-nitrogen-leveldb-store/install
	$(INSTALL_DIR) $(1)/usr/lib/
	
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/node_modules $(1)/usr/lib/
endef

define Package/$(PKG_NAME)/postrm
#!/bin/sh
# check if we are on a real system
if `grep -qs '/opt' /proc/mounts`
then
    rm -rvf /opt/usr/lib/node_modules/$(PKG_NPM_NAME)
else
    rm -rvf /usr/lib/node_modules/$(PKG_NPM_NAME)
fi
endef

$(eval $(call BuildPackage,node-nitrogen-leveldb-store))
