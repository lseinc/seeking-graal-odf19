#!/bin/bash

delay() {
	sleep 1
}

URL=http://localhost:8088

curl -v  $URL
echo ""
delay

curl -v  $URL/api
delay
echo ""

curl -v -H "Content-Type: application/json" \
     -XPUT -d '{ "message": "Hello Ohio Dev Fest !!!" }' \
     $URL/api 
delay
echo ""

