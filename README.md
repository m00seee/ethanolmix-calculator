# Ethanol Mix Calculator

A lightweight, zero-dependency web app that calculates the precise blend of two fuels needed to hit a target ethanol percentage.

## What it is

- One HTML file with all CSS/JS inline — calculation runs client-side
- A ~10-line Node.js server (built-in `http` module, no npm packages)
- A systemd unit file for boot-on-startup on Linux

## Run locally

Open `index.html` directly in a browser. That's it — no server needed for the calculator to work.

To run the server:

```bash
node server.js
# visit http://localhost:3000
```

## Deploy on a Linux VM

Prerequisite: `sudo apt install nodejs -y`

```bash
chmod +x setup.sh && ./setup.sh
```

This installs the systemd unit, starts the service, and enables it on boot.

Useful commands:

- `systemctl status ethanol-mix` — current state
- `journalctl -u ethanol-mix -f` — tail logs
- `sudo systemctl restart ethanol-mix` — after editing files
