#!/bin/bash
#
# Copy wordpress theme files to xampp directory when 
#   ready to test. Must be run as root.

DEV_DIR=/home/b0b/documents/isusec-2.0/
LIVE_DIR=/opt/lampp/apps/wordpress/htdocs/wp-content/themes/
ROOT_UID=0
E_NOTROOT=87

if [ "$UID" -ne "$ROOT_UID" ]
then
	echo ""
	echo "Must be root to run this script"
	echo ""
	exit $E_NOTROOT
fi

cp -r $DEV_DIR $LIVE_DIR

echo ""
echo "Theme files have been pushed!"
echo ""

exit