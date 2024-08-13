# Storage Growfile
 
这个脚本将按秒平均增长文件大小，每秒增加4.2MB，持续7500秒。然后等待90分钟后删除文件，删除后等待60分钟再次从头开始

#### 执行：
```bash
wget https://raw.githubusercontent.com/honorcnboy/oracle_keep_alive/main/Toy/growfile.sh && chmod +x growfile.sh && nohup ./growfile.sh &
```

#### 终止执行：
```bash
ps aux | grep growfile.sh
kill -9 12345
```
