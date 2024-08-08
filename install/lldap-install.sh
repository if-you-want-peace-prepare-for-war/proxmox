#!/usr/bin/env bash

# Copyright (c) 2024 My Privacy DNS https://www.mypdns.org
# Author: @spirillen My Privacy DNS
# Co-Author: remz1337
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

$STD apt-get install -y gpg
msg_ok "Installed Dependencies"

msg_info "Installing lldap"
source /etc/os-release
os=$ID
if [ "$os" == "ubuntu" ]; then
  DISTRO="xUbuntu"
else
  DISTRO="${os^}"
fi
echo "deb http://download.opensuse.org/repositories/home:/Masgalor:/LLDAP/${DISTRO}_${VERSION_ID}/ /" >/etc/apt/sources.list.d/home:Masgalor:LLDAP.list
curl -fsSL https://download.opensuse.org/repositories/home:Masgalor:LLDAP/${DISTRO}_${VERSION_ID}/Release.key | gpg --dearmor >/etc/apt/trusted.gpg.d/home_Masgalor_LLDAP.gpg
$STD apt update
$STD apt install -y lldap
systemctl enable -q --now lldap
msg_ok "Installed lldap"

motd_ssh
customize

msg_info "Cleaning up"
$STD apt-get -y autoremove
$STD apt-get -y autoclean
msg_ok "Cleaned"
