#!/bin/bash

set -e

VERSION="1.8.0"
USER="nodeusr"

echo "🔧 Cài đặt Node Exporter v$VERSION..."

# Tạo user không đăng nhập
if ! id "$USER" &>/dev/null; then
  sudo useradd --no-create-home --shell /bin/false $USER
fi

# Tải và giải nén
cd /tmp
wget -q https://github.com/prometheus/node_exporter/releases/download/v${VERSION}/node_exporter-${VERSION}.linux-amd64.tar.gz
tar -xf node_exporter-${VERSION}.linux-amd64.tar.gz

# Di chuyển binary
sudo cp node_exporter-${VERSION}.linux-amd64/node_exporter /usr/local/bin/
sudo chown $USER:$USER /usr/local/bin/node_exporter

# Tạo service
sudo tee /etc/systemd/system/node_exporter.service > /dev/null <<EOF
[Unit]
Description=Node Exporter
After=network.target

[Service]
User=$USER
Group=$USER
Type=simple
ExecStart=/usr/local/bin/node_exporter
Restart=on-failure

[Install]
WantedBy=multi-user.target
EOF

# Khởi động và enable
sudo systemctl daemon-reexec
sudo systemctl daemon-reload
sudo systemctl enable --now node_exporter

# Xác nhận
echo "✅ Node Exporter đã được cài và chạy tại http://$(hostname -I | awk '{print $1}'):9100/metrics"
