#!/usr/bin/env bash
set -euo pipefail

# Configurable target (falls back to your original: host.docker.internal:4403)
HOST="${HOST:-host.docker.internal}"
PORT="${PORT:-4403}"

# Start socat to create the virtual serial at /dev/ttyV0 and forward to TCP
socat pty,link=/dev/ttyV0,raw,echo=0,wait-slave TCP:${HOST}:${PORT},retry,interval=1 &
SOCAT_PID=$!

# Clean up nicely on container exit
cleanup() {
  set +e
  kill ${SOCAT_PID} ${TUNNEL_PID:-} 2>/dev/null || true
}
trap cleanup EXIT

# Activate venv
source /opt/meshtastic/bin/activate

# Wait briefly for /dev/ttyV0 to appear
for _ in $(seq 1 30); do
  [[ -e /dev/ttyV0 ]] && break
  sleep 1
done

# Start meshtastic tunnel in the background
meshtastic --port /dev/ttyV0 --tunnel &
TUNNEL_PID=$!

echo "[meshtastic-tunnel] socat PID: ${SOCAT_PID}"
echo "[meshtastic-tunnel] meshtastic tunnel PID: ${TUNNEL_PID}"
echo "[meshtastic-tunnel] Dropping into bash with the meshtastic venv active…"

# Hand you an interactive shell *with the venv already active*
exec bash -i

