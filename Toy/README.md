# Storage Growfile
 
这个脚本将按秒平均增长文件大小，每秒增加3.6MB，持续3600秒（60分钟）。然后等待120分钟后删除文件并，删除后等待60分钟再次从头开始

#### 执行：
```bash
wget https://github.com/honorcnboy/oracle_keep_alive/raw/main/Toy/growfile.sh && chmod +x growfile.sh && nohup ./growfile.sh &
```

#### 终止执行：
```bash
ps aux | grep growfile.sh
kill -9 12345
```
