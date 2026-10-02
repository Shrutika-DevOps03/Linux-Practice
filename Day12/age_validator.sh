#!/bin/bash
read -p "Enter your age: " age

#if ! [[ $age =~ ^[0-9]+$ ]]; then
#    echo "Error: Invalid age"
#   exit 1
#fi

if [ $age -lt 18 ]; then
    echo "You are a minor"
elif [ $age -lt 65 ]; then
    echo "You are an adult"
else
    echo "You are a senior"
fi
