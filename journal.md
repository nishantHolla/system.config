# System Journal

## Setup

- Connect to wifi

- Enter root
```bash
sudo su
```

- Setup partitions
    - `BOOT`: 1GB FAT 32
    - `swap`: 8GB Linux Swap
    - `nixos`: nGB Linux Filesystem
```bash
lsblk
fdisk /dev/<partition-name>
```

- Setup LUKS encryption on `nixos` partition
```bash
cryptsetup luksFormat /dev/<nixos-partition>
cryptsetup luksOpen /dev/<nixos-partition> crypted
```

- Format partitions
```bash
mkfs.fat -F 32 -n BOOT /dev/<boot-parition>
mkswap -L swap /dev/<swap-parition>
mkfs.ext4 -L nixos /dev/mapper/crypted
```

- Mount partitions
```bash
mount /dev/mapper/crypted /mnt
swapon /dev/disk/by-label/swap
mkdir -p /mnt/boot
mount /dev/disk/by-label/BOOT /mnt/boot
```


- Clone `System` repository
```bash
cd /mnt
git clone https://github.com/nishantHolla/system.config System
cd System/system_cli
```

- Setup nixos using system_cli
```bash
nix-shell -p python313
python system.py nixos setup
```

- Shutdown and remove iso

- Bring system to home directory
```bash
sudo mv /System .
sudo chown -R nishant System
cd System/system_cli
```

- Setup home-manager using system_cli
```bash
nix-shell -p python313 bitwarden-cli
python system.py home setup
```

- Restart computer

- Launch terminal and press `prefix + I` to install tmux plugins
