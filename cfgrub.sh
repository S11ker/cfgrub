#AUTHOR
#	Written by Samir Kasumov.
#        Version 1.0

#REPORTING BUGS
#	Report any bugs to https://vk.com/samir_kasumov

#COPYRIGHT
#       Copyright © 2020 Free Software Foundation, Inc.  License GPLv3+: GNU GPL version 3 or later <https://gnu.org/licenses/gpl.html>.
#       This is free software: you are free to change and redistribute it.  There is NO WARRANTY, to the extent permitted by law.

#/usr/bin/env bash

CONFIG_GRUB_PATH=/etc/default/grub

GRAPHIC_DISPLAY_LOADING="quiet splash"
GRAPHIC_DISPLAY_LOADING_WITHOUT_LOGO="quiet"

GRUB_DEFAULT_CURRENT=$(grep -i GRUB_DEFAULT $CONFIG_GRUB_PATH)
GRUB_GFXMODE_CURRENT=$(grep -i GRUB_GFXMODE $CONFIG_GRUB_PATH)
GRUB_DISABLE_RECOVERY_CURRENT=$(grep -i GRUB_DISABLE_RECOVERY $CONFIG_GRUB_PATH)
GRUB_BACKGROUND_CURRENT=$(grep -i GRUB_BACKGROUND $CONFIG_GRUB_PATH)
GRUB_CMDLINE_LINUX_DEFAULT_CURRENT=$(grep -i GRUB_CMDLINE_LINUX_DEFAULT $CONFIG_GRUB_PATH)

CURRENT_GRUB_VERSION=$(grub-install --version | awk -F' ' '{print $3}' | cut -c -4)
echo "Current version of GRUB: $CURRENT_GRUB_VERSION"

read -p "Specify the number of the loading point: " GRUB_DEFAULT_RESPONSE
sed -i "s/$GRUB_DEFAULT_CURRENT/GRUB_DEFAULT=$GRUB_DEFAULT_RESPONSE/g" $CONFIG_GRUB_PATH

read -p "Enter the screen resolution of the bootloader with an x between two numbers: " GRUB_GFXMODE_RESPONSE
sed -i "s/$GRUB_GFXMODE_CURRENT/GRUB_GFXMODE=$GRUB_GFXMODE_RESPONSE/g" $CONFIG_GRUB_PATH

read -p "Give the ability to enter GRUB at system startup? (yes,no) " GRUB_DISABLE_RECOVERY_RESPONSE

if [ $GRUB_DISABLE_RECOVERY_RESPONSE = yes ]; then
	sed -i "s/$GRUB_DISABLE_RECOVERY_CURRENT/GRUB_DISABLE_RECOVERY=false/g" $CONFIG_GRUB_PATH
	else
		sed -i "s/$GRUB_DISABLE_RECOVERY_CURRENT/GRUB_DISABLE_RECOVERY=true/g" $CONFIG_GRUB_PATH
fi

read -p "Set image for bootloader? \nSupported Format: PNG,JPG/JPEG,TGA (yes,no) " GRUB_BACKROUND_RESPONSE

if [ $GRUB_BACKROUND_RESPONSE = yes ]; then
	read -p "Enter the full path to the image: " FULL_IMAGE_PATH
	if grep -q GRUB_BACKGROUND $CONFIG_GRUB_PATH; then
		sed -i "s/$GRUB_BACKGROUND_CURRENT/GRUB_BACKGROUND=$FULL_IMAGE_PATH/g" $CONFIG_GRUB_PATH
	else
		echo "GRUB_BACKGROUND=$FULL_IMAGE_PATH" >> $CONFIG_GRUB_PATH
	fi
fi

read -p "Show kernel messages on startup? (yes,no) " GRUB_KERNEL_MESSAGE
read -p "Show the logo on startup? (yes,no) " GRUB_SHOW_LOGO

if [ $GRUB_KERNEL_MESSAGE = yes ] && [ $GRUB_SHOW_LOGO = no ]; then
	sed -i "s/$GRUB_CMDLINE_LINUX_DEFAULT_CURRENT/GRUB_CMDLINE_LINUX_DEFAULT=\"\"/g" $CONFIG_GRUB_PATH
elif [ $GRUB_KERNEL_MESSAGE = no ] && [ $GRUB_SHOW_LOGO = yes ]; then
	sed -i "s/$GRUB_CMDLINE_LINUX_DEFAULT_CURRENT/GRUB_CMDLINE_LINUX_DEFAULT=\"$GRAPHIC_DISPLAY_LOADING\"/g" $CONFIG_GRUB_PATH
elif [ $GRUB_KERNEL_MESSAGE = yes ] && [ $GRUB_SHOW_LOGO = yes ]; then
	sed -i "s/$GRUB_CMDLINE_LINUX_DEFAULT_CURRENT/GRUB_CMDLINE_LINUX_DEFAULT=\"splash\"/g" $CONFIG_GRUB_PATH
else
	sed -i "s/$GRUB_CMDLINE_LINUX_DEFAULT_CURRENT/GRUB_CMDLINE_LINUX_DEFAULT=\"$GRAPHIC_DISPLAY_LOADING_WITHOUT_LOGO\"/g" $CONFIG_GRUB_PATH
fi

update-grub

echo ...Setup completed.