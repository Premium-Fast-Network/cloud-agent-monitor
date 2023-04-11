# PFN Cloud Agent Monitor

## Run

```
bash report.sh | jq
```

## Output

```
{
  "total_cpu": 16,
  "total_cpu_free": 96.41,
  "total_cpu_usage": 3.59,
  "total_ram": 67442479104,
  "total_ram_free": 61311045632,
  "total_ram_usage": 1795067904,
  "total_disk_bytes": 207929917440,
  "total_disk_free_bytes": 203413401600,
  "total_disk_usage_bytes": 4499738624,
  "uptime_seconds": 302508.43,
  "top_applications_by_cpu": "/home/ubuntu/core/node_modules/puppeteer/.local-chromium/linux-950341/chrome-linux/chrome 46.3 node 0.5 /home/ubuntu/core/node_modules/puppeteer/.local-chromium/linux-950341/chrome-linux/chrome 0.5 node 0.4 [rcu_sched] 0.1 /usr/sbin/qemu-ga 0.1 PM2 0.1 /lib/systemd/systemd 0.0 [kthreadd] 0.0 [rcu_gp] 0.0",
  "network_usage_in": 970867999,
  "network_usage_out": 204571336
}
```
