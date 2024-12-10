#!/bin/bash
counts=5

echo -e "\nTop ${counts} IP addresses with the most requests:"
awk '{print $1}' nginx-access.log.txt | sort | uniq -c | sort -nr |awk '{print $2 " - " $1 " requests"}' | head -n ${counts}

echo -e "\nTop ${counts} most requested paths:"
awk '{print $7}' nginx-access.log.txt | sort | uniq -c | sort -nr |awk '{print $2 " - " $1 " requests"}' | head -n ${counts}

echo -e "\nTop ${counts} response status codes:"
grep -oE ' [1-5][0-9]{2} ' nginx-access.log.txt | sort | uniq -c | sort -rn | awk '{print $2 " - " $1 " requests"}' |  head -n $counts 

echo -e "\nTop ${counts} user agents:"
awk -F'"' '{print $6}' nginx-access.log.txt | sort | uniq -c | sort -nr | awk '{for(i=2;i<=NF;i++) printf "%s ", $i; print "-",$1,"requests"}' | head -n $counts