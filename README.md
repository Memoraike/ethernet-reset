# Ethernet Reset

This project provides a script and systemd services for automatic monitoring and recovery of Ethernet adapters in case of PCIe link issues. It is designed for Arch Linux and compatible distributions.

## Features

- Automatically resets the Ethernet adapter upon detecting a failure.
- Checks network availability using `ping`.
- Logs all actions for easy debugging.
- Uses a systemd timer for periodic checks.

---

### Installation

#### 1. Build and Install the Package

1. Clone the repository:

   ```bash
   git clone https://github.com/your-repo/ethernet-reset.git
   cd ethernet-reset
   ```

2. Build and install the package:

   ```bash
   makepkg -si
   ```

#### 2. Enable and Start the Timer

After installation, activate the timer:

```bash
sudo systemctl enable check_ethernet.timer
sudo systemctl start check_ethernet.timer
```

---

### Project Structure

```plaintext
ethernet-reset/
├── PKGBUILD                        # Build script for the package
├── README.md                       # Documentation
├── check_and_reset_ethernet.sh     # Main script
├── check_ethernet.service          # systemd service
├── check_ethernet.timer            # systemd timer
```

---

### Uninstallation

To uninstall the package, use `pacman`:

```bash
sudo pacman -Rns ethernet-reset
```

---

### Logs and Debugging

The script logs its actions to `/var/log/reset_ethernet.log`.

To check the status of the timer and service, use:

```bash
journalctl -u check_ethernet.timer
journalctl -u check_ethernet.service
```

---

### Contributing

If you have suggestions for improvement or encounter a bug, feel free to open an issue in the repository or submit a pull request.
