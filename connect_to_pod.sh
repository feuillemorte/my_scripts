#!/bin/bash
name="$1"
podname="$2"
echo
        if [[ -z "$1" ]]; then
                echo " =====Error: Namespace is required "
                echo " Usage example: ./podlogs.sh <namespace> <pod_name> "
                exit 0
        fi
pod=$(kubectl --namespace=$name get po | grep $podname | awk 'NR==1{print $1}')

echo " =====Namespace: $name ====== "
echo
echo  " ===== Connecting to POD $pod ======"
echo

container=${pod%-*}

echo " = POD: $pod,  CONTAINER: $container"
cmd="kubectl --namespace=$name exec -it -c $container $pod bash"
eval $cmd

