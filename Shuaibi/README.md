# Oracle Keep Alive Lightweight
 
这是一个来自于帅B大佬的轻量修改版。原版及轻量版均作用于CPU、内存（仅限ARM）及网络。同时，可以根据需要自行添加两个cron task，定时启动及停止脚步运行。    
__原版__：CUP占用25%，内存（仅限ARM）占用33%，网络占用10M/s；    
__轻量版__：CUP占用11%，内存（仅限ARM）占用11%，网络占用30K/s-150K/s。轻量版运行在甲骨文标准的临界点上且完全不影响网络使用；     

#### 执行：
```bash
wget https://github.com/honorcnboy/oracle_keep_alive/raw/main/Shuaibi/keepalive-light.sh && bash keepalive-light.sh
```

#### 停止：
```bash
systemctl stop cpur
```

#### 重启：
```bash
systemctl restart cpur
```

#### 释放内存：
```bash
umount /ramdisk
```

#### 完全卸载命令：
```bash
systemctl disable cpur --now
sed -i '/\/opt\/shuaibi\/mem.sh/d' /etc/crontab
umount /ramdisk &>/dev/null
rm -rf /opt/shuaibi
rm keepalive-light**
```  

### 如果需要使用帅B大佬的原版，请使用以下命令：
#### 执行：
```bash
wget https://github.com/honorcnboy/oracle_keep_alive/raw/main/Shuaibi/keepalive.sh && bash keepalive.sh
``` 
__或者__
```bash
curl -skLO https://odcf.eu.org/oracle_keepalive.sh && bash oracle_keepalive.sh
```

