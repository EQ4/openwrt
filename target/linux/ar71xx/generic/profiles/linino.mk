# Copyright (c) dog hunter AG - Zug - CH
# General Public License version 2 (GPLv2)
# Author Mimmo La Fauci <mimmo@linino.org>

define Profile/LININO
	NAME:=Linino All Profiles
	PACKAGES:=kmod-usb-core kmod-usb-ohci kmod-usb2 kmod-ledtrig-usbdev kmod-usb-storage \
		kmod-fs-vfat kmod-fs-msdos kmod-fs-ntfs kmod-fs-ext4 \
		kmod-nls-cp437 kmod-nls-cp850 kmod-nls-cp852 kmod-nls-iso8859-1 kmod-nls-utf8
endef

define Profile/LININO/Description
	Select this in order to build an image for every Linino's board.
endef

$(eval $(call Profile,LININO))

define Profile/LININO_YUNONE
	NAME:=Linino Yun & One
	PACKAGES:=kmod-usb-core kmod-usb-ohci kmod-usb2 kmod-ledtrig-usbdev kmod-usb-storage \
		kmod-fs-vfat kmod-fs-msdos kmod-fs-ntfs kmod-fs-ext4 \
		kmod-nls-cp437 kmod-nls-cp850 kmod-nls-cp852 kmod-nls-iso8859-1 kmod-nls-utf8
endef

define Profile/LININO_YUNONE/Description
	Select this in order to build an image for Arduino Yun and Linino One
endef

$(eval $(call Profile,LININO_YUNONE))

define Profile/LININO_YUN
	NAME:=Linino Arduino Yun
	PACKAGES:=kmod-usb-core kmod-usb2 luci-app-arduino-webpanel
endef

define Profile/LININO_YUN/Description
	Package set optimized for the Arduino Yun based on
	Atheros AR9331.
endef

$(eval $(call Profile,LININO_YUN))

define Profile/LININO_ONE
	NAME:=Linino One
	PACKAGES:=kmod-usb-core kmod-usb2 luci-webpanel-linino
endef

define Profile/LININO_ONE/Description
	Package set optimized for the Linino One based on
	Atheros AR9331.
endef

$(eval $(call Profile,LININO_ONE))

define Profile/LININO_FREEDOG
	NAME:=Linino Freedog
	PACKAGES:=kmod-usb-core kmod-usb2 luci-webpanel-linino
endef

define Profile/LININO_FREEDOG/Description
	Package set optimized for the Linino Freedog based on
	Atheros AR9331.
endef

$(eval $(call Profile,LININO_FREEDOG))

define Profile/LININO_CHIWAWA
        NAME:=Linino Chiwawa
        PACKAGES:=kmod-usb-core kmod-usb2 luci-webpanel-linino
endef

define Profile/LININO_CHIWAWA/Description
        Package set optimized for the Linino Chiwawa based on
        Atheros AR9331.
endef

$(eval $(call Profile,LININO_CHIWAWA))

