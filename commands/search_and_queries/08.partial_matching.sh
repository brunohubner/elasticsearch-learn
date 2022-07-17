# delete movies index
curl -H 'Content-Type: application/json' -XDELETE '127.0.0.1:9200/movies'

# set mappings
curl -H 'Content-Type: application/json' -XPUT '127.0.0.1:9200/movies' -d '{
  "mappings": {
    "properties": {
      "year": {
        "type": "text"
      }
    }
  }
}'

# insert movies
curl -H 'Content-Type: application/json' -XPUT '127.0.0.1:9200/_bulk?pretty' --data-binary @movies.json

# search partial prefix
curl -H 'Content-Type: application/json' -XGET '127.0.0.1:9200/movies/_search?pretty' -d '{
  "query": {
    "prefix": {
      "year": "201"
    }
  }
}'

# search partial wildcard
curl -H 'Content-Type: application/json' -XGET '127.0.0.1:9200/movies/_search?pretty' -d '{
  "query": {
    "wildcard": {
      "year": "1*"
    }
  }
}'