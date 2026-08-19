# System Journal

## Nixos Setup

- Connect to wifi

- Enter root
```bash
sudo su
```

- Setup partitions
    - `BOOT`: 1GB FAT 32
    - `SWAP`: 8GB Linux Swap
    - `DISK`: nGB Linux Filesystem
```bash
lsblk
fdisk /dev/{disk-name}
```

- Setup variables for disy by partuuid
```bash
blkid
BOOT=/dev/disk/by-partuuid/{id-of-BOOT-partition}
SWAP=/dev/disk/by-partuuid/{id-of-SWAP-partition}
DISK=/dev/disk/by-partuuid/{id-of-DISK-partition}
```

- Setup LUKS encryption on `nixos` partiton
```bash
cryptsetup luksFormat ${DISK}
cryptsetup luksOpen ${DISK} crypted
```

- Format partitions
```bash
mkfs.fat -F 32 -n BOOT ${BOOT}
mkswap -L swap ${SWAP}
mkfs.ext4 -L nixos /dev/mapper/crypted
```

- Mount partitions
```bash
mount /dev/mapper/crypted /mnt
swapon ${SWAP}
mkdir -p /mnt/boot
mount ${BOOT} /mnt/boot
```

- Clone `System` repository
```bash
cd /mnt
git clone https://github.com/nishantHolla/system.config System
cd System/cli
```

- Setup nixos using system
```bash
nix --experimental-features "nix-command flakes" develop
python system.py nixos setup
```

- Shutdown and remove the install medium

- Power on the system and login with the user account

- Bring system to home directory
```bash
sudo mv /System .
sudo chown -R $(whoami) System
cd System/cli
```

- Setup home-manager using system
```bash
nix-shell -p python313 bitwarden-cli
python system.py home setup
```

- Restart computer

- Launch terminal and press `prefix + I` to install tmux plugins
