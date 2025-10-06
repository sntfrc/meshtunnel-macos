#!/bin/sh

ser2sock/ser2sock -p 4403 -s /dev/tty.usbmodem1101 -0 -d
docker run --rm -it --name meshtastic-tunnel --privileged meshtastic-tunnel
killall ser2sock

