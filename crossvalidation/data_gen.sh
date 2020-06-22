#!/bin/bash
rm msizes
for i in $(seq 1 64 );
do
  echo $i >> msizes
done
