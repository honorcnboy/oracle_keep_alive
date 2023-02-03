# Oracle Keep Alive Lightweight
这是一个来自于帅B大佬的轻量修改版

##### 执行：
```bash
wget https://github.com/Glory-CNBoy/oracle_keepalive/raw/main/keepalive-light.sh && bash keepalive-light.sh
```

##### 停止：
```bash
systemctl stop cpur
```

##### 重启：
```bash
systemctl restart cpur
```

##### 释放内存：
```bash
umount /ramdisk
```

##### 停止并释放内存[之后可以使用“重启”命令再次启动]：
```bash
systemctl stop cpur && umount /ramdisk
```

##### 完全卸载命令：
```bash
systemctl disable cpur --now
sed -i '/\/opt\/shuaibi\/mem.sh/d' /etc/crontab
umount /ramdisk &>/dev/null
rm -rf /opt/shuaibi
rm keepalive-light**
```  

### 如果需要使用帅B大佬的原版，请使用以下命令：
##### 执行：
```bash
wget https://github.com/Glory-CNBoy/oracle_keepalive/raw/main/keepalive.sh && bash keepalive.sh
或者
curl -skLO https://odcf.eu.org/oracle_keepalive.sh && bash oracle_keepalive.sh
```

