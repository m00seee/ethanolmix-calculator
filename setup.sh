#!/usr/bin/env bash
set -e
cd "$(dirname "$0")"

command -v node >/dev/null || { echo "node not found. Install: sudo apt install nodejs"; exit 1; }

UNIT=ethanol-mix.service
DEST=/etc/systemd/system/$UNIT

# Render the unit file with the current user's home dir baked in
sed "s|%h|$HOME|g" "$UNIT" | sudo tee "$DEST" >/dev/null

sudo systemctl daemon-reload
sudo systemctl enable --now ethanol-mix

echo "Running. Status: systemctl status ethanol-mix"
echo "Logs:           journalctl -u ethanol-mix -f"
