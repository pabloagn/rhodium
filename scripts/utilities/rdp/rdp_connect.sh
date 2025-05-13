#!/usr/bin/env bash

# Variables
WINDOWS_USER="pablo"
WINDOWS_HOST="192.168.0.86"
LOCAL_PORT=3390
REMOTE_PORT=3389

# Check if SSH is installed
if ! command -v ssh &>/dev/null; then
  echo "Error: SSH command is not installed or not in PATH."
  exit 1
fi

# Check if RDP client is installed
if ! command -v xfreerdp &>/dev/null; then
  echo "Error: xfreerdp (RDP client) is not installed or not in PATH."
  exit 1
fi

# Establish SSH tunnel
echo "Creating SSH tunnel to Windows machine on local port ${LOCAL_PORT}..."
ssh -f -N -L "${LOCAL_PORT}:localhost:${REMOTE_PORT}" "${WINDOWS_USER}@${WINDOWS_HOST}"

if [[ $? -ne 0 ]]; then
  echo "Error: Failed to establish SSH tunnel."
  exit 2
fi

echo "SSH tunnel established. Connecting to RDP on localhost:${LOCAL_PORT}..."

# Launch RDP client
xfreerdp /v:localhost:${LOCAL_PORT} /u:${WINDOWS_USER} +sec-nla /cert:ignore

exit 0
