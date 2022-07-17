# update all doc
curl -H 'Content-Type: application/json' -XPOST '127.0.0.1:9200/movies/_doc/109487' -d '{
  "genre": [
    "IMAX",
    "Sci-Fi"
  ],
  "title": "Interestellar - UPDATED",
  "year": 2014
}'

# search
curl -H 'Content-Type: application/json' -XGET '127.0.0.1:9200/movies/_doc/109487?pretty'

# update one field
curl -H 'Content-Type: application/json' -XPOST '127.0.0.1:9200/movies/_doc/109487/_update' -d '{
  "doc": {
    "title": "Interestellar"
  }
}'