#!/bin/bash
# ------------------------------------------------------------------
# TITLE : Spinup local peer network
# AUTHOR: Ramesh Thoomu & Barry
# VERSION: 1.0

# DESCRIPTION:
# The purpose of this script is to spinup peers in local machine using docker.
# Peers launches on tested peer and membersrvc docker images and latest hyperledger/fabric
# base image. Script pulls these images from rameshthoomu docker hub account. Take the
# latest commit of peer and membersrvc from rameshthoomu docker hub account.
# Pre-condition: Install docker in your local machine and start docker daemon

## USAGE:
# local_fabric.sh [OPTIONS]

# OPTIONS:
#       -n   - Number of peers to launch
#       -s   - Enable Security and Privacy
#       -c   - Specific commit
#       -l   - Enable logging method
#       -m   - Enable consensus mode
#
# SAMPLE :
#       ./local_fabric.sh -n 4 -s -c 346f9fb -l debug -m pbft
# ------------------------------------------------------------------

PEER_IMAGE=rameshthoomu/peer
MEMBERSRVC_IMAGE=rameshthoomu/membersrvc
REST_PORT=5000
USE_PORT=30000
PBFT_MODE=batch
WORKDIR=$(pwd)

# Membersrvc
membersrvc_setup()
{
curl -L https://raw.githubusercontent.com/hyperledger/fabric/master/membersrvc/membersrvc.yaml -o membersrvc.yaml

local NUM_PEERS=$1
local IP=$2
local PORT=$3
echo "--------> Starting membersrvc Server"

docker run -d --name=caserver -p 50051:50051 -p 50052:30303 -it $MEMBERSRVC_IMAGE:$COMMIT membersrvc

echo "--------> Starting hyperledger PEER0"

docker run -d --name=PEER0 -it \
                -e CORE_VM_ENDPOINT="http://$IP:$PORT" \
                -e CORE_PEER_ID="vp0" \
                -e CORE_SECURITY_ENABLED=true \
                -e CORE_SECURITY_PRIVACY=true \
                -e CORE_PEER_ADDRESSAUTODETECT=false -p $REST_PORT:5000 -p `expr $USE_PORT + 1`:30303 \
                -e CORE_PEER_ADDRESS=$IP:`expr $USE_PORT + 1` \
                -e CORE_PEER_PKI_ECA_PADDR=$IP:50051 \
                -e CORE_PEER_PKI_TCA_PADDR=$IP:50051 \
                -e CORE_PEER_PKI_TLSCA_PADDR=$IP:50051 \
                -e CORE_PEER_LISTENADDRESS=0.0.0.0:30303 \
                -e CORE_PEER_VALIDATOR_CONSENSUS_PLUGIN=$CONSENSUS_MODE \
                -e CORE_PBFT_GENERAL_MODE=$PBFT_MODE \
                -e CORE_PBFT_GENERAL_N=$NUM_PEERS \
                -e CORE_PBFT_GENERAL_TIMEOUT_REQUEST=10s \
                -e CORE_PEER_LOGGING_LEVEL=$PEER_LOG \
                -e CORE_VM_DOCKER_TLS_ENABLED=false \
                -e CORE_SECURITY_ENROLLID=test_vp0 \
                -e CORE_SECURITY_ENROLLSECRET=MwYpmSRjupbT $PEER_IMAGE:$COMMIT peer node start

CONTAINERID=$(docker ps | awk 'NR>1 && $NF!~/caserv/ {print $1}')
PEER_IP_ADDRESS=$(docker inspect --format '{{.NetworkSettings.IPAddress}}' $CONTAINERID)

for (( peer_id=1; $peer_id<"$NUM_PEERS"; peer_id++ ))
do
# Storing USER_NAME and SECRET_KEY Values from membersrvc.yaml file: Supports maximum 10 peers

USER_NAME=$(awk '/users:/,/^[^ ]/' membersrvc.yaml | egrep "test_vp$((peer_id)):" | cut -d ":" -f 1 | tr -d " ")
SECRET_KEY=$(awk '/users:/,/^[^ ]/' membersrvc.yaml | egrep "test_vp$((peer_id)):" | cut -d ":" -f 2 | cut -d " " -f 3)
REST_PORT=`expr $REST_PORT + 1`
USE_PORT=`expr $USE_PORT + 2`

echo "--------> Starting hyperledger PEER$peer_id <-----------"

docker run  -d --name=PEER$peer_id -it \
                -e CORE_VM_ENDPOINT="http://$IP:$PORT" \
                -e CORE_PEER_ID="vp"$peer_id \
                -e CORE_SECURITY_ENABLED=true \
                -e CORE_SECURITY_PRIVACY=true \
                -e CORE_PEER_ADDRESSAUTODETECT=true -p $REST_PORT:5000 -p `expr $USE_PORT + 1`:30303 \
                -e CORE_PEER_DISCOVERY_ROOTNODE=$IP:30001 \
                -e CORE_PEER_PKI_ECA_PADDR=$IP:50051 \
                -e CORE_PEER_PKI_TCA_PADDR=$IP:50051 \
                -e CORE_PEER_PKI_TLSCA_PADDR=$IP:50051 \
                -e CORE_PEER_LISTENADDRESS=0.0.0.0:30303 \
                -e CORE_PEER_VALIDATOR_CONSENSUS_PLUGIN=$CONSENSUS_MODE \
                -e CORE_PBFT_GENERAL_MODE=$PBFT_MODE \
                -e CORE_PBFT_GENERAL_N=$NUM_PEERS \
                -e CORE_PBFT_GENERAL_TIMEOUT_REQUEST=10s \
                -e CORE_PEER_LOGGING_LEVEL=$PEER_LOG \
                -e CORE_VM_DOCKER_TLS_ENABLED=false \
                -e CORE_SECURITY_ENROLLID=$USER_NAME \
                -e CORE_SECURITY_ENROLLSECRET=$SECRET_KEY $PEER_IMAGE:$COMMIT peer node start
done
}
# Peer Setup without security and privacy
peer_setup()

