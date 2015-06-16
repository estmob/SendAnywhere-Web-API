#! /bin/sh

. ./auth.sh

TOKEN_FILE=.sendanywhere-token.txt

if `test $# -lt 1`; then
    echo "usage: $0 file"
    exit 1
fi

RET=`curl -s -b$TOKEN_FILE https://send-anywhere.com/web/v1/key`

KEY=`echo $RET | jq '.key' -r 2>/dev/null`
FILE_URL=`echo $RET | jq '.weblink' -r 2>/dev/null`

if `test -z "$KEY"`; then
    echo "Failed to create key!"
    exit
fi

echo "key: $KEY"
curl -F file=@$1 $FILE_URL > /dev/null


