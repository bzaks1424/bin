#!/bin/bash

SERVER=${1}
if [ -z "${SERVER}" ]; then
	echo "ERROR: Need SERVER argument to continue!";
	echo "Example:";
	echo "	${0} 192.168.1.200";
	exit 1;
fi;


SHUSER="${USER}"
if [ ! -z "${2}" ]; then
	echo "Running as custom user: ${2}";
	SHUSER=${2}
else
	if [ -z ${USER} ]; then
		echo "ERROR! Need to run this as a user!";
		exit 1;
	fi;
fi;

while [ $(  nc -w 3 -z ${SERVER} 22; echo $? ) = "1" ]; do
	echo "Waiting on ${SERVER} to wake up (22)";
    sleep 3;
done;

ssh ${SHUSER}@${SERVER};
