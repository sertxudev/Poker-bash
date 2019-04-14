#!/bin/bash

rm -f /tmp/f; mkfifo /tmp/f
#cat /tmp/f | ./adivinar.sh -i 2>&1 | nc -l 8080 > /tmp/f
# cat /tmp/f | ./adivinar.sh -i | nc -N -l 8080 > /tmp/f
cat /tmp/f | tcpserver -q -H -R 127.0.0.1 8080 ./adivinar.sh > /tmp/f