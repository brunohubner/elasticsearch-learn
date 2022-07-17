curl -H 'Content-Type: application/json' -XGET '127.0.0.1:9200/movies/_search?pretty' -d '{
  "query": {
    "bool": {
      "must": {
        "match_phrase": {
          "title": "Star Wars"
        }
      },
      "filter": {
        "range": {
          "year": {
            "gte": 1980
          }
        }
      }
    }
  }
}'