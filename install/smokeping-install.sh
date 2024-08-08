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

msg_info "Installing SmokePing"
$STD apt-get install -y smokeping
cat <<EOF >/etc/smokeping/config.d/Targets
*** Targets ***
probe = FPing
menu = Top
title = Network Latency Grapher
remark = Welcome to SmokePing.
+ Local
menu = Local
title = Local Network (ICMP)
++ LocalMachine
menu = Local Machine
title = This host
host = localhost
+ DNS
menu = DNS latency
title = DNS latency (ICMP)
++ My Privacy DNS
title = My Privacy DNS
host = 54.36.110.62
++ Quad9  
title = Quad9 
host = 9.9.9.9
++ matrix.rocks
title = Matrix
host = 54.36.110.62
+ HTTP
menu = HTTP latency
title = HTTP latency (ICMP)
++ Matrix
host = matrix.rocks
++ MyPrivacyDNS
host = mypdns.org
EOF
systemctl restart smokeping
msg_ok "Installed SmokePing"

motd_ssh
customize

msg_info "Cleaning up"
$STD apt-get -y autoremove
$STD apt-get -y autoclean
msg_ok "Cleaned"
