## Oracle Keep Alive
###   
#### Oracle Keep Alive Lightweight
#### 执行：
#### wget https://github.com/Glory-CNBoy/oracle_keepalive/raw/main/keepalive-light.sh && bash keepalive-light.sh
####
#### 停止：
#### systemctl stop cpur
#### 重启：
#### systemctl restart cpur
#### 释放内存：
#### umount /ramdisk
#### 停止并释放内存[之后可以使用“重启”命令再次启动]：
#### systemctl stop cpur && umount /ramdisk
#### 完全卸载命令：
#### systemctl disable cpur --now
#### sed -i '/\/opt\/shuaibi\/mem.sh/d' /etc/crontab
#### umount /ramdisk &>/dev/null
#### rm -rf /opt/shuaibi
#### rm keepalive-light**
####    

