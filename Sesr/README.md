# 保持占用
出自于Hostloc论坛sesr大佬，原贴地址：https://hostloc.com/thread-1132162-1-1.html 。在此将其ARM命令与AMD命令整合到一个脚本中，由脚本自行判断。

#### 运行命令
```bash
wget https://github.com/Glory-CNBoy/oracle_keep_alive/raw/main/Sesr/keepoccupied.sh && bash keepoccupied.sh
```

#### 停止：
```bash
systemctl stop KeepCPUMemory.service
```
**或者**
reboot  #直接重启也能停掉

#### 完全卸载命令：
```bash
sudo systemctl stop KeepCPUMemory.service KeepNetwork.service && \
sudo systemctl disable KeepCPUMemory.service KeepNetwork.service && \
sudo rm /etc/systemd/system/KeepCPUMemory.service /etc/systemd/system/KeepNetwork.service && \
sudo rm /etc/systemd/system/multi-user.target.wants/KeepCPUMemory.service /etc/systemd/system/multi-user.target.wants/KeepNetwork.service && \
sudo rm keepoccupied.sh
```  
