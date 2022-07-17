# search skiping words with 'slop'
curl -H 'Content-Type: application/json' -XGET '127.0.0.1:9200/movies/_search?pretty' -d '{
  "query": {
    "match_phrase": {
      "title": {
        "query": "star beyond",
        "slop": 1
      }
    }
  }
}'