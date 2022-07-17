# search while typing
curl -H 'Content-Type: application/json' -XGET '127.0.0.1:9200/movies/_search?pretty' -d '{
  "query": {
    "match_phrase_prefix": {
      "title": {
        "query": "starr tr",
        "slop": 10,
        "fuzziness": "AUTO"
      }
    }
  }
}'