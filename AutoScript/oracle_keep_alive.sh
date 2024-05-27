#!/bin/bash

# 设定时区
timedatectl set-timezone "Asia/Singapore"

# 当前时间
current_time=$(date +%H:%M:%S)

# 定义任务的时间
task1="23:15:00"
task2="00:30:11"
task3="01:45:22"
task4="03:00:33"
task5="04:15:44"
task6="05:30:55"
task7="06:45:00"
# task8="08:00:11"
task9="09:15:22"
task10="10:30:33"
task11="23:45:56"
task12="07:45:56"

# 检查并等待到达下一个任务时间
function wait_for_next_task {
    local next_task_time=$1
    local random_delay=$((RANDOM % 600 - 300)) 

    while true; do
        current_time=$(date +%H:%M:%S)

        if [[ $current_time > $next_task_time ]]; then
            break
        fi

        sleep_seconds=$(( $(date -d "$next_task_time" +%s) - $(date -d "$current_time" +%s) + random_delay ))
        if [ $sleep_seconds -le 0 ]; then
            break
        fi

        sleep $sleep_seconds
    done
}

# 执行任务
function run_task {
    local command=$1

    eval "$command"
}

# 等待并执行任务
wait_for_next_task "$task1"
run_task "cd /root && curl -sL yabs.sh | bash"

wait_for_next_task "$task2"
run_task "cd /root && curl -sL https://github.com/teddysun/across/raw/master/unixbench.sh | bash"

wait_for_next_task "$task3"
run_task "cd /root && wget -qO- bench.sh | bash"

wait_for_next_task "$task4"
run_task "cd /root && curl -fsL https://ilemonra.in/LemonBench-Beta | bash -s -- --full"

wait_for_next_task "$task5"
run_task "cd /root && curl -sL yabs.sh | bash"

wait_for_next_task "$task6"
run_task "cd /root && curl -sL https://github.com/teddysun/across/raw/master/unixbench.sh | bash"

wait_for_next_task "$task7"
run_task "cd /root && wget -qO- bench.sh | bash"

# wait_for_next_task "$task8"
# run_task "cd /root && curl -sL network-speed.xyz | bash"

wait_for_next_task "$task9"
run_task "cd /root && curl -fsL https://ilemonra.in/LemonBench-Beta | bash -s -- --full"

wait_for_next_task "$task10"
run_task "rm -rf /root/LemonBench* /root/geekbench* /root/unixbench* /root/.LemonBench /root/.abench /root/202*"

wait_for_next_task "$task11"
run_task "sudo systemctl restart cpur"

wait_for_next_task "$task12"
run_task "sudo systemctl stop cpur"


# 停止脚本服务：
# sudo systemctl stop oracle_keep_alive

# 重启脚本服务：
# sudo systemctl restart oracle_keep_alive

# 查看服务状态：
# sudo systemctl status oracle_keep_alive

# 卸载并完全清除本脚本服务：
# sudo systemctl stop oracle_keep_alive && sudo systemctl disable oracle_keep_alive && sudo rm /etc/systemd/system/oracle_keep_alive.service && sudo systemctl daemon-reload && rm /root/oracle_keep_alive.sh
