#
# Copyright (C) 2014 Dog Hunter LLC
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=v8
PKG_VERSION:=3.28.73
PKG_RELEASE:=3

#PKG_SOURCE_PROTO:=git
#PKG_SOURCE_URL:=https://github.com/v8/v8.git
#PKG_SOURCE_VERSION:=ebead8424e181c496dc2cd5764a4f5f62e69ef44
#PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)
#PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz

PKG_SOURCE_URL:=http://download.linino.org/pkg-src/
PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz

PKG_BUILD_PARALLEL:=3

include $(INCLUDE_DIR)/package.mk

define Package/v8
  SECTION:=libs
  CATEGORY:=Libraries
  TITLE:=Google v8 javascript engine
  URL:=https://github.com/v8/v8.git
  DEPENDS:=+libstdcpp +libc +libpthread +librt
endef

define Package/v8/description
 	Port of Google v8 javascript engine to MIPS architecture
endef

define Build/Prepare
	/bin/tar xvf $(DL_DIR)/$(PKG_SOURCE) -C $(PKG_BUILD_DIR) --strip-components=1
	$(Build/Patch)
	(cd $(PKG_BUILD_DIR); \
	make builddeps);
endef

define Build/InstallDev
	$(INSTALL_DIR) $(1)/usr/lib
	$(CP) $(PKG_BUILD_DIR)/out/mips.release/lib.target/libv8.so $(1)/usr/lib/
	
	$(INSTALL_DIR) $(1)/usr/include
	$(CP) $(PKG_BUILD_DIR)/include/*.h $(1)/usr/include
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
	$(MAKE) $(PKG_JOBS) -C $(PKG_BUILD_DIR) DESTDIR="$(PKG_INSTALL_DIR)" mips.release werror=no library=shared snapshot=off i18nsupport=off
endef

define Package/v8/install
	$(INSTALL_DIR) $(1)/usr/lib
	
	$(CP) $(PKG_BUILD_DIR)/out/mips.release/lib.target/libv8.so $(1)/usr/lib
endef

$(eval $(call BuildPackage,v8))
