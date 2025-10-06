#!/bin/sh
git clone https://github.com/nutechsoftware/ser2sock.git
cd ser2sock
./configure --without-ssl
make
cd ..
docker build -t meshtastic-tunnel .

