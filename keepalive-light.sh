#!/bin/bash

# default values:
# cpu: 11%
# memory: 1/8(just work on arm instance)
# network: 30K/s-150K/s

durl="https://cdimage.debian.org/debian-cd/current/amd64/iso-dvd/debian-11.6.0-amd64-DVD-1.iso";

MIN_RATE=30720
MAX_RATE=153600
RANDOM_RATE=$((MIN_RATE + $RANDOM % (MAX_RATE - MIN_RATE + 1)))

ins_opt () {
    command -v apt &>/dev/null && ins='apt'
    command -v yum &>/dev/null && ins='yum';
    command -v dnf &>/dev/null && ins='dnf';
    command -v apk &>/dev/null && ins='apk';
    [[ "x${ins}" == "x" ]] && exit 233;
    ${ins} install -y "$1" &>/dev/null || exit 233;
}

set_cpu_net () {
    cpuq=$(lscpu | awk '/^CPU\(/{print $NF*11}');
    [ -d "/opt/shuaibi" ] || mkdir -p /opt/shuaibi;
    cat << eof > /opt/shuaibi/cpu_net.sh;
    cpuc=$(lscpu | awk '/^CPU\(/{print $NF}');
    for ((i=0;i<cpuc;i++))
    do
        {
            dd if=/dev/zero of=/dev/null
        } &
    done
    while true;
    do
        curl -skLo /dev/null "${durl}" --limit-rate "${RANDOM_RATE}";
    done
    wait
eof

    cat << eof > /lib/systemd/system/cpur.service
    [Unit]
    Description=cpu stress 11 percents & download file with 30K-120K speed
    After=network.target
    [Service]
    Type=simple
    ExecStart=/bin/bash /opt/shuaibi/cpu_net.sh
    CPUQuota=${cpuq}%
    [Install]
    WantedBy=multi-user.target
eof

    systemctl daemon-reload;
    systemctl enable cpur --now;
    systemctl restart cpur && echo "settle cpu & network stress succeed.";
}

set_mem () {
    cat << eof > /opt/shuaibi/mem.sh;
    [ -d '/ramdisk' ] || mkdir -p /ramdisk;
    umount /ramdisk &>/dev/null;
    mem_count=\$(free -m|awk '/^Mem/{print \$2}');
    ((mem_use=mem_count/8));
    mount -t tmpfs -o size=\${mem_use}M tmpfs /ramdisk;
    img_size=\$(df -m /ramdisk|awk 'NR>1{print \$2-50}');
    dd if=/dev/zero of=/ramdisk/dd.img bs=${RANDOM_RATE} count=\${img_size} &>/dev/null; 
eof
    /bin/bash /opt/shuaibi/mem.sh && \
    cat << eof >> /etc/crontab
@reboot /bin/bash /opt/shuaibi/mem.sh
eof
    [[ "$?" == "0" ]] && echo "settle memory stress succeed.";
}

check_env () {
    command -v curl &>/dev/null || ins_opt "curl";
    (($(id -u)==0)) || exit 233
}

check_env;
[[ "$(uname -m)" == "aarch64" ]] && set_mem;
set_cpu_net;
