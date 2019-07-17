#! /bin/bash
for FILE in $*; do
    if [ ! -e $FILE ]; then
        echo "$FILE does not exist. Please check the arguments you entered.";
        exit;
    fi  
done

dpkg -s jq 1> /dev/null

if [ $? -ne 0 ]; then
    echo "jq package is not installed! Please install jq (sudo apt install jq)"
    exit;
fi

. ./auth.sh

TOKEN_FILE=.sendanywhere-token.txt

if `test $# -lt 1`; then
    echo "usage: $0 file"
    exit 1
fi

BODY_OBJECT='{"file":[';
for FILE in $*; do
    BODY_OBJECT=$BODY_OBJECT'{"name":"'$FILE'","size":'$(stat -c%s $FILE)'}',
done
BODY_OBJECT=${BODY_OBJECT::-1}
BODY_OBJECT=$BODY_OBJECT']}'

echo $BODY_OBJECT

RET=`curl -v -XPOST -b$TOKEN_FILE \
	 -H 'Content-Type: application/json' \
	  -d $BODY_OBJECT \
	   'https://send-anywhere.com/web/v1/key'`


KEY=`echo $RET | jq '.key' -r 2>/dev/null`
FILE_URL=`echo $RET | jq '.weblink' -r 2>/dev/null`

if `test -z "$KEY"`; then
    echo "Failed to create key!"
    exit
fi

echo "key: $KEY"

FILE_UPLOAD='';
for FILE in $*; do
    FILE_UPLOAD=$FILE_UPLOAD"-F file=@$FILE "
done;

curl $FILE_UPLOAD $FILE_URL > /dev/null
