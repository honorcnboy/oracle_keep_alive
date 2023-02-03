## Oracle Keep Alive
###   
#### Oracle Keep Alive Lightweight
#### 执行：
#### wget https://github.com/Glory-CNBoy/oracle_keepalive/raw/main/keepalive-light.sh && bash keepalive-light.sh
####
#### 停止：
#### systemctl stop cpur
#### 启动：
#### systemctl start cpur
#### 重启：
#### systemctl restart cpur
#### 释放内存：
#### umount /ramdisk
#### 卸载：
#### systemctl disable cpur --now
#### sed -i '/\/opt\/shuaibi\/mem.sh/d' /etc/crontab
#### rm -rf /opt/shuaibi
#### rm /ramdisk/dd.img
#### rm keepalive-light**
####    

