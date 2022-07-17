# search with filter
curl -H 'Content-Type: application/json' -XGET '127.0.0.1:9200/movies/_search?pretty' -d '{
  "query": {
    "bool": {
      "must": {
        "match": {
          "genre": "Sci-Fi"
        }
      },
      "must_not": {
        "match": {
          "title": "trek"
        }
      },
      "filter": {
        "range": {
          "year": {
            "gte": 2010,
            "lt": 2015
          }
        }
      }
    }
  }
}'

# search with filter
curl -H 'Content-Type: application/json' -XGET '127.0.0.1:9200/movies/_search?pretty' -d '{
  "query": {
    "bool": {
      "must": {
        "match": {
          "genre": "Sci-Fi"
        }
      },
      "filter": {
        "range": {
          "year": {
            "lt": 1960
          }
        }
      }
    }
  },
  "sort": "title.raw"
}'