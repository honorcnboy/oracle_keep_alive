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
因TASK8 流量消耗较大，约130G/次，脚本默认停用，如有需要可自行启用（取消前面的“#”号）
