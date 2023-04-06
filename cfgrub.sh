#AUTHOR
#	Written by Samir Kasumov.
#        Version 1.4

#REPORTING BUGS
#	Report any bugs to https://vk.com/samir_kasumov

#COPYRIGHT
#       Copyright © 2023 Free Software Foundation, Inc.  License GPLv3+: GNU GPL version 3 or later <https://gnu.org/licenses/gpl.html>.
#       This is free software: you are free to change and redistribute it.  There is NO WARRANTY, to the extent permitted by law.

#/usr/bin/env bash

. ./functions														

CHECK_ROOT

echo "
       __                  _     
  ___ / _| __ _ _ __ _   _| |__  
 / __| |_ / _\` | '__| | | | '_ \ 
| (__|  _| (_| | |  | |_| | |_) |
 \___|_|  \__, |_|   \__,_|_.__/ 
          |___/   
"

echo "cfgrub version 1.4"
PRINT_GRUB_VERSION


SHOW_MENU


read -p "Select an item from the menu: " MENU_RESPONSE


case $MENU_RESPONSE in
	1) 
	   	SET_BOOT_POINT
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
		SET_BOOT_POINT
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
		CREATE_BACKUP_GRUB_CONFIG
		;;
	10)
		USE_BACKUP
		;;
	11)  
		echo Stoppage...
		exit 0
	    ;;
	*) 
		echo Invalid menu item entered.
		exit 1
		;;
esac


update-grub 


echo ...Setup completed.
