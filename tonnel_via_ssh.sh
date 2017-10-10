#!/bin/bash

[ $# -eq 0 ] && {
echo "Usage: $(basename "$0") [-n NUMBER] VENTURE 

	-n		node number (1 or 2) / Default node = 1

	venture		name of venture (vn, sg, th, etc...)

Examples of usage:
	$(basename "$0") -n 2 vn
	$(basename "$0") sg"
exit 1
}

USERNAME='***'

SSH_PROCESS="$(lsof -i -P | grep :3306 | awk '$1=="ssh"' | awk 'FNR == 1 {print $2}')"


# kill ssh process
if [ ! -z $SSH_PROCESS ]
then
    echo "killing ssh process..."
    kill $SSH_PROCESS
fi

# default node
NODE_NUMBER=1

# choose node
while getopts "n::" opt
do
    NODE_NUMBER=$OPTARG
done

# set ventures
case ${@:$OPTIND:1} in
        "vn" | "VN" )
                VENTURE=VN
                DBHOST='***'
                NODE1='***'
                NODE2='***'
        ;;
        "sg" | "SG" )
                VENTURE=SG
                DBHOST='***'
                NODE1='***'
                NODE2='***'
        ;;
esac

# set host
HOST="NODE"$NODE_NUMBER

# connect
echo "ssh to $VENTURE..."
echo "Used node: ${!HOST}"
ssh -2 -f -N -L 3306:$DBHOST:3306 $USERNAME@${!HOST}

