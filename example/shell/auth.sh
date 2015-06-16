#! /bin/sh

TOKEN_FILE=.sendanywhere-token.txt
API_KEY='YOUR_API_KEY'

if [ ! -e $TOKEN_FILE ]; then
    curl -s -c $TOKEN_FILE "https://send-anywhere.com/web/v1/device?api_key=$API_KEY&profile_name=Send%20Anywhere%20SDK" > /dev/null
fi

