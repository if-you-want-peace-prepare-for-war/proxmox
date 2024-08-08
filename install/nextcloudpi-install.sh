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

msg_info "Installing NextCloudPi (Patience)"
$STD apt-get install -y systemd-resolved
systemctl enable -q --now systemd-resolved
cat <<'EOF' >/etc/systemd/resolved.conf
[Resolve]
DNS=9.9.9.9
FallbackDNS=149.112.112.9
EOF
systemctl restart systemd-resolved
$STD bash <(curl -fsSL https://raw.githubusercontent.com/nextcloud/nextcloudpi/master/install.sh)
systemctl disable -q --now systemd-resolved
$STD apt-get remove -y systemd-resolved
msg_ok "Installed NextCloudPi"

motd_ssh
customize

msg_info "Cleaning up"
$STD apt-get -y autoremove
$STD apt-get -y autoclean
msg_ok "Cleaned"
