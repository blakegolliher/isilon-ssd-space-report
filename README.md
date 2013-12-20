isilon-ssd-space-report
=======================

Simple script to reveal SSD space usage on EMC Isilon Clusters with SSD enhancement.

To make this work, you'll need to add a line to the /etc/mcp/templates/snmp_snmpd.conf file.


extend check_ssd_pool /usr/bin/perl /ifs/data/Isilon_Support/free_ssd_space_check.pl

at the end of the file that's where I put it.  Then restart snmpd.

ps auxwww | grep "/sbin/snmpd" | grep -v grep | awk '{print $2}' | xargs kill -9

After that, the following is a simple way to query for this information.

bgolliher@boxen001:~ 1 $ snmpwalk -v2c -c public isiprod02 NET-SNMP-EXTEND-MIB::nsExtendOutLine.\"check_ssd_pool\"
NET-SNMP-EXTEND-MIB::nsExtendOutLine."check_ssd_pool".1 = STRING: free_ssd_blocks :: 727090721 total_ssd_blocks :: 866908404 :: percent_used :: 16.13
bgolliher@boxen001:~ 2 $

