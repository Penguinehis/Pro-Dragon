#!/bin/bash
username=$1
password=$2
dias=$3
sshlimiter=$4
pkill -u $username
userdel $username
php /opt/DragonCore/menu.php deleteData $username
echo "1"
final=$(date "+%Y-%m-%d" -d "+$dias days")
gui=$(date "+%d/%m/%Y" -d "+$dias days")
pass=$(perl -e 'print crypt($ARGV[0], "password")' $password)
useradd -e $final -M -s /bin/false -p $pass $username
php /opt/DragonCore/menu.php insertData $username $password $sshlimiter