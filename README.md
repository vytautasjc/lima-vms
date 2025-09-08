# Lima VM Makefile

This Makefile manages a Lima VM (`dev-ubuntu`) with an attached persistent data disk (`dev-data`).  
It simplifies creating, starting, stopping, and deleting VMs and disks.

## Requirements
- [Lima](https://github.com/lima-vm/lima) installed  
- A valid config file (`dev-ubuntu.yaml`) in the same directory  

## Variables
- `VM` — VM name (default: `dev-ubuntu`)  
- `DATA_DISK_NAME` — disk name (default: `dev-data`)  
- `DATA_DISK_SIZE` — disk size (default: `20GiB`)  

## Targets
- **setup** — create a new disk and VM, format disk as `ext4`  
- **create** — create a VM using an existing disk (no formatting)  
- **start** — unlock disk and start VM  
- **ssh** — open shell into VM  
- **stop** — stop VM and unlock disk  
- **delete** — delete VM (disk remains)  
- **delete-data** — delete data disk  

## Workflow
1. Run `make setup` once for a fresh VM with a new disk  
2. For daily use: `make start` → `make ssh` → `make stop`  
3. To reuse an existing disk, use `make create` instead of `setup`  
4. To clean up: `make delete` (VM only) or `make delete-data` (disk only)  