Agent Installation
-------------------------

SOLARIS:
1. Place the zone_workload.sh file in the directory /opt/uptime-agent/scripts/
   (create the directory if needed)
2. Create/edit the following password file:
   /opt/uptime-agent/bin/.uptmpasswd
   and add the following line to it:
   <password>   /opt/uptime-agent/scripts/zone_workload.sh
