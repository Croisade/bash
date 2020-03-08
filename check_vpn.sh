#! /bin/bash
# this is the script cron runs, it checks to see if tun0 is connected or not
# if not, it kills deluge
# we'll put the whole thing in a function so we can call it every few seconds
function check {
# if ifconfig doesn't see tun0 at all, kill deluge
if [ "$(/sbin/ifconfig -a | grep tun0)" == "" ]; then
        sudo killall deluged
fi
# check to see if tun0 is up
if [ "$tun0_ip" == "10.8.2.166" ]; then
        if isUp=`/sbin/ethtool tun0 | grep Link | cut -d ' ' -f 3 2> /dev/null`; then
                # if it's not running, kill deluge
                if [ "$isUp" == "no" ] ; then
                        sudo killall deluged
                fi
        fi
fi
}
# now we'll run it
check
