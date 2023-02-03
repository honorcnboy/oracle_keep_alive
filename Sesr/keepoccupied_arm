
cat > /etc/systemd/system/KeepCPUMemory.service <<EOF
[Unit]
[Service]
CPUQuota=40%
ExecStart=/usr/bin/python3 /tmp/waste.py
[Install]
WantedBy=multi-user.target
EOF

cat > /tmp/waste.py <<EOF
import platform
if platform.machine()=="aarch64":
  memory = bytearray(int(2.4*1024*1024*1024)) # 2.4G (10% of 24G)
while True:
  pass
EOF


cat > /etc/systemd/system/KeepNetwork.service <<EOF
[Unit]
After=network-online.target
[Service]
ExecStart=/usr/bin/bash /tmp/network.sh 
Restart=always
RestartSec=10
[Install]
WantedBy=multi-user.target
EOF

cat > /tmp/network.sh <<EOF
while true
do
  curl -s -o /tmp/test.out --limit-rate 1M  http://cachefly.cachefly.net/100mb.test
done
EOF


systemctl daemon-reload
systemctl enable KeepCPUMemory --now
systemctl enable KeepNetwork --now
