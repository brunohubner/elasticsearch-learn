# CREATE
curl -H 'Content-Type: application/json' -XPUT '127.0.0.1:9200/movies/_doc/200000?pretty' -d '{
  "genre": ["Commedy"],
  "title": "A Night at Roxbury",
  "year": 1998
}'

# READ
curl -H 'Content-Type: application/json' -XGET '127.0.0.1:9200/movies/_doc/200000?pretty'

# UPDATE
curl -H 'Content-Type: application/json' -XPOST '127.0.0.1:9200/movies/_doc/200000/_update?pretty' -d '{
  "doc": {
    "genres": ["Commedy", "Documentary"]
  }
}'

# DELETE
curl -H 'Content-Type: application/json' -XDELETE '127.0.0.1:9200/movies/_doc/200000?pretty'
