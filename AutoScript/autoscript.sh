# 下载保活脚本文件
cd /root
wget https://raw.githubusercontent.com/honorcnboy/oracle_keep_alive/main/AutoScript/oracle_keep_alive.sh
chmod +x oracle_keep_alive.sh

# 创建一个服务单元文件
sudo tee /etc/systemd/system/oracle_keep_alive.service > /dev/null <<EOF
[Unit]
Description=Oracle Keep Alive

[Service]
ExecStart=/root/oracle_keep_alive.sh
WorkingDirectory=/root

[Install]
WantedBy=default.target
EOF

script_path=$(realpath "$0")
rm -f "$0"

# 加载systemd配置
sudo systemctl daemon-reload

# 启动服务并设置开机自启
sudo systemctl start oracle_keep_alive
sudo systemctl enable oracle_keep_alive

# 停止服务：
# sudo systemctl stop oracle_keep_alive

# 重启服务：
# sudo systemctl restart oracle_keep_alive

# 查看服务状态：
# sudo systemctl status oracle_keep_alive
