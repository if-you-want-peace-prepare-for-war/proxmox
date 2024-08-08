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

$STD apt-get install -y gnupg
$STD apt-get install -y apt-transport-https
$STD apt-get install -y lsb-release
$STD apt-get install -y ca-certificates
msg_ok "Installed Dependencies"

msg_info "Installing YunoHost (Patience)"
touch /etc/.pve-ignore.resolv.conf
curl -sSLo /usr/share/keyrings/deb.sury.org-php.gpg https://packages.sury.org/php/apt.gpg
$STD bash <(curl -fsSL https://install.yunohost.org) -a
msg_ok "Installed YunoHost"

motd_ssh
customize

msg_info "Cleaning up"
$STD apt-get -y autoremove
$STD apt-get -y autoclean
msg_ok "Cleaned"
