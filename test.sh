#!/bin/bash
PROG=$1
if [ ! -e $PROG ]
    then
        echo "$PROG does not exist. Have you compiled it with make?"
        exit 1
    fi

NUM_OF_TEST_CASES=$2
num_failed=0
num_passed=0
for i in $(seq 1 $NUM_OF_TEST_CASES)
do
    out=$(mktemp --suffix=$prog)
    ./$PROG < inputs/$PROG.$i.in > $out
        if [ `diff -bB $out outputs/$PROG.$i.out | wc -l` -ne 0 ]
            then
                echo "$PROG: incorrect output for test case $i"
                num_failed=$((num_failed + 1))
        else
                num_passed=$((num_passed + 1))
    fi
    rm $out
done
if [ $num_passed -eq $NUM_OF_TEST_CASES ]
then
    echo "$PROG: passed"
fi