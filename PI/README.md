# 计算圆周率
出自于Hostloc论坛某大佬，原贴地址：https://hostloc.com/thread-1131769-1-1.html   
#### 准备
```bash
apt install bc -y && apt install cpulimit -y
```
#### 运行命令
```bash
nohup echo "scale=99999999;4*a(1)" | bc -lq > /dev/null &
nohup cpulimit -l 30   -p 22489 >/dev/null &

scale那个代表小数点后的位数，数越大计算时间越长
-l 那里可以控制cpu使用率0-200
-p 那里写程序的PID，通过top命令查找，或者 ps -aux | grep bc

# 直接shell死循环也可以
nohup cpulimit -l 30 bash -c "while :;do a=1;done" > /dev/null 2>&1 &
```
#### 停止
```bash
killall bc
```
