#!/bin/bash

# Make 1,000,000 empty commits
for i in {1..1000000}
do
   git commit --allow-empty -m "Empty commit $i"
done
