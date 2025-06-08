# Monitor compose

## Cài node exporter lên vps
1. Máy có sẵn repo (dùng để host docker và grafana)
```bash
chmod +x install_node_exporter.sh
./install_node_exporter.sh
```
2. Máy không có sẵn repo
```bash
rm -f install_node_exporter.sh && curl -L "https://raw.githubusercontent.com/batuoc263/monitor-compose/refs/heads/main/install_node_exporter.sh" -o install_node_exporter.sh && chmod +x install_node_exporter.sh && ./install_node_exporter.sh
```

## Thêm ip vào file vps.txt
Thêm mỗi ip 1 dòng

## Cập nhật prometheus config
```bash
chmod +x update_prometheus_config.sh
./update_prometheus_config.sh
```

## Chạy docker
```bash
docker-compose up -d
```