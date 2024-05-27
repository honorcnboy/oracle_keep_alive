#!/bin/bash

# 设定时区
timedatectl set-timezone "Asia/Singapore"

# 当前时间和日期
current_time=$(date +%H:%M:%S)
current_date=$(date +%Y-%m-%d)

# 定义任务的时间
task1="23:15:00"
task2="00:30:11"
task3="01:45:22"
task4="03:00:33"
task5="04:15:44"
task6="05:30:55"
task7="06:45:00"
task8="08:00:11"
task9="09:15:22"
task10="10:30:33"
task11="23:45:56"
task12="07:45:56"

# 日志文件路径
log_file="/root/oracle_keep_alive.log"

# 保留日志天数
log_retention_days=30

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

# 记录日志
function log_task {
    local task_name=$1
    local start_time=$2
    local status=$3

    local end_time=$(date +%s)
    local elapsed_time=$((end_time - start_time))
    local minutes=$((elapsed_time / 60))
    local seconds=$((elapsed_time % 60))

    echo "【$status】$current_date $task_name 用时 ${minutes}分${seconds}秒" >> $log_file
}

# 清理旧日志
function clean_old_logs {
    find /root -name "oracle_keep_alive.log" -mtime +$log_retention_days -exec rm -f {} \;
}

# 执行任务并记录结果
function run_task {
    local task_name=$1
    local command=$2

    local start_time=$(date +%s)
    if eval "$command"; then
        log_task "$task_name" "$start_time" "成功"
    else
        log_task "$task_name" "$start_time" "失败"
    fi
}

# 记录task8上次运行的时间
task8_last_run_file="/root/task8_last_run_date"

# 检查并运行任务8
function check_and_run_task8 {
    if [ -f "$task8_last_run_file" ]; then
        last_run_date=$(cat "$task8_last_run_file")
        next_run_date=$(date -d "$last_run_date + 7 days" +%Y-%m-%d)

        if [ "$current_date" \> "$next_run_date" ] || [ "$current_date" == "$next_run_date" ]; then
            wait_for_next_task "$task8"
            run_task "task8" "cd /root && curl -sL network-speed.xyz | bash"
            echo "$current_date" > "$task8_last_run_file"
        fi
    else
        wait_for_next_task "$task8"
        run_task "task8" "cd /root && curl -sL network-speed.xyz | bash"
        echo "$current_date" > "$task8_last_run_file"
    fi
}

# 清理旧日志
clean_old_logs

# 等待并执行任务
wait_for_next_task "$task1"
run_task "task1" "cd /root && curl -sL yabs.sh | bash"

wait_for_next_task "$task2"
run_task "task2" "cd /root && curl -sL https://github.com/teddysun/across/raw/master/unixbench.sh | bash"

wait_for_next_task "$task3"
run_task "task3" "cd /root && wget -qO- bench.sh | bash"

wait_for_next_task "$task4"
run_task "task4" "cd /root && curl -fsL https://ilemonra.in/LemonBench-Beta | bash -s -- --full"

wait_for_next_task "$task5"
run_task "task5" "cd /root && curl -sL yabs.sh | bash"

wait_for_next_task "$task6"
run_task "task6" "cd /root && curl -sL https://github.com/teddysun/across/raw/master/unixbench.sh | bash"

wait_for_next_task "$task7"
run_task "task7" "cd /root && wget -qO- bench.sh | bash"

# 检查并执行task8
check_and_run_task8

wait_for_next_task "$task9"
run_task "task9" "cd /root && curl -fsL https://ilemonra.in/LemonBench-Beta | bash -s -- --full"

wait_for_next_task "$task10"
run_task "task10" "rm -rf /root/LemonBench* /root/geekbench* /root/unixbench* /root/.LemonBench /root/.abench /root/202*"

wait_for_next_task "$task11"
run_task "task11" "sudo systemctl restart cpur"

wait_for_next_task "$task12"
run_task "task12" "sudo systemctl stop cpur"


# 停止脚本服务：
# sudo systemctl stop oracle_keep_alive

# 重启脚本服务：
# sudo systemctl restart oracle_keep_alive

# 查看服务状态：
# sudo systemctl status oracle_keep_alive

# 卸载并完全清除本脚本服务：
# sudo systemctl stop oracle_keep_alive
# sudo systemctl disable oracle_keep_alive
# sudo rm /etc/systemd/system/oracle_keep_alive.service
# sudo systemctl daemon-reload
# rm /root/oracle_keep_alive.sh
