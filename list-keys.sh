#!/bin/bash
RED='\033[0;31m'
GREEN='\033[0;32m'
END='\033[0m'

for i in keys/??.pem
do
        if [[ "$i" != "keys/crl.pem" ]] ; then
                echo -n "$i: "
                pem=$(echo $i| cut -c6-7)
                #echo $pem
                cn=$(openssl x509 -in $i -subject -noout |cut -d" " -f18| sed 's/,$//')
                line=$(cat keys/index.txt | grep $cn | grep $pem)
                if [[ ${line:0:1} == "R" ]]; then
                        echo -e "${RED}$cn${END}"
                else
                        echo -e "${GREEN}$cn${END}"
                fi
        fi
done
