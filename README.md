## Oracle Keep Alive
###   
#### Oracle Keep Alive Lightweight
#### 执行：
#### wget https://github.com/Glory-CNBoy/oracle_keepalive/raw/main/keepalive-light.sh && bash keepalive-light.sh
####   
#### 卸载：
#### systemctl disable cpur --now
#### sed -i '/\/opt\/shuaibi\/mem.sh/d' /etc/crontab
#### rm -rf /opt/shuaibi
#### rm /ramdisk/dd.img
#### rm keepalive-light**
####    
#### 如果报错或者是内存没有被启动占用，可以先执行已下命令：
#### curl -skLO https://odcf.eu.org/oracle_keepalive.sh && bash oracle_keepalive.sh
#### 等待1分钟后，继续执行
#### systemctl disable cpur --now
#### sed -i '/\/opt\/shuaibi\/mem.sh/d' /etc/crontab
#### 然后再次执行这个命令即可
#### wget https://github.com/Glory-CNBoy/oracle_keepalive/raw/main/keepalive-light.sh && bash keepalive-light.sh
#### 原因：轻量脚本限制了网络速度，导致ARM磁盘文件无法及时生成。使用以上脚本，可以及时生成占用文件，再进行挂载就没有问题了。
