#!/bin/bash

#set -x

# Note: Based on CloverPackage MountESP script.

if [ "$(id -u)" != "0" ]; then
    echo "This script requires superuser access, use: 'sudo $0 $@'"
    exit 1
fi

if [ "$1" == "" ]; then
    DestVolume=/
else
    DestVolume="$1"
fi
DiskDevice=$(LC_ALL=C diskutil info "$DestVolume" 2>/dev/null | sed -n 's/.*Part [oO]f Whole: *//p')
if [ -z "$DiskDevice" ]; then
    echo "Can't find volume with the name $DestVolume"
    exit 1
fi

# Check if the disk is a GPT disk
PartitionScheme=$(LC_ALL=C diskutil info "$DiskDevice" 2>/dev/null | sed -nE 's/.*(Partition Type|Content \(IOContent\)): *//p')
if [ "$PartitionScheme" != "GUID_partition_scheme" ]; then
    echo Error: volume $DestVolume is not on GPT disk
    exit 1
fi

# Get the index of the EFI partition
EFIIndex=$(LC_ALL=C /usr/sbin/gpt -r show "/dev/$DiskDevice" 2>/dev/null | awk 'toupper($7) == "C12A7328-F81F-11D2-BA4B-00A0C93EC93B" {print $3; exit}')
[ -z "$EFIIndex" ] && EFIIndex=$(LC_ALL=C diskutil list "$DiskDevice" 2>/dev/null | awk '$2 == "EFI" {print $1; exit}' | cut -d : -f 1)
[ -z "$EFIIndex" ] && EFIIndex=$(LC_ALL=C diskutil list "$DiskDevice" 2>/dev/null | grep "EFI"|awk '{print $1}'|cut -d : -f 1)
[ -z "$EFIIndex" ] && EFIIndex=1 # if not found use the index 1

# Define the EFIDevice
EFIDevice="${DiskDevice}s$EFIIndex"

# Get the EFI mount point if the partition is currently mounted
EFIMountPoint=$(LC_ALL=C diskutil info "$EFIDevice" 2>/dev/null | sed -n 's/.*Mount Point: *//p')

code=0
if [ ! "$EFIMountPoint" ]; then
    # try to mount the EFI partition
    EFIMountPoint="/Volumes/EFI"
    [ ! -d "$EFIMountPoint" ] && mkdir -p "$EFIMountPoint"
    diskutil mount -mountPoint "$EFIMountPoint" /dev/$EFIDevice >/dev/null 2>&1
    code=$?
fi
echo $EFIMountPoint
exit $code
