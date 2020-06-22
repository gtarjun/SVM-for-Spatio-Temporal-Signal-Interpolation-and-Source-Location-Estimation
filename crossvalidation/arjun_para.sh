#!/bin/bash
 
rm parameters
     counter=1;
 for i in $(seq -5 0.2 10 );
do
  for j in $(seq -5 0.2 5 );

#do
#for k in $(seq 1 1 1000);
do
  echo '['$i,$j,$counter']' >> parameters
  counter=$[counter+1];
done
done 
#done
