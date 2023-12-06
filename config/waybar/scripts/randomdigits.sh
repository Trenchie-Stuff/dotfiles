#!/bin/bash
# loop infinitely

while :
do
    # get random number between 1 and 10
    rnd=$(tr -cd "[:digit:]" < /dev/urandom | head -c 5);
    # print random number
    echo $rnd;
    # sleep for a random amount of time.
    sleep $(( ( RANDOM % 5 ) + 1 ))
done