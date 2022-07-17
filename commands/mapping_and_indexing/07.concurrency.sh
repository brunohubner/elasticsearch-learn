# search
curl -H 'Content-Type: application/json' -XGET '127.0.0.1:9200/movies/_doc/109487?pretty'

# update with concurrency
curl -H 'Content-Type: application/json' -XPUT '127.0.0.1:9200/movies/_doc/109487?if_seq_no=10&if_primary_term=1&pretty' -d '{
  "genre": [
    "IMAX",
    "Sci-Fi"
  ],
  "title": "Interestellar - UPDATED",
  "year": 2014
}'

# update retry conflicts
curl -H 'Content-Type: application/json' -XPOST '127.0.0.1:9200/movies/_doc/109487/_update?retry_on_conflict=5&pretty' -d '{
  "doc": {
    "title": "Interestellar typo"
  }
}'

# search
curl -H 'Content-Type: application/json' -XGET '127.0.0.1:9200/movies/_doc/109487?pretty'