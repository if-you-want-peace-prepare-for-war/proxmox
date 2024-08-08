#!/usr/bin/env bash
source <(curl -s https://raw.githubusercontent.com/if-you-want-peace-prepare-for-war/proxmox/master/misc/build.sh)
# Copyright (c) 2024 My Privacy DNS https://www.mypdns.org
# Author: @spirillen My Privacy DNS
# License: AGPL-3.0 https://github.com/if-you-want-peace-prepare-for-war/proxmox/raw/main/LICENSE

function header_info {
clear
cat <<"EOF"
    ██████╗ ██╗   ██╗███████╗██╗   ██╗███╗   ██╗ ██████╗███████╗██████╗ ██╗     ███████╗
    ██╔══██╗╚██╗ ██╔╝██╔════╝██║   ██║████╗  ██║██╔════╝██╔════╝██╔══██╗██║     ██╔════╝
    ██████╔╝ ╚████╔╝ █████╗  ██║   ██║██╔██╗ ██║██║     █████╗  ██████╔╝██║     █████╗
    ██╔═══╝   ╚██╔╝  ██╔══╝  ██║   ██║██║╚██╗██║██║     ██╔══╝  ██╔══██╗██║     ██╔══╝
    ██║        ██║   ██║     ╚██████╔╝██║ ╚████║╚██████╗███████╗██████╔╝███████╗███████╗
    ╚═╝        ╚═╝   ╚═╝      ╚═════╝ ╚═╝  ╚═══╝ ╚═════╝╚══════╝╚═════╝ ╚══════╝╚══════╝
EOF
}
header_info
echo -e "Loading..."
APP="Debian"
var_disk="3"
var_cpu="30"
var_ram="4096"
var_os="debian"
var_version="12"
DISABLEIPV6="yes"
variables
color
catch_errors

function default_settings() {
  CT_TYPE="1"
  PW=""
  CT_ID=$NEXTID
  HN=$NSAPP-$NEXTID
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
$STD apt-get install -y \
  python3 \
  python3-pip &>/dev/null
msg_ok "Updated ${APP} LXC"

msg_info "Installing PyFunceble"
$STD pip install -I -U pyfunceble-dev
$STD mkdir -p --mode=0775 ~/.config/PyFunceble/
cat <<EOF > ~/.config/PyFunceble/.PyFunceble.overwrite.yaml
debug:
  active: no
  level: info
cli_testing:
  max_workers: null
  autocontinue: yes
  inactive_db: yes
  whois_db: yes
  cooldown_time: 0.0
  db_type: mariadb
  file_filter: null
  mining: no
  local_network: no
  preload_file: no
  chancy_tester: no
  ci:
    active: no
    commit_message: 'My Privacy DNS - AutoSave'
    end_commit_message: 'My Privacy DNS - Results'
    max_exec_minutes: 15
    branch: master
    distribution_branch: master
    command: null
    end_command: null
  display_mode:
    dots: no
    execution_time: yes
    percentage: yes
    registrar: no
    all: yes
    max_registrar: 0
  testing_mode:
    reputation: no
    platform_contribution: yes
  days_between:
    db_clean: 28
    db_retest: 7
  sorting_mode:
    hierarchical: yes
    standard: no
  file_generation:
    analytic: no
    unified_results: no
    merge_output_dirs: no
lookup:
  dns: yes
  http_status_code: yes
  netinfo: yes
  special: yes
  whois: yes
  reputation: no
  platform: yes
  timeout: 5
dns:
  follow_server_order: no
  trust_server: yes
  server:
    - 9.9.9.10
    - 149.112.112.10
user_agent:
  browser: firefox
  platform: linux
  custom: null
proxy:
  rules:
    - http: socks5h://127.0.0.1:9050
      https: socks5h://127.0.0.1:9050
      tld:
        - onion
  global:
    http: socks5h://127.0.0.1:9050
    https: socks5h://127.0.0.1:9050
max_http_retries: 2
platform:
  push: yes
  preferred_status_origin: recommended
  checker_priority:
    - availability
    - syntax
checker_exclude:
    - reputation
EOF
# TODO: Replace Proxy rules http://support.matrix.lan/issue/MATRIX-41
# TODO: Setup DNS recurser for PyFunceble testing environment http://support.matrix.lan/issue/MATRIX-42
msg_info You can see all values at https://github.com/funilrys/PyFunceble/blob/dev/PyFunceble/data/infrastructure/.PyFunceble_production.yaml
msg_info
cat <EOF >~/.config/PyFunceble/.pyfunceble-env
PYFUNCEBLE_DB_CHARSET=utf8mb4
PYFUNCEBLE_DB_HOST=
PYFUNCEBLE_DB_NAME=
PYFUNCEBLE_DB_PASSWORD=
PYFUNCEBLE_DB_PORT=3306
PYFUNCEBLE_DB_USERNAME=
PYFUNCEBLE_OUTPUT_LOCATION=/home/root/pyfunceble
PYFUNCEBLE_PLATFORM_API_URL=https://api.beta.dead-hosts.com
PYFUNCEBLE_PLATFORM_API_TOKEN=
PYFUNCEBLE_AUTO_CONFIGURATION=yes
PYFUNCEBLE_PLATFORM_CHECKER_EXCLUDE=reputation
EOF



$STD
msg_info "Installing MyPDNS"
$STD pip install mypdns
msg_ok

exit
}



start
build_container
description

msg_ok "Completed Successfully!\n"
