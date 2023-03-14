#AUTHOR
#	Written by Samir Kasumov.
#        Version 1.2

#REPORTING BUGS
#	Report any bugs to https://vk.com/samir_kasumov

#COPYRIGHT
#       Copyright © 2023 Free Software Foundation, Inc.  License GPLv3+: GNU GPL version 3 or later <https://gnu.org/licenses/gpl.html>.
#       This is free software: you are free to change and redistribute it.  There is NO WARRANTY, to the extent permitted by law.

#/usr/bin/env bash

. ./functions


CONFIG_GRUB_PATH=/etc/default/grub # Путь к конфигурационному файлу																


PRINT_GRUB_VERSION


CREATE_BACKUP_GRUB_CONFIG


cat << EOF
1. Change download point
2. Change timeout for user action
3. Change screen resolution
4. Change GRUB login permission
5. Change background image
6. Change display of kernel messages and distribution logo
7. Interactive mode with a pass through all items
8. Show current configuration
9. Exit
EOF


read -p "Select an item from the menu: " MENU_RESPONSE


case $MENU_RESPONSE in
	1) 
	   	SET_DOWNLOAD_POINT
	   ;;
	2) 
	   	SET_TIMEOUT
	   ;;
	3) 
	   	SET_GFXMODE
	   ;;
	4) 
	   	SET_GRUB_DISABLE_RECOVERY
	   ;;
	5) 
	   	SET_GRUB_BACKGROUND
	   ;;
	6) 
	   	SET_KERNEL_MESSG_AND_LOGO
	   ;;
	7) 
		SET_DOWNLOAD_POINT
		SET_TIMEOUT
		SET_GFXMODE
		SET_GRUB_DISABLE_RECOVERY
		SET_GRUB_BACKGROUND
		SET_KERNEL_MESSG_AND_LOGO
	    ;;
	8) 
		PRINT_CURRENT_CONFIGURATION
		exit 0
		;;
	9)  
		echo Stoppage...
		exit 0
	    ;;
	*) 
		echo Invalid menu item entered
		exit 1
		;;
esac


update-grub 


echo ...Setup completed.
