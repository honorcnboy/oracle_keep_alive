### oracle keep alive
卸载：systemctl disable cpur --now，然后删除/etc/crontab的末行 [@reboot /bin/bash /opt/shuaibi/mem.sh] 就行