{

    local  NUM_PEERS=$1
    local  IP=$2
    local  PORT=$3
echo "--------> Starting hyperledger PEER0 <-----------"
docker run -d  -it --name=PEER0 \
                -e CORE_VM_ENDPOINT="http://$IP:$PORT" \
                -e CORE_PEER_ID="vp0" \
                -p $REST_PORT:5000 -p `expr $USE_PORT + 1`:30303 \
                -e CORE_PEER_ADDRESS=$IP:`expr $USE_PORT + 1` \
                -e CORE_PEER_ADDRESSAUTODETECT=true \
                -e CORE_PEER_LISTENADDRESS=0.0.0.0:30303 \
                -e CORE_PEER_LOGGING_LEVEL=$PEER_LOG \
                -e CORE_VM_DOCKER_TLS_ENABLED=false $PEER_IMAGE:$COMMIT peer node start

CONTAINERID=$(docker ps | awk 'NR>1 && $NF!~/caserv/ {print $1}')
PEER_IP_ADDRESS=$(docker inspect --format '{{.NetworkSettings.IPAddress}}' $CONTAINERID)

for (( peer_id=1; peer_id<"$NUM_PEERS"; peer_id++ ))
do
echo "--------> Starting hyperledger PEER$peer_id <------------"
REST_PORT=`expr $REST_PORT + 1`
USE_PORT=`expr $USE_PORT + 2`

docker run -d -it --name=PEER$peer_id \
                -e CORE_VM_ENDPOINT="http://$IP:$PORT" \
                -e CORE_PEER_ID="vp"$peer_id \
                -p $REST_PORT:5000 -p `expr $USE_PORT + 1`:30303 \
                -e CORE_PEER_DISCOVERY_ROOTNODE=$IP:30001 \
                -e CORE_PEER_ADDRESSAUTODETECT=false \
                -e CORE_PEER_ADDRESS=$IP:`expr $USE_PORT + 1` \
                -e CORE_PEER_LISTENADDRESS=0.0.0.0:30303 \
                -e CORE_PEER_LOGGING_LEVEL=$PEER_LOG \
                -e CORE_VM_DOCKER_TLS_ENABLED=false $PEER_IMAGE:$COMMIT peer node start
done
}

function usage()
{
        echo "USAGE :  local_fabric.sh -n <number of Peers> -s <enable security and privacy> -c <commit number> -l <logging level> -m <consensus mode>"
        echo "ex: ./local_fabric.sh -n 4 -s -c 346f9fb -l debug -m pbft "
}

