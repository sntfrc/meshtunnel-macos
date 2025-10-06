#!/bin/sh

ser2sock/ser2sock -p 4403 -s $1 -0 -d
docker run --rm -it --name meshtastic-tunnel --privileged meshtastic-tunnel
killall ser2sock

