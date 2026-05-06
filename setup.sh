#!/usr/bin/env bash
set -e
APP_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$APP_DIR"

command -v node >/dev/null || { echo "node not found. Install: sudo apt install nodejs"; exit 1; }

UNIT=ethanol-mix.service
DEST=/etc/systemd/system/$UNIT

# Render the unit file with the actual install path
sed "s|__APP_DIR__|$APP_DIR|g" "$UNIT" | sudo tee "$DEST" >/dev/null

sudo systemctl daemon-reload
sudo systemctl enable --now ethanol-mix

echo "Running. Status: systemctl status ethanol-mix"
echo "Logs:           journalctl -u ethanol-mix -f"
