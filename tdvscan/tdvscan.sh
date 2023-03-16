#!/bin/sh

#default value arg
interface="tun0"
rate=500
na=""

#argument
while getopts i:e:r:n: flag
do
    case "${flag}" in
    i) ip=${OPTARG};;
    e) interface=${OPTARG};;
    r) rate=${OPTARG};;
    n) na=${OPTARG};;
    esac
done

PORT=$(sudo masscan --rate $rate -p1-65353 -e $interface $ip | grep -o -P "(?<=open port\s)\d+" | tr '\n' ', ')

echo "====================================================================================="
echo "Port Open: $PORT"
echo "====================================================================================="

sudo nmap $ip -p $PORT -Pn $na