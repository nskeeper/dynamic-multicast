#!/bin/sh
IPT=/usr/sbin/iptables
modprobe x_tables
$IPT -F
rmmod  xt_MCAST 
rmmod  compat_xtables.ko
insmod compat_xtables.ko
insmod xt_MCAST.ko
$IPT -I OUTPUT -p udp --dport 4444 -j MCAST 
#snoop ONLY igmp we don't care about outgoing Multicast traffic
$IPT -I OUTPUT -p igmp -j MCAST 
$IPT -I INPUT -d 224.0.0.0/4 ! -p igmp -j MCAST
#apply policy on incoming mcast traffic

