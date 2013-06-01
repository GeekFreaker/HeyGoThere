#!/bin/bash

SERVER=http://heygothere.house4hack.co.za/couchdb
SERVER=http://localhost:5984

cd hgt

curl -X DELETE $SERVER/hgt
couchapp push $SERVER/hgt

#curl -i -X POST -H 'Content-Type: application/json' -d '{"token":"token123"}'  $SERVER/hgt/_design/hgt/_update/user/123
#curl -i -X POST -H 'Content-Type: application/json' -d '{"token":"token123"}'  $SERVER/hgt/_design/hgt/_update/user/123
#curl -i -X POST -H 'Content-Type: application/json' -d '{"token-misspelled":"token123"}'  $SERVER/hgt/_design/hgt/_update/user/123
#curl -i -X POST -H 'Content-Type: application/json' -d '{"token":"token123"}'  $SERVER/hgt/_design/hgt/_update/user/1234

curl -i -X POST -H 'Content-Type: application/json' -d '{"kind":"warning", "lat":-26.05, "lon":27.90, "description":"Cookie monster was here", "userid":"123","username":"schalk"}'  $SERVER/hgt/_design/hgt/_update/tag

curl -i -X POST -H 'Content-Type: application/json' -d '{"kind":"recommendation", "lat":-26.05, "lon":27.90, "expires":"2013-06-02T12:34:56Z","description":"Lot of milk here for the rest of the weekend", "username":"anonymous"}'  $SERVER/hgt/_design/hgt/_update/tag/1
curl -i -X POST -H 'Content-Type: application/json' -d '{"kind":"recommendation", "lat":-26.05, "lon":27.90, "expires":"2013-06-02T12:34:56Z","description":"Milk almost done", "username":"anonymous"}'  $SERVER/hgt/_design/hgt/_update/tag/1

curl -X GET $SERVER/hgt/_design/hgt/_view/users
curl -X GET $SERVER/hgt/123
curl -g -X GET "$SERVER/hgt/_design/hgt/_view/users?key=\"123\""


curl -X GET $SERVER/hgt/_design/hgt/_view/tags
curl -g -X GET $SERVER/hgt/_design/hgt/_view/tags?startkey=[-27,27]\&endkey=[-25,28]
curl -g -X GET $SERVER/hgt/_design/hgt/_view/tags?startkey=[-27,27]\&endkey=[-27,28]


curl -X POST -H "Content-Type: application/json" -d "{\"keys\":[\"123\",\"1234\"]}" $SERVER/hgt/_design/hgt/_view/friendtags

curl -X GET $SERVER/hgt/_design/hgt/_view/timestampuser
curl -g -X GET "$SERVER/hgt/_design/hgt/_view/timestampuser?startkey=\"2013-06-01\""
curl -g -X GET "$SERVER/hgt/_design/hgt/_view/timestampuser?startkey=\"2013-06-02\""