while getopts "\?hsn:c:l:m:" option; do
  case "$option" in
     s)   SECURITY="Y"     ;;
     n)   NUM_PEERS="$OPTARG" ;;
     c)   COMMIT="$OPTARG"  ;;
     l)   PEER_LOG="$OPTARG" ;;
     m)   CONSENSUS_MODE="$OPTARG" ;;
   \?|h)  usage
          exit 1
          ;;
  esac
done


#let's clean house

#kill all running containers and LOGFILES...Yet to implement Log rotate logic

docker kill $(docker ps -q) 1>/dev/null 2>&1
docker ps -aq -f status=exited | xargs docker rm 1>/dev/null 2>&1
rm LOG*
docker rm -f $(docker ps -aq)

echo "--------> Setting default command line Arg values to without security & consensus and starts 5 peers"
: ${SECURITY:="N"}
: ${NUM_PEERS="5"}
: ${COMMIT="latest"}
: ${PEER_LOG="debug"}
: ${CONSENSUS_MODE="pbft"}
SECURITY=$(echo $SECURITY | tr a-z A-Z)

echo "Number of PEERS are $NUM_PEERS"
if [ $NUM_PEERS -le 0 ] ; then
        echo "Enter valid number of PEERS"
        exit 1
fi

echo "Is Security and Privacy enabled $SECURITY"

echo "--------> Pulling Base Docker Images from Docker Hub"

#Pulling latest docker image from rameshthoomu/baseimage repository
docker pull rameshthoomu/baseimage:latest
docker tag rameshthoomu/baseimage:latest hyperledger/fabric-baseimage:latest
docker pull rameshthoomu/peer:$COMMIT
docker pull rameshthoomu/membersrvc:$COMMIT

#curl -L https://github.com/rameshthoomu/fabric/blob/master/scripts/provision/common.sh -o common.sh
#curl -L https://raw.githubusercontent.com/rameshthoomu/fabric/master/scripts/provision/docker.sh -o docker.sh
#chmod +x docker.sh
#sudo ./docker.sh 0.0.9

if [ "$SECURITY" == "Y" ] ; then
        echo "--------> Fetching IP address"
        IP="$(ifconfig docker0 | grep "inet" | awk '{print $2}' | cut -d ':' -f 2)"
        echo "Docker0 interface IP Address $IP"
        echo "--------> Fetching PORT number"
        PORT="$(sudo netstat -tunlp | grep docker | awk '{print $4'} | cut -d ":" -f 4)"
        echo "PORT NUMBER IS $PORT"
        echo "--------> Calling membersrvc_setup function"
        membersrvc_setup $NUM_PEERS $IP $PORT

else

        IP="$(ifconfig docker0 | grep "inet" | awk '{print $2}' | cut -d ':' -f 2)"
        echo "Docker0 interface IP Address $IP"
        PORT="$(sudo netstat -tunlp | grep docker | awk '{print $4'} | cut -d ":" -f 4)"
        echo "PORT NUMBER IS $PORT"
        echo "--------> Calling CORE PEER function"
        peer_setup $NUM_PEERS $IP $PORT
fi

echo "--------> Printing list of Docker Containers"
CONTAINERS=$(docker ps | awk 'NR>1 && $NF!~/caserv/ {print $1}')
echo $CONTAINERS
NUM_CONTAINERS=$(echo $CONTAINERS | awk '{FS=" "}; {print NF}')
echo $NUM_CONTAINERS

# Printing Log files
for (( container_id=1; $container_id<="$((NUM_CONTAINERS))"; container_id++ ))
do
        CONTAINER_ID=$(echo $CONTAINERS | awk -v con_id=$container_id '{print $con_id}')
        CONTAINER_NAME=$(docker inspect --format '{{.Name}}' $CONTAINER_ID |  sed 's/\///')
        docker logs -f $CONTAINER_ID > "LOGFILE_$CONTAINER_NAME"_"$CONTAINER_ID" &
done

# Writing Peer data into a file for Go SDK

cd $WORKDIR
touch networkcredentials
echo "{" > $WORKDIR/networkcredentials
echo "   \"PeerData\" :  [" >> $WORKDIR/networkcredentials
echo " "
echo "PeerData : "

