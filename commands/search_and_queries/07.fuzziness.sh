# search with incorrect word
curl -H 'Content-Type: application/json' -XGET '127.0.0.1:9200/movies/_search?pretty' -d '{
  "query": {
    "fuzzy": {
      "title": {
        "value": "intxersteller",
        "fuzziness": "AUTO"
      }
    }
  }
}'