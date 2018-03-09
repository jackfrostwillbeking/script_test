#!/bin/bash
HOSTNAME=$(hostname)
FILE="${HOSTNAME}_log.txt"
dpkg -l|grep -w openssl > $FILE
REFRESH_TOKEN="1/j06fxt0YkYtrQEBUvKd_ILHsX_l2T7LN84FRG1uuZoeUQTEz3fEbIOXusFQoJRJI"
CLIENT_ID="761866041142-ss6v9qaiq0oel3esqm81enbf0k24dvh1.apps.googleusercontent.com"
CLIENT_SECRET="H4bQe1RaElK6WXUfirfHSdEF"
META_DATA="{\"title\": \"$FILE\",\"mimeType\": \"text/plain\",\"description\": \"Uploaded From Curl\"}"

function upload_file() {
    curl -X POST https://www.googleapis.com/upload/drive/v2/files?uploadType=multipart \
    -H "Authorization: Bearer $ACCESS_TOKEN" \
    -H "Content-Type: multipart/related" \
    -F "metadata=$META_DATA;type=application/json;charset=UTF-8" \
    -F "file=@$FILE;type=text/plain"
}

function refresh_access_token(){
    ACCESS_TOKEN=$(curl -X POST https://accounts.google.com/o/oauth2/token \
    -d "refresh_token=$REFRESH_TOKEN" \
    -d "client_id=$CLIENT_ID" \
    -d "client_secret=$CLIENT_SECRET" \
    -d "grant_type=refresh_token"|grep "access_token" |cut -d ":" -f 2|sed -e "s/^\"//g"|sed -e "s/\",$//g")
}

refresh_access_token
upload_file
