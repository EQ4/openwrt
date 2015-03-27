#
# Copyright (C) 2006-2014 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=bluez
PKG_VERSION:=5.29
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=http://www.kernel.org/pub/linux/bluetooth
PKG_MD5SUM:=8c3fdc351aed8ca558e2d93a7d97dd87

PKG_BUILD_PARALLEL:=1
PKG_FIXUP:=autoreconf

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/nls.mk

define Package/bluez/Default
  URL:=http://www.bluez.org/
endef

define Package/bluez-utils
$(call Package/bluez/Default)
  SECTION:=utils
  CATEGORY:=Utilities
  TITLE:=Bluetooth utilities
  DEPENDS:=+bluez-libs +libncurses
endef

define Package/bluez-libs
$(call Package/bluez/Default)
  SECTION:=libs
  CATEGORY:=Libraries
  TITLE:=Bluetooth libraries
  DEPENDS:=+libpthread +libreadline +libncurses +libusb-1.0 +glib2 +dbus +udev $(INTL_DEPENDS) $(ICONV_DEPENDS)
endef

define Package/bluez-utils/conffiles
/etc/dbus-1/system.d/bluetooth.conf
endef

CONFIGURE_ARGS += \
	--disable-systemd \
	--disable-cups \
	--disable-obex \
	--enable-client \
	--enable-library \
	--enable-tools \
	--enable-experimental \
	--enable-test \
	--enable-sixaxis \
	--enable-udev
#--with-udevdir="$(STAGING_DIR)/lib/udev"

TARGET_CFLAGS += $(FPIC)

define Build/Compile
	$(MAKE) -C $(PKG_BUILD_DIR) \
	LDFLAGS="$(TARGET_LDFLAGS) \
	-L$(ICONV_PREFIX)/lib \
	-L$(INTL_PREFIX)/lib -lm -lncurses" \
	DESTDIR="$(PKG_INSTALL_DIR)" \
	all install
endef

define Build/InstallDev
	$(INSTALL_DIR) $(1)/usr/include/bluetooth
	$(CP) $(PKG_INSTALL_DIR)/usr/include/bluetooth/*.h $(1)/usr/include/bluetooth
	
	$(INSTALL_DIR) $(1)/usr/lib
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/* $(1)/usr/lib/
	
	$(INSTALL_DIR) $(1)/usr/lib/pkgconfig
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/pkgconfig/bluez.pc $(1)/usr/lib/pkgconfig/
endef

define Package/bluez-utils/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/bin/* $(1)/usr/bin/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/attrib/gatttool $(1)/usr/bin/

	$(INSTALL_DIR) $(1)/usr/sbin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/lib/bluetooth/{bluetoothd,obexd} $(1)/usr/sbin

	$(INSTALL_DIR) $(1)/etc/dbus-1/system.d
	$(INSTALL_DATA) $(PKG_INSTALL_DIR)/etc/dbus-1/system.d/bluetooth.conf $(1)/etc/dbus-1/system.d

	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/bluetooth.init $(1)/etc/init.d/bluetooth
	$(INSTALL_DIR) $(1)/etc/bluetooth
	$(INSTALL_DATA) ./files/main.conf $(1)/etc/bluetooth
endef

define Package/bluez-libs/install
	$(INSTALL_DIR) $(1)/usr/lib/
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/lib* $(1)/usr/lib/

	$(INSTALL_DIR) $(1)/lib/udev/
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/lib/udev/hid2hci $(1)/lib/udev

	$(INSTALL_DIR) $(1)/lib/udev/rules.d/
	$(CP) $(PKG_INSTALL_DIR)/lib/udev/rules.d/* $(1)/lib/udev/rules.d/
endef

$(eval $(call BuildPackage,bluez-utils))
$(eval $(call BuildPackage,bluez-libs))
