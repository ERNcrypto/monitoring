#!/bin/bash
wget $(curl -s https://api.github.com/repos/prometheus/node_exporter/releases/latest |grep "tag_name" | awk '{print "https://github.com/prometheus/node_exporter/releases/download/" substr($2, 2, length($2)-3) "/node_exporter-" substr($2, 3, length($2)-4) ".linux-amd64.tar.gz"}')

tar xvf node_exporter-*.tar.gz
sudo cp ./node_exporter-*.linux-amd64/node_exporter /usr/local/bin/

sudo useradd --no-create-home --shell /usr/sbin/nologin node_exporter

rm -rf ./node_exporter*

sudo tee /etc/systemd/system/node_exporter.service > /dev/null <<EOF
[Unit]
  Description=Node Exporter
  Wants=network-online.target
  After=network-online.target
[Service] 
  User=node_exporter
  Group=node_exporter
  Type=simple
  ExecStart=/usr/local/bin/node_exporter
[Install]
  WantedBy=multi-user.target
EOF

sudo systemctl daemon-reload
sudo systemctl start node_exporter.service
sudo systemctl enable node_exporter.service

wget $(curl -s https://api.github.com/repos/prometheus/prometheus/releases/latest |grep "tag_name" | awk '{print "https://github.com/prometheus/prometheus/releases/download/" substr($2, 2, length($2)-3) "/prometheus-" substr($2, 3, length($2)-4) ".linux-amd64.tar.gz"}')

tar xvf prometheus-*.tar.gz
sudo cp ./prometheus-*.linux-amd64/prometheus /usr/local/bin/
sudo cp ./prometheus-*.linux-amd64/promtool /usr/local/bin/ 
sudo cp -r ./prometheus-*.linux-amd64/consoles /etc/prometheus
sudo cp -r ./prometheus-*.linux-amd64/console_libraries /etc/prometheus

sudo useradd --no-create-home --shell /usr/sbin/nologin prometheus
sudo mkdir /var/lib/prometheus

sudo chown -R prometheus:prometheus /etc/prometheus
sudo chown -R prometheus:prometheus /var/lib/prometheus

rm -rf ./prometheus*
sudo tee /etc/prometheus/prometheus.yml > /dev/null <<EOF
global:
  scrape_interval: 15s
  evaluation_interval: 15s

rule_files:
  - 'rules.yml'

alerting:
  alertmanagers:
  - static_configs:
    - targets:
      - localhost:9093

scrape_configs:
  - job_name: "mainnet"
    scrape_interval: 15s
    static_configs:
      - targets: ["203.23.128.178:9615","203.23.128.178:9100","203.23.128.178:9090"]
        labels:
          chain: 'MYKSM3'
          node: 'MYKSM3'
      - targets: ["109.104.155.14:9615","109.104.155.14:9100","109.104.155.14:9090"]
        labels:
          chain: 'MYKSM2'
          node: 'MYKSM2'
      - targets: ["185.123.100.18:9615","185.123.100.18:9100","185.123.100.18:9090"]
        labels:
          chain: 'MYKSM1'
          node: 'MYKSM1'
      - targets: ["74.63.249.202:9615","74.63.249.202:9100","74.63.249.202:9090"]
        labels:
          chain: 'KSM17'
          node: 'KSM17'
      - targets: ["185.123.100.24:9615","185.123.100.24:9100","185.123.100.24:9090"]
        labels:
          chain: 'KSM16'
          node: 'KSM16'
      - targets: ["108.181.23.227:9615","108.181.23.227:9100","108.181.23.227:9090"]
        labels:
          chain: 'KSM15'
          node: 'KSM15'
      - targets: ["27.0.232.42:9615","27.0.232.42:9100","27.0.232.42:9090"]
        labels:
          chain: 'KSM14'
          node: 'KSM14'
      - targets: ["108.181.23.95:9615","108.181.23.95:9100","108.181.23.95:9090"]
        labels:
          chain: 'KSM13'
          node: 'KSM13'
      - targets: ["185.212.149.32:9615","185.212.149.32:9100","185.212.149.32:9090"]
        labels:
          chain: 'KSM12'
          node: 'KSM12'
      - targets: ["108.181.24.27:9615","108.181.24.27:9100","108.181.24.27:9090"]
        labels:
          chain: 'KSM11'
          node: 'KSM11'
      - targets: ["185.192.124.16:9615","185.192.124.16:9100","185.192.124.16:9093"]
        labels:
          chain: 'KSM10'
          node: 'KSM10'
      - targets: ["185.123.100.19:9615","185.123.100.19:9100","185.123.100.19:9090"]
        labels:
          chain: 'KSM 9'
          node: 'KSM 9'
      - targets: ["108.181.54.97:9615","108.181.54.97:9100","108.181.54.97:9090"]
        labels:
          chain: 'KSM 8'
          node: 'KSM 8'
      - targets: ["194.34.132.23:9615","194.34.132.23:9100","194.34.132.23:9090"]
        labels:
          chain: 'KSM 7'
          node: 'KSM 7'
      - targets: ["185.212.149.31:9615","185.212.149.31:9100","185.212.149.31:9090"]
        labels:
          chain: 'KSM 6'
          node: 'KSM 6'
      - targets: ["208.115.233.87:9615","208.115.233.87:9100","208.115.233.87:9090"]
        labels:
          chain: 'KSM 5'
          node: 'KSM 5'
      - targets: ["108.181.90.7:9615","108.181.90.7:9100","108.181.90.7:9090"]
        labels:
          chain: 'KSM 4'
          node: 'KSM 4'
      - targets: ["109.104.152.254:9615","109.104.152.254:9100","109.104.152.254:9090"]
        labels:
          chain: 'KSM 3'
          node: 'KSM 3'
      - targets: ["203.23.128.43:9615","203.23.128.43:9100","203.23.128.43:9090"]
        labels:
          chain: 'KSM 2'
          node: 'KSM 2'
      - targets: ["108.181.90.31:9615","108.181.90.31:9100","108.181.90.31:9090"]
        labels:
          chain: 'KSM 1'
          node: 'KSM 1'
      - targets: ["37.143.129.53:9615","37.143.129.53:9100","37.143.129.53:9090"]
        labels:
          chain: 'DOT 8'
          node: 'DOT 8'
      - targets: ["41.204.209.2:9615","41.204.209.2:9100","41.204.209.2:9090"]
        labels:
          chain: 'DOT 7'
          node: 'DOT 7'
      - targets: ["102.223.180.213:9615","102.223.180.213:9100","102.223.180.213:9090"]
        labels:
          chain: 'DOT 6'
          node: 'DOT 6'
      - targets: ["185.192.124.49:9615","185.192.124.49:9100","185.192.124.49:9090"]
        labels:
          chain: 'DOT 5'
          node: 'DOT 5'
      - targets: ["185.123.100.20:9615","185.123.100.20:9100","185.123.100.20:9090"]
        labels:
          chain: 'DOT 4'
          node: 'DOT 4'
      - targets: ["27.0.232.57:9615","27.0.232.57:9100","27.0.232.57:9090"]
        labels:
          chain: 'DOT 3'
          node: 'DOT 3'
      - targets: ["185.229.64.84:9615","185.229.64.84:9100","185.229.64.84:9090"]
        labels:
          chain: 'DOT 2'
          node: 'DOT 2'
      - targets: ["5.180.44.21:9615","5.180.44.21:9100","5.180.44.21:9090"]
        labels:
          chain: 'DOT 1'
          node: 'DOT 1'
EOF

sudo tee /etc/systemd/system/prometheus.service > /dev/null <<EOF
[Unit]
  Description=Prometheus Monitoring
  Wants=network-online.target
  After=network-online.target
[Service]
  User=prometheus
  Group=prometheus
  Type=simple
  ExecStart=/usr/local/bin/prometheus \
  --config.file /etc/prometheus/prometheus.yml \
  --storage.tsdb.path /var/lib/prometheus/ \
  --web.console.templates=/etc/prometheus/consoles \
  --web.console.libraries=/etc/prometheus/console_libraries
  --storage.tsdb.retention.time 30d \
  --web.enable-admin-api
  ExecReload=/bin/kill -HUP $MAINPID
[Install]
  WantedBy=multi-user.target
EOF

cd /etc/prometheus
sudo chown prometheus:prometheus rules.yml

sudo systemctl daemon-reload
sudo systemctl start prometheus.service
sudo systemctl enable prometheus.service

cd
sudo apt update
apt --fix-broken install -y 

sudo add-apt-repository "deb https://packages.grafana.com/oss/deb stable main"

sudo dpkg -i grafana*.deb

rm -rf ./grafana*

sudo systemctl start grafana-server

systemctl status grafana-server
sudo systemctl enable grafana-server
