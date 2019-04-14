#!/bin/bash

rm -f /tmp/fc; mkfifo  /tmp/fc 
cat /tmp/fc | ./clienteAdivinar.sh -i 2>&1 | nc 127.0.0.1 8080 > /tmp/fc
#cat /tmp/fc |  nc 192.168.14.120 8080 | ./clienteAdivinar.sh -i 2>&1 |> /tmp/fc
#cat /tmp/fc | ./clienteAdivinar.sh -i | nc 192.168.14.120 8080   > /tmp/fc
