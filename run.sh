#!/bin/bash

CLIENT_NAME=${CLIENT_NAME:="client1"}

while :
do
   etcdctl get dns/proxy/${CLIENT_NAME}/clprivate.key > /private.key 2>/dev/null
   result=$?
   if [ $result -eq 0 ]
   then
	echo "Got private key"
	break
   fi
   sleep 1
done
printf "\n" >> /private.key
sudo dnscrypt-proxy -k  AE29:DB12:5452:0DA9:AE49:E76F:92F9:6F09:D014:903B:E280:1B9E:99F1:2438:D24A:3AEC -r 127.0.0.1:443 -N 2.dnscrypt-cert.yourdomain.com  127.0.0.2:53 -K /private.key

