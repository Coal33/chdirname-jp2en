#!/bin/sh

set -eu
#set -x

read -p "Would you like to rewrite \"desktop.ini\" and change the folder name from Japanese to English?[y/n] :" YN
case "$YN" in
  "Y" | "y" ) ;;
  * ) exit 1;;
esac

read -p "Input your Windows User Name:" WINUSERNAME
if [ -d "/mnt/c/Users/$WINUSERNAME" ]; then
    echo "OK"
else
    echo "Not found 404"
    exit 1
fi


#USERPATH="/mnt/c/Users" 
#if [ -d "$USERPATH" ]; then FILEPATH="$USERPATH/desktop.ini"
    #echo "processing $FILEPATH"

    #FILEPATH_BACKUP="$USERPATH/.desktop.ini.bak"

    ## original desktop.ini backup
    #cp "$FILEPATH" "$FILEPATH_BACKUP"

    #iconv -f utf-16 -t utf-8 < "$FILEPATH_BACKUP" |
        #sed 's/^LocalizedResourceName/;LocalizedResourceName/' |
        #iconv -f utf-8 -t utf-16 > "$FILEPATH";

#fi

for FOLDERPATH in "3D Objects" Desktop Documents Downloads Favorites Contacts Music Links Pictures Searches "Saved Games" Videos
do
  FILEPATH="/mnt/c/Users/$WINUSERNAME/$FOLDERPATH/desktop.ini"

  if [ -f "$FILEPATH" ]; then
    echo "processing $FILEPATH"

    FILEPATH_BACKUP="/mnt/c/Users/$WINUSERNAME/$FOLDERPATH/.desktop.ini.bak"

    # original desktop.ini backup
    cp "$FILEPATH" "$FILEPATH_BACKUP"

    iconv -f utf-16 -t utf-8 < "$FILEPATH_BACKUP" |
        sed 's/^LocalizedResourceName/;LocalizedResourceName/' |
        iconv -f utf-8 -t utf-16 > "$FILEPATH";

  fi

done