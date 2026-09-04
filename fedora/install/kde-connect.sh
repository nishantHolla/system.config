#!/bin/sh


sudo dnf install kde-connect

sudo firewall-cmd --permanent --zone=public --add-port=1714-1764/tcp
sudo firewall-cmd --permanent --zone=public --add-port=1714-1764/udp
sudo firewall-cmd --reload
