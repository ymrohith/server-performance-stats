#!/bin/bash

echo "===== Server Performance Stats ====="
echo ""

# 1. CPU Usage
echo "[CPU Usage]"
top -bn1 | grep "Cpu(s)" | awk '{print "CPU Usage: " 100 - $8 "%"}'
echo ""

# 2. Memory Usage
echo "[Memory Usage]"
free -m | awk 'NR==2{printf "Used: %sMB | Free: %sMB | Usage: %.2f%%\n", $3, $4, $3*100/($3+$4)}'
echo ""

# 3. Disk Usage
echo "[Disk Usage]"
df -h --total | grep total | awk '{print "Used: " $3 " | Free: " $4 " | Usage: " $5}'
echo ""

# 4. Top 5 Processes by CPU
echo "[Top 5 Processes by CPU]"
ps -eo pid,comm,%cpu --sort=-%cpu | head -n 6
echo ""

# 5. Top 5 Processes by Memory
echo "[Top 5 Processes by Memory]"
ps -eo pid,comm,%mem --sort=-%mem | head -n 6
echo ""

# Extra System Info
echo "[System Info]"
echo "OS Version: $(lsb_release -d | cut -f2)"
echo "Uptime: $(uptime -p)"
echo "Load Average: $(uptime | awk -F'load average:' '{ print $2 }')"
echo "Logged In Users: $(who | wc -l)"
