#!/bin/bash

SERVER=http://heygothere.house4hack.co.za/couchdb
#SERVER=http://cont3mpt:d3ath0wl@localhost:5984
SERVER=http://localhost:5984

cd hgt

curl -X DELETE $SERVER/hgt
couchapp push $SERVER/hgt

#curl -i -X POST -H 'Content-Type: application/json' -d '{"token":"token123"}'  $SERVER/hgt/_design/hgt/_update/user/123
#curl -i -X POST -H 'Content-Type: application/json' -d '{"token":"token123"}'  $SERVER/hgt/_design/hgt/_update/user/123
#curl -i -X POST -H 'Content-Type: application/json' -d '{"token-misspelled":"token123"}'  $SERVER/hgt/_design/hgt/_update/user/123
#curl -i -X POST -H 'Content-Type: application/json' -d '{"token":"token123"}'  $SERVER/hgt/_design/hgt/_update/user/1234


# -25.765284,28.196918

curl -i -X POST -H 'Content-Type: application/json' -d '{"kind":"warning", "lat":-25.765284, "lon":28.196918, "description":"Cookie monster is here", "userid":"123","username":"schalk"}'  $SERVER/hgt/_design/hgt/_update/tag
curl -i -X POST -H 'Content-Type: application/json' -d '{"kind":"recommendation", "lat":-25.765270, "lon":28.197000, "expires":"2013-06-02T12:34:56Z","description":"Lot of milk here for the rest of the weekend", "username":"anonymous"}'  $SERVER/hgt/_design/hgt/_update/tag/1
curl -i -X POST -H 'Content-Type: application/json' -d '{"kind":"recommendation", "lat":-25.765350, "lon":28.195000, "expires":"2013-06-02T12:34:56Z","description":"Milk almost done", "username":"anonymous"}'  $SERVER/hgt/_design/hgt/_update/tag/2
curl -i -X POST -H 'Content-Type: application/json' -d '{"kind":"recommendation", "lat":-25.766000, "lon":28.196940, "expires":"2013-06-02T12:34:56Z","description":"Milk almost done", "username":"anonymous"}'  $SERVER/hgt/_design/hgt/_update/tag/3


# ----------------------------------------------------------------- Users
curl -X GET $SERVER/hgt/_design/hgt/_view/users
curl -X GET $SERVER/hgt/123
curl -g -X GET "$SERVER/hgt/_design/hgt/_view/users?key=\"123\""


# ----------------------------------------------------------------- Tags
curl -X GET $SERVER/hgt/_design/hgt/_view/tags
curl -g -X GET $SERVER/hgt/_design/hgt/_view/tags?startkey=[-27,27]\&endkey=[-25,28]
curl -g -X GET $SERVER/hgt/_design/hgt/_view/tags?startkey=[-27,27]\&endkey=[-27,28]


curl -X POST -H "Content-Type: application/json" -d "{\"keys\":[\"123\",\"1234\"]}" $SERVER/hgt/_design/hgt/_view/friendtags

# ----------------------------------------------------------------- Timestamps
curl -X GET $SERVER/hgt/_design/hgt/_view/timestampuser
curl -g -X GET "$SERVER/hgt/_design/hgt/_view/timestampuser?startkey=\"2013-06-01\""
curl -g -X GET "$SERVER/hgt/_design/hgt/_view/timestampuser?startkey=\"2013-06-02\""





