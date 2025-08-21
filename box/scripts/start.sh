#!/system/bin/sh
clear; cd ${0%/*}

MODDIR="/data/adb/modules/box4-pixel"
SCRIPTS_DIR="/data/adb/box/scripts"
busybox="/data/adb/magisk/busybox"
normal=$(printf '\033[0m'); green=$(printf '\033[0;32m'); red=$(printf '\033[91m')

source ./box.scripts

# Ensure log directory exists
mkdir -p "${SCRIPTS_DIR}/run"

# Run proxy if module is not disabled
[ ! -f ${MODDIR}/disable ] && run >> "${SCRIPTS_DIR}/run/start.log" 2>&1

# Ensure inotifyd is running
if ! pgrep inotifyd > /dev/null 2>&1; then
  ${busybox} setuidgid 0:23332 inotifyd "${SCRIPTS_DIR}/box.inotify" "${MODDIR}" >> "${SCRIPTS_DIR}/run/inotify.log" 2>&1 &
else
  pkill -g 23332
  ${busybox} setuidgid 0:23332 inotifyd "${SCRIPTS_DIR}/box.inotify" "${MODDIR}" >> "${SCRIPTS_DIR}/run/inotify.log" 2>&1 &
fi
