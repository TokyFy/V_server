#!/bin/bash

ARCH="$(uname -a)"
CPUp="$(awk '/^physical id/ && s[$NF]++==0' /proc/cpuinfo | wc -l)"
CPUv="$(grep -E 'processor' /proc/cpuinfo | wc -l)"
DISKu="$(df -h | awk '$NF=="/"{printf "%s/%s (%s)\n", $3,$2,$5}')"
MEMORYu="$(free -m | awk 'NR==2{printf "%s/%sMB (%.2f%%)\n", $3,$2,$3/$2*100}')"
CPULOAD="$(top -n 1 | grep "Cpu(s)" | awk '{print $2 + $4}')"
LAST_BOOT="$(uptime -s)"
LVM="$(lsblk | grep -q 'lvm' && echo "yes" || echo "no")"
TCP="$(ss -t -a | grep 'ESTAB' | wc -l)";
USER_LOGED="$(who | wc -l)"
IP="$(hostname -I | cut -d' ' -f1)"
MAC="$(ip link show | awk '/ether/ {print $2}' | tail -n 1)"
NSUDO="$(grep -c 'COMMAND=' /var/log/sudo)"


echo -e \
"# Architecture  : $ARCH\n\
# CPU physical   : $CPUp\n\
# vCPU           : $CPUv\n\
# Memory Usage   : $MEMORYu\n\
# Disk Usage     : $DISKu\n\
# CPU Load       : $CPULOAD%\n\
# Last boot      : $LAST_BOOT\n\
# LVM use        : $LVM\n\
# Connexions TCP : $TCP\n\
# User log       : $USER_LOGED\n\
# Network        : IP $IP ($MAC)\n\
# Sudo           : $NSUDO cmd\n" | wall 

