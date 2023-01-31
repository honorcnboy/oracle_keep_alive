### oracle keep alive
执行：wget https://github.com/Glory-CNBoy/oracle_keepalive/raw/main/keepalive.sh && bash keepalive.sh
卸载：systemctl disable cpur --now，然后删除/etc/crontab的末行 [@reboot /bin/bash /opt/shuaibi/mem.sh] 就行
