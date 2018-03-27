#!/usr/bin/env bash
# Backing up the home directory to an external medium
# connected via usb.
# There has to be a folder "backup/home" on that device

# Set the number of USB port available
usbCount=3

# Search for new devices starting by /dev/sdX with X the value of
deviceStart="b" #/dev/sdb

# Search for new device(s)
lsblk -no NAME,UUID,FSTYPE,LABEL,MOUNTPOINT | grep -e "sd[$deviceStart-z][0-9]" > /tmp/devlist
deviceCount=$(cat /tmp/devlist | wc -l)

if [ $deviceCount -eq 0 ]
then
    echo "No backup-device found."
    exit 0
fi

echo "Backup tool using duplicity"

# Display device(s) and read user input
i=0
while read -r name uuid fstype label
    do i=$(($i+1));
    echo "    $i)    $uuid $fstype [$label]"
done < /tmp/devlist
echo "    q)    quit"

read -p "Choose backup-device : " input

if [[ "$input" == "Q" || "$input" == "q" ]]
then
    echo "    ---> Exiting"
    exit 0
fi

if [[ $input -ge 1 && $input -le $deviceCount ]]
then
    # Get the device selected by the user
    i=0
    while read -r name uuid fstype label
        do i=$(($i+1));
        [ $i -eq $input ] && break
    done < /tmp/devlist

    # Check if the device is already mounted
    mountpoint=$(echo $label | grep -o "/mnt/usbstick[1-$usbCount]")

    if [ -z $mountpoint ]
    then
        echo "The selected device is not mounted."
    else
        # Run backup
        echo "    ---> Start backup"
        duplicity --use-agent \
                  --verbosity notice \
                  --encrypt-key=9ADCFF18F63D827638C82CF500A50C01312ACC2D \
                  --sign-key=9ADCFF18F63D827638C82CF500A50C01312ACC2D \
                  --full-if-older-than 60D \
                  --exclude '$HOME/.local/' \
                  --exclude '$HOME/.Mail/' \
                  --exclude '$HOME/.cache/' \
                  $HOME "file://$mountpoint/backup/home"
    fi
    exit 0
else
    echo "    ---> Invalid menu choice"
    exit 1
fi
