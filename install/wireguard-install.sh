#!/usr/bin/env bash

# Copyright (c) 2024 My Privacy DNS https://www.mypdns.org
# Author: @spirillen My Privacy DNS
# License: AGPL-3.0 https://github.com/if-you-want-peace-prepare-for-war/proxmox/raw/main/LICENSE

source /dev/stdin <<< "$FUNCTIONS_FILE_PATH"
color
verb_ip6
catch_errors
setting_up_container
network_check
update_os

msg_info "Installing Dependencies"
$STD apt-get install -y curl
$STD apt-get install -y sudo
$STD apt-get install -y gunicorn
msg_ok "Installed Dependencies"

msg_info "Installing WireGuard (using pivpn.io)"
OPTIONS_PATH='/options.conf'
cat >$OPTIONS_PATH <<EOF
IPv4dev=eth0
install_user=root
VPN=wireguard
pivpnNET=$(printf "10.%d.%d.0" $((RANDOM % 256)) $((RANDOM % 256)))
subnetClass=24
ALLOWED_IPS="0.0.0.0/0, ::0/0"
pivpnMTU=1420
pivpnPORT=51820
pivpnDNS1=9.9.9.9
pivpnDNS2=149.112.112.9
pivpnHOST=
pivpnPERSISTENTKEEPALIVE=25
UNATTUPG=1
EOF
$STD bash <(curl -fsSL https://install.pivpn.io) --unattended options.conf
msg_ok "Installed WireGuard"

motd_ssh
customize

msg_info "Cleaning up"
$STD apt-get -y autoremove
$STD apt-get -y autoclean
msg_ok "Cleaned"
