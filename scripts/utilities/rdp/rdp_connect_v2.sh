#!/usr/bin/env bash

# Title: Connect RDP
# Description: Connects machine to Windows server via RDP.

# Script
# -------------------------------------------------------------
# Declare Windows machine credentials & information
# Note: We're using SSH keys for increased security (no password is explicitly defined here).
WINDOWS_IP="192.168.0.203"
WINDOWS_USER="pablo"
WINDOWS_DOMAIN="DESKTOP-ISTAQAG"
WINDOWS_PASSWORD="Narciso_*.7"

# Create SSH tunnel and open RDP connection
ssh -f -N -L 3389:$WINDOWS_IP:3389 "$WINDOWS_USER@$WINDOWS_IP"
xfreerdp /v:localhost /u:$WINDOWS_USER /p:"$WINDOWS_PASSWORD" /dynamic-resolution /d:$WINDOWS_DOMAIN
