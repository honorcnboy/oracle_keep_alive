#!/bin/bash
# 这个脚本将按秒平均增长文件大小，每秒增加3.6MB，持续3600秒（60分钟）。然后等待100分钟后删除文件并，删除后等待50分钟再次从头开始

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
    # 每秒增加3.6MB
    dd if=/dev/zero bs=3.6M count=1 >> $FILENAME
    sleep 1
  done

  # 等待100分钟
  sleep 6000

  # 删除文件
  rm $FILENAME

  # 等待50分钟
  sleep 3000
done
