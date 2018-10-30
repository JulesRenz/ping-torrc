#!/bin/bash

IP=$1
SLOWFILE=$2
FASTFILE=$3

TARGETFILE=/etc/tor/torrc

if [ "$#" -ne 3 ]; then
    echo "Needs 3 parameters. Usage: ping-torrc.sh IP SLOW_TORRC FAST_TORRC"
    echo "Example: ping-torrc.sh 192.168.1.100 torrc_slow torrc_fast"
    exit -1
fi


ping -c 1 $IP
ALIVE=$?

if [ $ALIVE = "0" ]; then
    #PC present
    #modify torrc file for low bandwidth
    echo "PC $IP pingable - setting tor to low bandwidth"
    cmp $SLOWFILE $TARGETFILE
    MATCH=$?
    if [ $MATCH = "0" ]; then
        echo "$SLOWFILE alredy copied to $TARGETFILE"
    else
        echo "Coyping $SLOWFILE to $TARGETFILE"
        cp $SLOWFILE $TARGETFILE
        systemctl restart tor
    fi
    exit 0
else
    #PC present
    #modify torrc file for low bandwidth
    echo "PC $IP not pingable - setting to to high bandwidth"
    cmp $FASTFILE $TARGETFILE
    MATCH=$?
    if [ $MATCH = "0" ]; then
        echo "$FASTFILE alredy copied to $TARGETFILE"
    else
        echo "Coyping $FASTFILE to $TARGETFILE"
        cp $FASTFILE $TARGETFILE
        systemctl restart tor
    fi
    exit 0
fi