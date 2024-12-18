#!/bin/bash

# Log File
LOG_FILE="/var/log/reset_ethernet.log"

# IP address for checking accessibility
PING_TARGET="8.8.8.8"

# Function for performing a PCI
function pci_reset {
  local pci_address=$(lspci -D | grep "Ethernet Controller I225-V (rev 03)" | awk '{print $1}')
  if [ -n "$pci_address" ]; then
    echo "$(date): Resetting Ethernet Controller at $pci_address" | tee -a "$LOG_FILE"
    echo 1 >/sys/bus/pci/devices/${pci_address}/remove
    sleep 1
    echo 1 >/sys/bus/pci/rescan
    ip link set eno1 up
    echo "$(date): PCI reset performed successfully." | tee -a "$LOG_FILE"
  else
    echo "$(date): Ethernet controller not found." | tee -a "$LOG_FILE"
  fi
}

# Check the presence of an error in system logs
latest_error=$(journalctl -k --since "10 seconds ago" | grep "igc.*PCIe link lost")

# Check the state of the interface and the availability of the network
if [[ -n "$latest_error" ]]; then
  echo "$(date): Detected PCIe link lost error." | tee -a "$LOG_FILE"
else
  echo "$(date): No recent PCIe link lost errors detected." | tee -a "$LOG_FILE"
fi

if ip link show eno1 | grep -q "state UP"; then
  echo "$(date): Network interface eno1 is UP. Checking internet connectivity..." | tee -a "$LOG_FILE"
  if ! ping -c 1 "$PING_TARGET" >/dev/null 2>&1; then
    echo "$(date): Network interface eno1 is UP but no internet connectivity. Performing reset..." | tee -a "$LOG_FILE"
    pci_reset
  else
    echo "$(date): Network interface eno1 is UP and internet is reachable. No reset needed." | tee -a "$LOG_FILE"
  fi
else
  echo "$(date): Network interface eno1 is DOWN. Performing reset..." | tee -a "$LOG_FILE"
  pci_reset
fi
