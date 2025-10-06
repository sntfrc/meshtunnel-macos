FROM ubuntu:24.04

# Basic tools + deps
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y \
    python3 python3-venv python3-pip \
    socat net-tools iproute2 iputils-ping \
    traceroute bind9-dnsutils tcpdump \
    netcat-traditional telnet

# Pre-create venv and install Python deps
RUN python3 -m venv /opt/meshtastic \
 && /opt/meshtastic/bin/pip install --no-cache-dir --upgrade pip \
 && /opt/meshtastic/bin/pip install --no-cache-dir meshtastic pytap2

# Entrypoint
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

# Default entrypoint drops you into bash with the venv active
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

