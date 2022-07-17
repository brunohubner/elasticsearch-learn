# search
curl -H 'Content-Type: application/json' -XGET '127.0.0.1:9200/movies/_search?pretty' -d '{
  "query": {
    "match": {
      "title": "Star Trek"
    }
  }
}'

# search
curl -H 'Content-Type: application/json' -XGET '127.0.0.1:9200/movies/_search?pretty' -d '{
  "query": {
    "match_phrase": {
      "genre": "sci"
    }
  }
}'

# delete index
curl -H 'Content-Type: application/json' -XDELETE '127.0.0.1:9200/movies'

# recreating index
curl -H 'Content-Type: application/json' -XPUT '127.0.0.1:9200/movies' -d '{
  "mappings": {
    "properties": {
      "id": {
        "type": "integer"
      },
      "year": {
        "type": "date"
      },
      "genre": {
        "type": "keyword"
      },
      "title": {
        "type": "text",
        "analyzer": "english"
      }
    }
  }
}'

# reindexing
curl -H 'Content-Type: application/json' -XPUT '127.0.0.1:9200/_bulk?pretty' --data-binary @movies.json

# "type": "text", -> partial match
# "type": "keyword" -> exact match