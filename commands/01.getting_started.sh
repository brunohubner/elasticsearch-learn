wget http://media.sundog-soft.com/es7/shakes-mapping.json

curl -H 'Content-Type: application/json' -XPUT '127.0.0.1:9200/shakespeare' --data-binary @shakes-mapping.json

wget http://media.sundog-soft.com/es7/shakespeare_7.0.json

curl -H 'Content-Type: application/json' -XPOST '127.0.0.1:9200/shakespeare/_bulk?pretty' --data-binary @shakespeare_7.0.json

curl -H 'Content-Type: application/json' -XGET '127.0.0.1:9200/shakespeare/_search?pretty' -d '{
  "query": {
    "match_phrase": {
      "text_entry": "to be or not to be"
    }
  }
}'