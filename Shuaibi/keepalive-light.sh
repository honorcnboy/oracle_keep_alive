#!/bin/bash

# default values:
# cpu: 17%
# memory: 20%(just work on arm instance)
# network: 600K/s(The actual effect will be 2-3 times the setting)

durl="https://cdimage.debian.org/debian-cd/current/amd64/iso-dvd/debian-12.0.0-amd64-DVD-1.iso";

ins_opt () {
    command -v apt &>/dev/null && ins='apt'
    command -v yum &>/dev/null && ins='yum';
    command -v dnf &>/dev/null && ins='dnf';
    command -v apk &>/dev/null && ins='apk';
    [[ "x${ins}" == "x" ]] && exit 233;
    ${ins} install -y "$1" &>/dev/null || exit 233;
}

set_cpu_net () {
    cpuq=$(lscpu | awk '/^CPU\(/{print $NF*17}');
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
        curl -skLo /dev/null "${durl}" --limit-rate 600K;
    done
    wait
eof

    cat << eof > /lib/systemd/system/cpur.service
    [Unit]
    Description=cpu stress 17 percents & download file with 600K/s speed
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
    if [ ! -d "/opt/shuaibi" ]; then
        mkdir -p /opt/shuaibi
    fi
    if [ -f "/opt/shuaibi/mem.sh" ]; then
        echo "/opt/shuaibi/mem.sh already exists."
        return
    fi
    cat << eof > /opt/shuaibi/mem.sh
    [ -d '/ramdisk' ] || mkdir -p /ramdisk;
    umount /ramdisk &>/dev/null;
    mem_count=\$(free -m|awk '/^Mem/{print \$2}');
    ((mem_use=mem_count*20/100));
    mount -t tmpfs -o size=\${mem_use}M tmpfs /ramdisk;
    img_size=\$(df -m /ramdisk|awk 'NR>1{print \$2-50}');
    dd if=/dev/zero of=/ramdisk/dd.img bs=1M count=\${img_size} &>/dev/null; 
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
