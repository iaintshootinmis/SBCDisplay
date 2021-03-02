#! /bin/bash
#######################################################################################################
# Author: Justin McAfee                                                                               #
# Contact: me@justinmcafee.com                                                                        #
# Purpose: To autolaunch browsers for freestanding displays connected to Raspberry Pi                 #
# Date: 1MAR2021                                                                                      #
# Revision: 1.0                                                                                       #
#######################################################################################################
#Note: add the below to a crontab running in the user context. 
# @reboot export DISPLAY=:0 && sleep 30 && /home/pi/Desktop/sbcdisplay.sh
# @reboot runs the script at boot 
# export DISPLAY=:0 sets the display variable for a non-x terminal session
# sleep 30 allows for network and other services to load before checking connectivity
# path to your script 
######################################################################################################

dependencies=(firefox nc)
url="http://10.0.0.164:4316/stage"
log="./Desktop/sbclog"

errorcheck(){
    if [ $? -ne 0 ]; then 
	printf "$date  An error was encountered.\n Please install $i before continuing\n" >> $log
	exit
    fi
return
}

depcheck(){
for i in "${dependencies[@]}"; do
    which "$i" 1>/dev/null
    errorcheck $i
    done

}

checkconn(){
nc -z 8.8.8.8 53
if [ $(echo $?) -ne 0 ]; then
    printf "Basic connectivity check failed. Please check connectivity.\n"
    exit
fi
}

launch(){
firefox --kiosk $url
}

depcheck
checkconn
launch

