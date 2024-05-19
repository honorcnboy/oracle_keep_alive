这是一个整合保活脚本，建议用于甲骨文的闲置（也可以是轻量使用的）小鸡上。

该脚本中加入了：Yabs、Unixbench、LemonBench、Bench.sh，以及Shuaibi脚本，定时运行。

具体请查看本目录下 oracle_keep_alive.sh 文件。



__分步骤命令__：
```bash
cd /root
wget https://raw.githubusercontent.com/honorcnboy/oracle_keep_alive/main/AutoScript/autoscript.sh
chmod +x autoscript.sh
./autoscript.sh
```


__一键命令__：
```bash
cd /root && wget https://raw.githubusercontent.com/honorcnboy/oracle_keep_alive/main/AutoScript/autoscript.sh && chmod +x autoscript.sh && ./autoscript.sh
```


__因脚本中 network-speed.xyz 对流量消耗较大，如果不需要，可以运行以下命令注销掉该功能__：
```bash
sed -i '/task8=/d; /wait_for_next_task "\$task8"/d; /run_task "cd \/root && curl -sL network-speed.xyz | bash"/d' /root/oracle_keep_alive.sh
```
