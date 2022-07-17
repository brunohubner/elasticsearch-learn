# download data
wget http://media.sundog-soft.com/es7/movies.json

# insert docs
curl -H 'Content-Type: application/json' -XPUT '127.0.0.1:9200/_bulk?pretty' --data-binary @movies.json

# search
curl -H 'Content-Type: application/json' -XGET '127.0.0.1:9200/movies/_search?pretty'

# download series data
wget http://media.sundog-soft.com/es7/series.json