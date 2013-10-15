#!/bin/ksh

# June 6, 2012
# Incorporated community feedback:
# http://support.uptimesoftware.com/community/?showtopic=218&mode=linearplus

#set -x
# a shell script to display basic workload information on the various zones on this system
# based off of prstat -Z and zoneadm

# ideal output is like so

# zones_running 5
# css1\.cpu 5
# css1\.mem 1000
# css1\.rss 2000
# css2\.cpu 25 
# css2\.mem 2000
# css2\.rss 8000
# css3\.cpu 40
# css3\.mem 3000
# css3\.rss 7500

PRSTAT="prstat -Z -n1,20 1 1"
ZONEADM="/usr/sbin/zoneadm list -iv"

# first add up the running zones

ZR=`$ZONEADM | grep running | wc -l`
echo "zones_running $ZR"


# now the tricky part
$PRSTAT | grep -v 'ZONEID' | grep -v 'PID' | grep -v "\/" | grep -v Total | while read ZONEID NPROC SIZE RSS MEMORY TIME CPU ZONE; do

# Dump the last character so we just have numbers and no M characters or % signs.

CPU=`echo $CPU |sed 's/\(.*\)./\1/'`

# If Memory Size is in GB convert in MB and then dump the last character
if echo $SIZE | grep G > /dev/null 2<&1
then 
 SIZE=`echo $SIZE |sed 's/\(.*\)./\1/'`
 SIZE=$(($SIZE * 1024))
else 
 SIZE=`echo $SIZE |sed 's/\(.*\)./\1/'`
fi

# If RSS Size is in GB convert in MB and then dump the last character
if echo $RSS | grep G > /dev/null 2<&1
then
 RSS=`echo $RSS |sed 's/\(.*\)./\1/'`
 RSS=$(($RSS * 1024))
else
 RSS=`echo $RSS |sed 's/\(.*\)./\1/'`
fi

MEM=`echo $MEMORY |sed 's/\(.*\)./\1/'`


echo ${ZONE}.cpu $CPU
echo ${ZONE}.mem $SIZE
echo ${ZONE}.rss $RSS
echo ${ZONE}.memory $MEM
echo ${ZONE}.procs $NPROC
done

exit 0