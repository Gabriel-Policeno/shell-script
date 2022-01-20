#!/usr/bin/env bash

IP="1.1.1.1"

function espelha                                                                                                       
{                                                                                                                      
        # ssh $IP systemctl stop docker.service                                                             
        ssh 172.28.193.153 systemctl status docker.service                                                             
        systemctl stop docker.service                                                     
        rsync -avSH --del --exclude=postgresdata $IP:/opt/ /opt                         
        # ssh $IP /opt/geomais/gmv2/util/restart_sig.sh                       
        /opt/geomais/gmv2/util/restart_sig.sh
        sleep 10
        emparelha.sh                                                                                                   
}                                                                                                                      
                                                                                                                        
exec 200>/run/lock/espelha || exit 1                                                                                   
flock -n 200 || { echo "Outra instancia do script está sendo executada!"; exit 1; }                                   
                                                                                                                     
espelha 
