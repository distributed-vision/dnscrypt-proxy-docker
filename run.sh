#!/bin/bash

etcdctl get privateKey > /private.key 
printf "\n" >> /private.key
/opt/dnscrypt-proxy/sbin/dnscrypt-proxy \
                   --user=_dnscrypt-proxy \
                   --local-address=$LISTEN_ADDR \
                   --provider-name=$PROVIDER_NAME \
                   --provider-key=$PROVIDER_KEY \
                   --resolver-address=$RESOLVER_ADDR \
                   --loglevel=$LOGLEVEL \
                   --edns-payload-size=$EDNS_PAYLOAD_SIZE \
                   -K /private.key

