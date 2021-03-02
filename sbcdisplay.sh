#! /bin/bash
#######################################################################################################
# Author: Justin McAfee                                                                               #
# Contact: me@justinmcafee.com                                                                        #
# Purpose: To autolaunch browsers for freestanding displays connected to Raspberry Pi                 #
# Date: 1MAR2021                                                                                      #
# Revision: 1.0                                                                                       #
#######################################################################################################

dependencies=(firefox nc)
url="http://localhost:4316/stage"

errorcheck(){
    if [ $? -ne 0 ]; then 
	printf " An error was encountered.\n Please install $i before continuing\n"
	exit
    fi
return
}

depcheck(){
for i in "${dependencies[@]}"; do
    which "$i"
    errorcheck $i
    done

}

checkconn(){
nc -z 8.8.8.8 53
if [ $(echo $0) -ne 0 ]; then
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

