#!/bin/bash
#
# ©Filippo Falezza 2022, GPLv3 and Later
# This script wants to rename files based on their metadata. It is useful when used together with photorec, to automatically rename any recovered file
#
# Please edit accordingly for any timezone that's not UTC+1 or UTC+2
EXTENSION=mp4

for file in $(ls .|grep $EXTENSION);
do
	string=$(exiftool $file|grep -e "File Modification Date/Time"|sed -e 's/^File Modification Date\/Time     : //'|sed -e 's/://'|sed -e 's/://'|sed -e 's/ /_&/'|sed -e 's/ //'|sed -e 's/://'|sed -e 's/://'|sed -e 's/\+0//'|sed -e 's/1|2//'|sed -e 's/:00//')
	mv $file $string.$EXTENSION
	echo IMG_$string.$EXTENSION
done

