#!/bin/bash

CLIENT_NAME=${CLIENT_NAME:="client1"}
ETCD=${ETCD:="http://192.168.2.71:2379"}

while :
do
   etcdctl -C $ETCD get /dns/proxy/${CLIENT_NAME}/private.key > /private.key 2>/dev/null
   result=$?
   if [ $result -eq 0 ]
   then
	echo "Got private key"
	break
   fi
   sleep 1
done
printf "\n" >> /private.key
while :
do
   WRAPPER=`etcdctl -C $ETCD get /dns/wrapper/host    2>/dev/null`
   result=$?
   # 172.17.0.1
   if [ $result -eq 0 ]
   then
        echo "Got wrapper host"
        echo $WRAPPER
        break
   fi
   sleep 1
done
sudo /opt/dnscrypt-proxy/sbin/dnscrypt-proxy -k  AE29:DB12:5452:0DA9:AE49:E76F:92F9:6F09:D014:903B:E280:1B9E:99F1:2438:D24A:3AEC -r $WRAPPER -N 2.dnscrypt-cert.yourdomain.com  127.0.0.1:53 -K /private.key

