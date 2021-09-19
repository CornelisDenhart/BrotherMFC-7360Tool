#!/bin/bash

# This script updates the clock of 
# Brother MFC-7360N, possibly also other models of this series
# So this compensates the lack of NTP client and Real-time-clock functionality of this device.
#
# This script relies problably on the following firmware version on the device: L
#
# (c) Cornelis Denhart 2021, Licensed as GNU GPLv3
# Visit https://github.com/CornelisDenhart/BrotherMFC-7360Tool for updates and more information 

# IP Address (or hostname) of Brother MFC device
MFCIP="192.168.26.55"

# Credentials for MFC; these are the factory default values
MFCuser="user"
MFCpassword="access"

# Timzone, which the MFC should use
# See /usr/share/zoneinfo/ for more names
# https://unix.stackexchange.com/questions/48101/how-can-i-have-date-output-the-time-from-a-different-timezone
timezone="Europe/Berlin"

#------------------------------------------------------------------------------------------

dateURL="http://$MFCIP/fax/general_setup.html?kind=item"

headerData="Content-Type: application/x-www-form-urlencoded"
currentDate=$(TZ=$timezone date "+%Y%m%d%H%M")
currentYr=$(TZ=$timezone date "+%Y")
currentMnth=$(TZ=$timezone date "+%m")
currentDy=$(TZ=$timezone date "+%d")
currentHr=$(TZ=$timezone date "+%H")
currentMin=$(TZ=$timezone date "+%M")
postData="DateTime=$currentDate&Day=$currentDy&Month=$currentMnth&Year=$currentYr&Hour=$currentHr&Minute=$currentMin"

result=$(curl -u $MFCuser:$MFCpassword --header "$headerData" --connect-timeout 5 --max-time 10 --data $postData $dateURL 2>&1) 
