# search all
curl -H 'Content-Type: application/json' -XGET '127.0.0.1:9200/movies/_search?pretty'

# search paginated
curl -H 'Content-Type: application/json' -XGET '127.0.0.1:9200/movies/_search?pretty' -d '{
  "from": 0,
  "size": 2,
  "query": {
    "genre": "Sci-Fi"
  }
}'