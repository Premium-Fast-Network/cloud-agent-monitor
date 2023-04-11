#!/bin/bash

# Function to get total CPU
get_total_cpu() {
  total_cpu=$(nproc)
  echo "$total_cpu"
}

# Function to get total CPU free as percentage
get_total_cpu_free() {
  total_cpu_usage=$(grep 'cpu ' /proc/stat | awk '{usage=$2+$4; total=usage+$5+$6+$7+$8; printf "%.2f", (usage/total)*100}')
  total_cpu_free=$(awk -v usage="$total_cpu_usage" 'BEGIN{ printf "%.2f", 100 - usage }')
  echo "$total_cpu_free"
}

# Function to get total CPU usage as percentage
get_total_cpu_usage() {
  total_cpu_usage=$(grep 'cpu ' /proc/stat | awk '{usage=$2+$4; total=usage+$5+$6+$7+$8; printf "%.2f", (usage/total)*100}')
  echo "$total_cpu_usage"
}

# Function to get total RAM
get_total_ram() {
  total_ram=$(free -b | awk '/Mem:/ {print $2}')
  echo "$total_ram"
}

# Function to get total RAM free
get_total_ram_free() {
  total_ram_free=$(free -b | awk '/Mem:/ {print $4}')
  echo "$total_ram_free"
}

# Function to get total RAM usage
get_total_ram_usage() {
  total_ram_usage=$(free -b | awk '/Mem:/ {print $3}')
  echo "$total_ram_usage"
}

# Function to get total disk size in bytes
get_total_disk_bytes() {
  total_disk=$(df -B1 / | awk '/\// {print $2}')
  echo "$total_disk"
}

# Function to get total disk free in bytes
get_total_disk_free_bytes() {
  total_disk_free=$(df -B1 / | awk '/\// {print $4}')
  echo "$total_disk_free"
}

# Function to get total disk usage in bytes
get_total_disk_usage_bytes() {
  total_disk_usage=$(df -B1 / | awk '/\// {print $3}')
  echo "$total_disk_usage"
}

# Function to get server uptime in seconds
get_server_uptime_seconds() {
  uptime_seconds=$(cat /proc/uptime | awk '{print $1}')
  echo "$uptime_seconds"
}

# Function to get list of top applications by CPU usage
get_top_applications_by_cpu() {
  top_apps=$(ps aux --sort=-%cpu | head -n 11 | awk '{if(NR>1) print $11" "$3}')
  echo "$top_apps"
}

# Function to get network usage for incoming traffic
get_network_usage_in() {
  usage_in=$(ifconfig eth0 | awk '/RX packets/ {print $5}')
  echo "$usage_in"
}

# Function to get network usage for outgoing traffic
get_network_usage_out() {
  usage_out=$(ifconfig eth0 | awk '/TX packets/ {print $5}')
  echo "$usage_out"
}

# Collecting data
total_cpu=$(get_total_cpu)
total_cpu_free=$(get_total_cpu_free)
total_cpu_usage=$(get_total_cpu_usage)
total_ram=$(get_total_ram)
total_ram_free=$(get_total_ram_free)
total_ram_usage=$(get_total_ram_usage)
total_disk_bytes=$(get_total_disk_bytes)
total_disk_free_bytes=$(get_total_disk_free_bytes)
total_disk_usage_bytes=$(get_total_disk_usage_bytes)
uptime_seconds=$(get_server_uptime_seconds)
top_apps=$(get_top_applications_by_cpu)
network_usage_in=$(get_network_usage_in)
network_usage_out=$(get_network_usage_out)

# Creating JSON payload
json_data=$(cat <<EOF
{
  "total_cpu": $total_cpu,
  "total_cpu_free": $total_cpu_free,
  "total_cpu_usage": $total_cpu_usage,
  "total_ram": $total_ram,
  "total_ram_free": $total_ram_free,
  "total_ram_usage": $total_ram_usage,
  "total_disk_bytes": $total_disk_bytes,
  "total_disk_free_bytes": $total_disk_free_bytes,
  "total_disk_usage_bytes": $total_disk_usage_bytes,
  "uptime_seconds": $uptime_seconds,
  "top_applications_by_cpu": "$top_apps",
  "network_usage_in": $network_usage_in,
  "network_usage_out": $network_usage_out
}
EOF
)

echo $json_data
