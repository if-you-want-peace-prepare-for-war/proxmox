#!/usr/bin/env bash
source <(curl -s https://raw.githubusercontent.com/if-you-want-peace-prepare-for-war/proxmox/master/misc/build.sh)
# Copyright (c) 2024 My Privacy DNS https://www.mypdns.org
# Author: My Privacy DNS @spirillen
# License: AGPL-3.0
# https://github.com/if-you-want-peace-prepare-for-war/proxmox/raw/master/LICENSE

function header_info {
clear
cat <<"EOF"
   __  ____                __       
  / / / / /_  __  ______  / /___  __
 / / / / __ \/ / / / __ \/ __/ / / /
/ /_/ / /_/ / /_/ / / / / /_/ /_/ / 
\____/_.___/\__,_/_/ /_/\__/\__,_/  
 
EOF
}
header_info
echo -e "Loading..."
APP="Ubuntu"
var_disk="2"
var_cpu="30"
var_ram="4096"
var_os="ubuntu"
var_version="24.04"
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
if [[ ! -d /var ]]; then msg_error "No ${APP} Installation Found!"; exit; fi
msg_info "Updating ${APP} LXC"
apt-get update &>/dev/null
apt-get -y upgrade &>/dev/null
msg_ok "Updated ${APP} LXC"
exit
}

start
build_container
description

msg_ok "Completed Successfully!\n"
