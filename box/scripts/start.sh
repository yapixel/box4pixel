#!/system/bin/sh
clear; cd ${0%/*}

  MODDIR="/data/adb/modules/box4-pixel"
  SCRIPTS_DIR="/data/adb/box/scripts"
  busybox="/data/adb/magisk/busybox"
  normal=$(printf '\033[0m'); green=$(printf '\033[0;32m'); red=$(printf '\033[91m')
  
  source ./box.scripts
  
  [ ! -f ${MODDIR}/disable ] && run
  
  pgrep inotifyd > /dev/null 2>&1 && pkill -g 23332
  
  ${busybox} setuidgid 0:23332 inotifyd "${SCRIPTS_DIR}/box.inotify" "${MODDIR}" > /dev/null 2>&1 &
