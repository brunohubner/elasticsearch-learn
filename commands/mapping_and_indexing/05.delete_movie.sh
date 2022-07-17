# search
curl -H 'Content-Type: application/json' -XGET '127.0.0.1:9200/movies/_search?q=Dark&pretty'

# delete doc
curl -H 'Content-Type: application/json' -XDELETE '127.0.0.1:9200/movies/_doc/58559?&pretty'