#!/bin/bash

# oracle cloud free tier instance keepalive script
## requires: bash & systemd & curl & must run by root

# default values, change it in script if needed
## CPU: 25% of total CPU resource
## RAM: 1/4 of total or 1/2 of free (depends on which one is smaller)
## NET: 10MB/s (ingress only)
## period: 6 hours per day (random)

ins_opt () {
    command -v apt &>/dev/null && ins='apt'
    command -v yum &>/dev/null && ins='yum';
    command -v dnf &>/dev/null && ins='dnf';
    command -v apk &>/dev/null && ins='apk';
    [[ "x${ins}" == "x" ]] && exit 233;
    ${ins} install -y "$1" &>/dev/null || exit 233;
}

settle_stress () {
    cpuq=$(lscpu | awk '/^CPU\(/{print $NF*100/4}');
    [ -d "/opt/shuaibi" ] || mkdir -p /opt/shuaibi;
    cat << eof > /opt/shuaibi/cpu_net.sh;
set_stress () {
    start_time=\$(date +%s);
    ((stop_time=start_time+3600*6));
    durl="http://archive.ubuntu.com/ubuntu/dists/focal/main/installer-amd64/current/legacy-images/netboot/mini.iso";
    vir_lg=(http://tyo.lg.virmach.com/100mb.zip
    http://nyc.lg.virmach.com/100mb.zip
    http://ffm.lg.virmach.com/100mb.zip
    http://ams.lg.virmach.com/100mb.zip
    http://lax.lg.virmach.com/100mb.zip
    http://lax2.lg.virmach.com/100mb.zip
    http://chi.lg.virmach.com/100mb.zip
    http://chi2.lg.virmach.com/100mb.zip
    http://tpa.lg.virmach.com/100mb.zip
    http://mia.lg.virmach.com/100mb.zip
    http://sjc.lg.virmach.com/100mb.zip
    http://sea.lg.virmach.com/100mb.zip
    http://atl.lg.virmach.com/100mb.zip
    http://dal.lg.virmach.com/100mb.zip
    http://phx.lg.virmach.com/100mb.zip
    http://den.lg.virmach.com/100mb.zip
    );  

    memt_size=\$(free -m|awk '/^Mem/{print int(\$2/4)}');
    free_size=\$(free -m|awk '/^Mem/{print int(\$4/2)}');
    ((mem_size>free_size)) && block_size=\${free_size} || block_size=\${memt_size}

    cpuc=$(lscpu | awk '/^CPU\(/{print $NF}');
    for ((i=0;i<cpuc;i++))
    do
        {
            timeout -s 9 6h dd if=/dev/zero of=/dev/null;
        } &
    done

    while [ "\$(date +%s)" > "\${stop_time}" ];
    do
        {
            [ "\$(uname -m)" == "aarch64" ] || touch /dev/shm/mem.img;
            [ -f "/dev/shm/mem.img" ] || dd if=/dev/zero of=/dev/shm/mem.img bs=1M count=\${block_size};
            ((url_id=RANDOM%\${#vir_lg[@]}));
            vurl="\${vir_lg[\${url_id}]}";
            vir_let=\$(curl -skLI "\${vurl}" 2>&1|awk '/Content-Length/{print \$2}'|tr -d '\r');
            ((vir_let>1048576)) \
                && curl -skLo /dev/null "\${vurl}" --limit-rate 1000M \
                || curl -skLo /dev/null "\${durl}" --limit-rate 1000M;
        }
    done
    wait

}
hh=$((RANDOM%24));
# hh="02";
while true
do
    [ "$(date +%H)" == "\${hh}" ] && set_stress || sleep 20m;
done
eof

    cat << eof > /lib/systemd/system/cpur.service
[Unit]
Description=stange oracle cloud free tier instance keepalive
After=network.target

[Service]
Type=simple
ExecStart=/bin/bash /opt/shuaibi/cpu_net.sh
CPUQuota=${cpuq}%
ExecStopPost=/bin/rm -f /dev/shm/mem.img

[Install]
WantedBy=multi-user.target
eof
    systemctl daemon-reload;
    systemctl enable cpur --now;
    systemctl restart cpur && echo "settle all stress succeed.";
    
}

check_env () {
    (($(id -u)==0)) || exit 233;
    command -v systemctl &>/dev/null || exit 233;
    command -v curl &>/dev/null || ins_opt "curl";
    mkdir -p /opt/shuaibi;
}

remove_stress () {
    umount /ramdisk &>/dev/null && rmdir /ramdisk;
    sed -i -e '/shuaibi/d' /etc/crontab;
    systemctl disable cpur --now && echo "service cpur stopped.";
    rm -fr /opt/shuaibi /lib/systemd/system/cpur.service && echo "remove files succeed";
}

check_env;

[[ "x$1" == "x" ]] && settle_stress || remove_stress;
