# create index
curl -H 'Content-Type: application/json' -XPUT '127.0.0.1:9200/movies' -d '{
  "mappings": {
    "properties": {
      "year": {
        "type": "date"
      }
    }
  }
}'

# viewing schemas
curl -H 'Content-Type: application/json' -XGET '127.0.0.1:9200/movies/_mapping'

# update doc
curl -H 'Content-Type: application/json' -XPOST '127.0.0.1:9200/movies/_doc/109487' -d '{
  "genre": [
    "IMAX",
    "Sci-Fi"
  ],
  "title": "Interestekllar",
  "year": 2014
}'

# search
curl -H 'Content-Type: application/json' -XGET '127.0.0.1:9200/movies/_search?pretty'