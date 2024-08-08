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

msg_ok "Installed Dependencies"

msg_info "Installing EMQX"
$STD bash <(curl -fsSL https://packagecloud.io/install/repositories/emqx/emqx/script.deb.sh)
$STD apt-get install -y emqx
$STD systemctl enable --now emqx
msg_ok "Installed EMQX"

motd_ssh
customize

msg_info "Cleaning up"
apt-get autoremove >/dev/null
apt-get autoclean >/dev/null
msg_ok "Cleaned"
