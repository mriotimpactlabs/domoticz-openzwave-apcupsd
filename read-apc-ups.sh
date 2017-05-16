#!/bin/bash
#Script to grab APC status and update Domoticz variables.

#This is how to connect with the Domoticz server.
SERVER='localhost:8080/'
SERVER_CMD='json.htm?type=command&param=udevice&'
SWITCH_CMD='json.htm?type=command&param=switchlight&'
#This is the call for the APC-UPS status.  Data is pulled from this command.
cap_data=`/sbin/apcaccess status`

apc_stat=`awk '/STATUS / {print $3}' <<< "$cap_data"`
apc_volts=`awk '/LINEV / {print $3}' <<< "$cap_data"`
apc_itemp=`awk '/ITEMP / {print $3}' <<< "$cap_data"`
apc_load=`awk '/LOADPCT / {print $3}' <<< "$cap_data"`

#echo $apc_stat
#echo $apc_volts
#echo $apc_itemp
#echo $apc_load

hostcmd="http://${SERVER}${SERVER_CMD}idx=2&nvalue=0&svalue=${apc_itemp}"
curlres=`curl -sS $hostcmd`
hostcmd="http://${SERVER}${SERVER_CMD}idx=3&nvalue=0&svalue=${apc_volts}"
curlres=`curl -sS $hostcmd`
hostcmd="http://${SERVER}${SERVER_CMD}idx=4&nvalue=0&svalue=${apc_load}"
curlres=`curl -sS $hostcmd`

#If the UPS is online, command Domoticz to switch it's APC-UPS-Power-State to ON.
if  [ "$apc_stat" = "ONLINE" ]; then
echo "APC SYSTEM IS ONLINE"
hostcmd="http://${SERVER}${SWITCH_CMD}idx=1&switchcmd=On&level=0"
curlres=`curl -sS $hostcmd`
#If the UPS is offline, command Domoticz to switch it's APC-UPS-Power-State to OFF.
else
echo "APC SYSTEM IS OFFLINE"
hostcmd="http://${SERVER}${SWITCH_CMD}idx=1&switchcmd=Off&level=0"
curlres=`curl -sS $hostcmd`

fi
