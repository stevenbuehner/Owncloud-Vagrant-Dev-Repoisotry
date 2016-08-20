#!/bin/sh
# source: https://gist.github.com/luizs81/319d936efd300408c1a89d6e70ad68e6

# size of swapfile in megabytes
if [ -z ${SWAPSIZE+x} ]; then SWAPSIZE=8000; else echo "Override SWAPSIZE='$SWAPSIZE'."; fi

# size of swapfile in megabytes
swapsize=$SWAPSIZE

# does the swap file already exist?
grep -q "swapfile" /etc/fstab

# if not then create it
if [ $? -ne 0 ]; then
  echo 'swapfile not found. Adding swapfile.'
  fallocate -l ${swapsize}M /swapfile
  chmod 600 /swapfile
  mkswap /swapfile
  swapon /swapfile
  echo '/swapfile none swap defaults 0 0' >> /etc/fstab
else
  echo 'swapfile found. No changes made.'
fi

# output results to terminal
df -h
cat /proc/swaps
cat /proc/meminfo | grep Swap