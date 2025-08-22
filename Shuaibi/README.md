# Oracle Keep Alive Lightweight
 
这是一个来自于帅B大佬的轻量修改版。原版及轻量版均作用于CPU、内存（仅限ARM）及网络。同时，可以根据需要自行添加两个cron task，定时启动及停止脚步运行。    
__原版__：CUP占用25%，内存（仅限ARM）占用33%，网络占用10M/s；    
__轻量版__：CUP占用25%，内存（仅限ARM）占用25%，网络占用1000K/s。轻量版运行在甲骨文标准的临界点上且完全不影响网络使用；【因轻量版为避免影响网速，对网速限制较严格可能会导致内存无法成功加载到25%的情况。如果跑不起来内存，可先运行原版，待内存加载起来后，卸载原版再运行轻量版。】     

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
wget https://github.com/honorcnboy/oracle_keep_alive/raw/main/Shuaibi/keepalive.sh && chmod +x keepalive.sh && bash keepalive.sh
``` 
__或者__
```bash
curl -skLO https://odcf.eu.org/oracle_keepalive.sh && bash oracle_keepalive.sh
```

