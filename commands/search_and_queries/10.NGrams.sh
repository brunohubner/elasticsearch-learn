# delete index
curl -H 'Content-Type: application/json' -XDELETE 127.0.0.1:9200/movies

# recreting index with custom analizer
curl -H 'Content-Type: application/json' -XPUT '127.0.0.1:9200/movies?pretty' -d '{
  "settings": {
    "analysis": {
      "filter": {
        "autocomplete_filter": {
          "type": "edge_ngram",
          "min_gram": 1,
          "max_gram": 20
        }
      },
      "analyzer": {
        "autocomplete": {
          "type": "custom",
          "tokenizer": "standard",
          "filter": [
            "lowercase",
            "autocomplete_filter"
          ]
        }
      }
    }
  }
}'

# testing analyzer
curl -H 'Content-Type: application/json' -XGET '127.0.0.1:9200/movies/_analyze?pretty' -d '{
  "analyzer": "autocomplete",
  "text": "sta"
}'

# remapping title field to suport auto complete
curl -H 'Content-Type: application/json' -XPUT '127.0.0.1:9200/movies/_mapping?pretty' -d '{
  "properties": {
    "title": {
      "type": "text",
      "analyzer": "autocomplete"
    }
  }
}'

# reindexing movies
curl -H 'Content-Type: application/json' -XPUT 127.0.0.1:9200/_bulk --data-binary @movies.json

# search with analizer 'autocomplete'
curl -H 'Content-Type: application/json' -XGET '127.0.0.1:9200/movies/_search?pretty' -d '{
  "query": {
    "match": {
      "title": "sta"
    }
  }
}'

# search with analizer 'standard'
curl -H 'Content-Type: application/json' -XGET '127.0.0.1:9200/movies/_search?pretty' -d '{
  "query": {
    "match": {
      "title": {
        "query": "sta",
        "analyzer": "standard"
      }
    }
  }
}'

# search with analizer 'standard'
curl -H 'Content-Type: application/json' -XGET '127.0.0.1:9200/movies/_search?pretty' -d '{
  "query": {
    "match": {
      "title": {
        "query": "star tr",
        "analyzer": "standard"
      }
    }
  }
}'