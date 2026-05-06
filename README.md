# Ethanol Mix Calculator

A lightweight, zero-dependency web app that calculates the precise blend of two fuels needed to hit a target ethanol percentage.

- One HTML file with all CSS/JS inline — calculation runs client-side
- A ~10-line Node.js server (built-in `http` module, no npm packages)
- A systemd unit file for boot-on-startup on Linux

---

## Linux Deployment

Tested on Ubuntu 22.04 / Debian 12. Should work on any systemd-based distro.

### 1. Install Node.js

The default Ubuntu/Debian `nodejs` package is usually too old. Install Node 20 LTS from NodeSource:

```bash
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
sudo apt install -y nodejs
node -v  # should print v20.x or newer
```

**If you hit a `dpkg: trying to overwrite ...` conflict** (happens if an older `libnode-dev` is installed):

```bash
sudo apt remove -y libnode-dev libnode72
sudo apt install -y nodejs
```

### 2. Clone the repo

```bash
git clone https://github.com/m00seee/ethanolmix-calculator.git
cd ethanolmix-calculator
```

### 3. Run the setup script

```bash
chmod +x setup.sh
./setup.sh
```

This installs a systemd unit at `/etc/systemd/system/ethanol-mix.service`, starts the service, and enables it to launch on boot.

### 4. Open the firewall (if applicable)

If the VM has a firewall, allow port 3000:

```bash
sudo ufw allow 3000/tcp        # ufw
# or
sudo firewall-cmd --add-port=3000/tcp --permanent && sudo firewall-cmd --reload   # firewalld
```

### 5. Visit the app

```
http://<vm-ip>:3000
```

---

## Managing the Service

| Task | Command |
|---|---|
| Check status | `systemctl status ethanol-mix` |
| Tail logs | `journalctl -u ethanol-mix -f` |
| Restart | `sudo systemctl restart ethanol-mix` |
| Stop | `sudo systemctl stop ethanol-mix` |
| Disable autostart | `sudo systemctl disable ethanol-mix` |
| Pull updates | `cd ~/ethanolmix-calculator && git pull && sudo systemctl restart ethanol-mix` |

---

## Changing the Port

Edit the unit file at `/etc/systemd/system/ethanol-mix.service`, change `Environment=PORT=3000`, then:

```bash
sudo systemctl daemon-reload
sudo systemctl restart ethanol-mix
```

---

## Uninstall

```bash
sudo systemctl disable --now ethanol-mix
sudo rm /etc/systemd/system/ethanol-mix.service
sudo systemctl daemon-reload
rm -rf ~/ethanolmix-calculator
```

---

## Run Without Installing

You can also run the server directly without systemd:

```bash
node server.js
# visit http://localhost:3000
```

Or just open `index.html` in any browser — the calculation is fully client-side, no server needed.
