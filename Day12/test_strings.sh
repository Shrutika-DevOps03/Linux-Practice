#!/bin/bash
name="Alice"
city="London"

if [ "$name" = "Alice" ]; then
    echo "Name is Alice"
fi

if [ -n "$city" ]; then
    echo "City is not empty: $city"
fi

if [ "$name" = ^A ]; then
    echo "Name starts with A"
fi
