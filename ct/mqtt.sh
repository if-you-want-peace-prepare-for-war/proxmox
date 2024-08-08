#!/usr/bin/env bash
source <(curl -s https://raw.githubusercontent.com/if-you-want-peace-prepare-for-war/proxmox/master/misc/build.sh)
# Copyright (c) 2024 My Privacy DNS https://www.mypdns.org
# Author: @spirillen My Privacy DNS
# License: AGPL-3.0 https://github.com/if-you-want-peace-prepare-for-war/proxmox/raw/main/LICENSE

function header_info {
clear
cat <<"EOF"
    __  ___           ____        _ ____________    
   /  |/  /___  _____/ __ \__  __(_)_  __/_  __/___ 
  / /|_/ / __ \/ ___/ / / / / / / / / /   / / / __ \
 / /  / / /_/ (__  ) /_/ / /_/ / / / /   / / / /_/ /
/_/  /_/\____/____/\___\_\__,_/_/ /_/   /_/  \____/ 
                                                    
EOF
}
header_info
echo -e "Loading..."
APP="MQTT"
var_disk="2"
var_cpu="2"
var_ram="512"
var_os="debian"
var_version="12"
variables
color
catch_errors

function default_settings() {
  CT_TYPE="1"
  PW=""
  CT_ID=$NEXTID
  HN=$NSAPP
  DISK_SIZE="$var_disk"
  CORE_COUNT="$var_cpu"
  RAM_SIZE="$var_ram"
  BRG="vmbr0"
  NET="dhcp"
  GATE=""
  APT_CACHER=""
  APT_CACHER_IP=""
  DISABLEIP6="no"
  MTU=""
  SD=""
  NS=""
  MAC=""
  VLAN=""
  SSH="no"
  VERB="no"
  echo_default
}

function update_script() {
header_info
if [[ ! -f /etc/mosquitto/conf.d/default.conf ]]; then msg_error "No ${APP} Installation Found!"; exit; fi
msg_info "Updating ${APP} LXC"
apt-get update &>/dev/null
apt-get -y upgrade &>/dev/null
msg_ok "Updated Successfully"
exit
}

start
build_container
description

msg_ok "Completed Successfully!\n"
