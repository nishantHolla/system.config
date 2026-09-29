#!/bin/sh

set -euo pipefail
set -x

wget "https://repo.protonvpn.com/fedora-$(cat /etc/fedora-release | cut -d' ' -f 3)-stable/protonvpn-stable-release/protonvpn-stable-release-1.0.4-1.noarch.rpm"
sudo dnf install ./protonvpn-stable-release-1.0.4-1.noarch.rpm && sudo dnf check-update --refresh
sudo dnf install proton-vpn-cli wireguard-tools

sudo ip netns add protonns
sudo ip netns exec protonns ip link set lo up

sudo ip link add wg0 type wireguard
sudo ip link set wg0 netns protonns
sudo ip netns exec protonns wg setconf wg0 ~/region1-netns-stripped.conf

sudo ip netns exec protonns ip addr add 10.2.0.2/32 dev wg0
sudo ip netns exec protonns ip link set wg0 up
sudo ip netns exec protonns ip route add default dev wg0

sudo mkdir -p /etc/netns/protonns
echo "nameserver 10.2.0.1" | sudo tee /etc/netns/protonns/resolv.conf
