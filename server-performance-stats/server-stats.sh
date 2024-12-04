echo "# Server Stats #"

echo

echo "CPU Usage"
top -bn1 | grep "%Cpu(s):" | cut -d ',' -f 4 | awk '{print "Usage: " 100-$1 "%"}' 
echo

echo "Memory Usage"
free | grep "Mem:" -w | awk '{printf "Total: %.2fGi\nUsed: %.2fGi (%.2f%%)\nFree: %.2fGi (%.2f%%)\n",$2/1024^2, $3/1024^2, $3/$2 * 100, $4/1024^2, $4/$2 * 100}'
echo 

echo "Disk Usage"
df -h | grep "/" -w | awk '{printf "Total: %sG\nUsed: %s (%.2f%%)\nFree: %s (%.2f%%)\n",$3 + $4, $3, $3/($3+$4) * 100, $4, $4/($3+$4) * 100}'
echo

echo "Top 5 processes by Memory"
ps aux --sort -%mem | head -n 6 | awk '{print $1 "\t" $2 "\t" $4 "\t" $11}'
echo

echo "Top 5 process by CPU"
ps aux --sort -%cpu | head -n 6 | awk '{print $1 "\t" $2 "\t" $3 "\t" $11}'
echo

echo "Version"
cat /etc/os-release | grep "VERSION" -w | awk -F'"' '{print "OS Version: " $2}'
echo
