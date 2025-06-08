# Monitor compose

## Cài node exporter lên vps
```bash
chmod +x install_node_exporter.sh
./install_node_exporter.sh
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