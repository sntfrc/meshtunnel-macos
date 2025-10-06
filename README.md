# meshtunnel-macos

Meshtastic has a very fun pre-alpha --tunnel feature of the Meshtastic command line client, which automagically gives you an IP interface over the mesh.
As you might know, this sadly only works on Linux; this means it will also run on Windows WSL, if you use usbipd!

The only one OS left out is macOS. The only easy way to create TAP interfaces on macOS is inside a privileged Docker container, but you have no easy way to forward a serial port to the container, which makes this approach difficult to try.

This easy to use script gets around the limitation by using ser2sock to forward the serially connected Meshtastic device onto a TCP socket that is then easily accessible inside Docker without any problems.

## Usage
Clone the repo. The first time, run ./prepare.sh to compile ser2sock and get the container ready.
Then when you want to get into the container, just ./run.sh .

```
git clone https://github.com/sntfrc/meshtunnel-macos.git
cd meshtunnel-macos
./prepare.sh
./run.sh /dev/tty.usbmodemxxx
```
