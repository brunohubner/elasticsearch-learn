# delete movies index
curl -H 'Content-Type: application/json' -XDELETE '127.0.0.1:9200/movies'

# set mappings
curl -H 'Content-Type: application/json' -XPUT '127.0.0.1:9200/movies' -d '{
  "mappings": {
    "properties": {
      "title": {
        "type": "text",
        "fields": {
          "raw": {
            "type": "keyword"
          }
        }
      }
    }
  }
}'

# view mappings
curl -H 'Content-Type: application/json' -XGET '127.0.0.1:9200/movies/_mappings?pretty'

# insert movies
curl -H 'Content-Type: application/json' -XPUT '127.0.0.1:9200/_bulk?pretty' --data-binary @movies.json

# sort searching
curl -H 'Content-Type: application/json' -XGET '127.0.0.1:9200/movies/_search?pretty' -d '{
  "sort": "title.raw"
}'