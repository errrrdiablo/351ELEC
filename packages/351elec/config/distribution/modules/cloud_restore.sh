#!/bin/bash

# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2021-present Xargon (https://github.com/XargonWan)

# If the rclone rules don't exist it will copy the default ones
if [ ! -f /storage/roms/gamedata/rclone/cloud-sync-rules.conf ]; then
    mkdir -p /storage/roms/gamedata/rclone/
    cp /usr/config/cloud-sync-rules.conf /storage/roms/gamedata/rclone/
fi

# If the user didn't provide the rclone config file the program script will end
if [ ! -f "/roms/gamedata/rclone/rclone.conf" ]; then
    text_viewer -w -e -m "ERROR: /roms/gamedata/rclone/rclone.conf is missing\nPlease provide the rclone.conf file.\n\nFor more information please check the WIKI at: https://github.com/351ELEC/351ELEC/wiki" -t "351ELEC Cloud Save Restore" -f 18
    exit 0
fi

text_viewer -y -w -m "Do you want to restore your cloud backup?" -t "351ELEC Cloud Save Restore" -f 20
response=$?

case $response in
    
    0)
        exit 0
        ;;

    21)
        rclone sync 351REMOTE:/351BACKUP/ /storage/roms/ --filter-from /roms/gamedata/rclone/cloud-sync-rules.conf -P --config /roms/gamedata/rclone/rclone.conf -v >> /tmp/logs/cloud-sync.log
        text_viewer -m "Backup restored!" -t "351ELEC Cloud Save Restore" -f 20
        ;;
esac