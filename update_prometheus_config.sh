#!/bin/bash

VPS_FILE="vps.txt"
PROM_FILE="prometheus/prometheus.yml"

if [[ ! -f "$VPS_FILE" ]]; then
  echo "❌ File $VPS_FILE không tồn tại."
  exit 1
fi

mkdir -p prometheus

# Ghi phần header
cat > "$PROM_FILE" <<EOF
global:
  scrape_interval: 15s

scrape_configs:
EOF

# Tạo scrape_config cho từng VPS IP
while IFS= read -r ip; do
  # Bỏ qua dòng trống hoặc comment
  [[ -z "$ip" || "$ip" =~ ^# ]] && continue

  cat >> "$PROM_FILE" <<EOF
  - job_name: 'vps-${ip//./-}'
    static_configs:
      - targets: ['${ip}:9100']

EOF
done < "$VPS_FILE"

echo "✅ Đã cập nhật $PROM_FILE với các IP trong $VPS_FILE"
