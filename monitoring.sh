#!/bin/bash
wall \
"#Architecture:" `uname -a` $'\n'\
"#CPU physical:" `grep "physical id" /proc/cpuinfo | wc -l` $'\n'\
"#vCPU:" `grep "processor" /proc/cpuinfo | wc -l` $'\n'\
"#Memory Usage:" `free -m | awk 'NR==2{printf "%s/%sMB (%.2f%%)", $4, $2, $3 * 100 / $2}'` $'\n'\
"#Disk Usage:" `df -h --total | awk 'NR==14{printf "%d/%dGB (%s)", $4, $2, $5}'` $'\n'\
"#CPU load:" `top -bn1 | grep "^%Cpu" | awk '{printf("%.1f%%"), $2}'` $'\n'\
"#Last boot:" `who -b | awk '{printf "%s %s", $3, $4}'` $'\n'\
"#LVM use:" `lsblk | grep "lvm" | xargs | awk '{if ($1) {print "yes"} else {print "no"}}'` $'\n'\
"#Connexions TCP:" `netstat | grep "ESTABLISHED" |  wc -l` "ESTABLISHED" $'\n'\
"#User log:" `who | cut -d" " -f1 | sort -u | wc -l` $'\n'\
"#Network: IP" `hostname -I` "("`ip a | grep "ether" | awk '{print $2}'`")" $'\n'\
"#Sudo:" `grep "COMMAND" /var/log/sudo/sudo.log | wc -l` "cmd"
