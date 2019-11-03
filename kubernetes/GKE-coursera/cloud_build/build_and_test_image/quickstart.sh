#!/bin/sh
if [ -z "$1" ]      # string is null, that is, has zero length
then
	echo "Hello, world! The time is $(date)."
	exit 0
else
	exit 1
fi