echo "----------> Printing Container ID's with IP Address and PORT numbers"
REST_PORT=5000

for (( container_id=$NUM_CONTAINERS; $container_id>=1; container_id-- ))
do

        CONTAINER_ID=$(echo $CONTAINERS | awk -v con_id=$container_id '{print $con_id}')
        CONTAINER_NAME=$(docker inspect --format '{{.Name}}' $CONTAINER_ID |  sed 's/\///')
        echo "Container ID $CONTAINER_ID   Peer Name: $CONTAINER_NAME"
        CONTAINER_NAME=$(docker inspect --format '{{.Name}}' $CONTAINER_ID |  sed 's/\///')
        peer_http_ip=$(docker inspect --format '{{.NetworkSettings.IPAddress}}' $CONTAINER_ID)
        api_host=$peer_http_ip
        api_port=$(docker inspect --format='{{(index (index .NetworkSettings.Ports "5000/tcp") 0).HostPort}}' $CONTAINER_ID)
        echo "   { \"name\" : \"$CONTAINER_NAME\", \"api-host\" : \"$api_host\", \"api-port\" : \"$REST_PORT\" } , " >> $WORKDIR/networkcredentials
        echo " REST_EndPoint : $api_host:$api_port"
        api_port_grpc=$(docker inspect --format='{{(index (index .NetworkSettings.Ports "30303/tcp") 0).HostPort}}' $CONTAINER_ID)
        echo " GRPC_EndPoint : $api_host:$api_port_grpc"
        echo " "

done
        sed  -i '$s/,[[:blank:]]*$//' $WORKDIR/networkcredentials

        echo "   ],"  >> $WORKDIR/networkcredentials

# Writing UserData into a file for go SDK
if [ "$SECURITY" == "Y" ] ; then

echo "   \"UserData\" :  [" >> $WORKDIR/networkcredentials

        echo " "

echo "Client Credentials : "
echo " "
        for ((i=0; i<=$NUM_CONTAINERS-1;i++))
        do
        CLIENT_USER=$(awk '/users:/,/^[^ #]/' membersrvc.yaml | egrep "test_user$((i)):" | cut -d ":" -f 1 | tr -d " ")
        CLIENT_SECRET_KEY=$(awk '/users:/,/^[^ #]/' membersrvc.yaml | egrep "test_user$((i)):" | cut -d ":" -f 2 | cut -d " " -f 3)
        echo "username: $CLIENT_USER  secretkey : $CLIENT_SECRET_KEY"
        echo "   { \"username\" : \"$CLIENT_USER\", \"secret\" : \"$CLIENT_SECRET_KEY\" } , " >> $WORKDIR/networkcredentials

done

        sed  -i '$s/,[[:blank:]]*$//' $WORKDIR/networkcredentials

        echo "   ],"  >> $WORKDIR/networkcredentials
fi
# Writing PeerGrpc Data into a file for go SDK
        echo "   \"PeerGrpc\" :  [" >> $WORKDIR/networkcredentials
        echo " "

for (( container_id=$NUM_CONTAINERS; $container_id>=1; container_id-- ))
do

        CONTAINER_ID=$(echo $CONTAINERS | awk -v con_id=$container_id '{print $con_id}')
        CONTAINER_NAME=$(docker inspect --format '{{.Name}}' $CONTAINER_ID |  sed 's/\///')
        peer_http_ip=$(docker inspect --format '{{.NetworkSettings.IPAddress}}' $CONTAINER_ID)
        api_host=$peer_http_ip
        api_port_grpc=$(docker inspect --format='{{(index (index .NetworkSettings.Ports "30303/tcp") 0).HostPort}}' $CONTAINER_ID)
        echo "   { \"api-host\" : \"$api_host\", \"api-port\" : \"$api_port_grpc\" } , " >> $WORKDIR/networkcredentials
done
        sed  -i '$s/,[[:blank:]]*$//' $WORKDIR/networkcredentials

        echo "   ],"  >> $WORKDIR/networkcredentials

        echo " \"Name\": \"localpeer_ramesh\" " >> $WORKDIR/networkcredentials
        echo "} "  >> $WORKDIR/networkcredentials