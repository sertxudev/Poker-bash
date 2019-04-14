#!/bin/bash

secreto=5
numero=0
# while [ $secreto -ne $numero ] ; do 
while true ; do

	read numero

	echo "Server- número leído : $numero" >> fichero
	if [ "$secreto" -eq $numero ] ; then
		echo "Asertaste"
	else
		echo "Ha fallao"
	fi
done

