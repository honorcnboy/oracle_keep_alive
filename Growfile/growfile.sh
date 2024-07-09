#!/bin/bash
# 这个脚本将按秒平均增长文件大小，每秒增加2.5MB，持续3600秒（60分钟）。然后会删除文件并等待60分钟，再次从头开始

# 设置文件名
FILENAME="growfile"

# 无限循环
while true
do
  # 创建一个空文件
  > $FILENAME

  # 增长文件大小
  for i in {1..3600}  # 60分钟*60秒
  do
    # 每秒增加2.5MB
    dd if=/dev/zero bs=2.5M count=1 >> $FILENAME
    sleep 1
  done

  # 等待60分钟
  sleep 3600

  # 删除文件
  rm $FILENAME

  # 等待60分钟
  sleep 3600
done
