# create and mapping index
curl -H 'Content-Type: application/json' -XPUT 'http://localhost:9200/microservice-logs' \
-d '{
   "mappings": {
       "properties": {
           "timestamp": { "type": "date"  },
           "service": { "type": "keyword" },
           "host_ip": { "type": "ip" },
           "port": { "type": "integer" },
           "message": { "type": "text" }
       }
   }
}'

# data example
{"timestamp": "2020-04-11T12:34:56.789Z", "service": "ABC", "host_ip": "10.0.2.15", "port": 12345, "message": "Started!" }
 
# insert
curl -H 'Content-Type: application/json' -XPOST 'http://localhost:9200/microservice-logs/_doc?pretty' \
-d '{"timestamp": "2020-04-11T12:34:56.789Z", "service": "XYZ", "host_ip": "10.0.2.15", "port": "15000", "message": "Hello!" }'

# insert data with incorret type - expected error
curl -H 'Content-Type: application/json' -XPOST 'http://localhost:9200/microservice-logs/_doc?pretty' \
-d '{"timestamp": "2020-04-11T12:34:56.789Z", "service": "XYZ", "host_ip": "10.0.2.15", "port": "NONE", "message": "I am not well!" }'

# closing index
curl -H 'Content-Type: application/json' -XPOST 'http://localhost:9200/microservice-logs/_close'

# updating index mapping to skip type check
curl -H 'Content-Type: application/json' --location -XPUT 'http://localhost:9200/microservice-logs/_settings' \
-d '{
   "index.mapping.ignore_malformed": true
}'

# re-open index
curl -H 'Content-Type: application/json' -XPOST 'http://localhost:9200/microservice-logs/_open'
 
# insert data with incorret type - expected success
curl -H 'Content-Type: application/json' -XPOST 'http://localhost:9200/microservice-logs/_doc?pretty' \
-d '{"timestamp": "2020-04-11T12:34:56.789Z", "service": "XYZ", "host_ip": "10.0.2.15", "port": "NONE", "message": "I am not well!" }'
 
# insert data with incorret type - expected error
curl -H 'Content-Type: application/json' -XPOST 'http://localhost:9200/microservice-logs/_doc?pretty' \
-d '{"timestamp": "2020-04-11T12:34:56.789Z", "service": "ABC", "host_ip": "10.0.2.15", "port": 12345, "message": {"data": {"received":"here"}}}'
 
# insert
curl -H 'Content-Type: application/json' -XPOST 'http://localhost:9200/microservice-logs/_doc?pretty' \
-d '{"timestamp": "2020-04-11T12:34:56.789Z", "service": "ABC", "host_ip": "10.0.2.15", "port": 12345, "message": "Received...", "payload": {"data": {"received":"here"}}}'
 
# view mappings
curl -H 'Content-Type: application/json' -XGET  'http://localhost:9200/microservice-logs/_mappings?pretty'
 
# insert more 
curl -H 'Content-Type: application/json' -XPOST 'http://localhost:9200/microservice-logs/_doc?pretty' \
-d '{"timestamp": "2020-04-11T12:34:56.789Z", "service": "ABC", "host_ip": "10.0.2.15", "port": 12345, "message": "Received...", "payload": {"data": {"received": {"even": "more"}}}}'
 
# app to crete json files
sudo apt-get install jq
 
# create json with 1001 lines
thousandone_fields_json=$(echo {1..1001..1} | jq -Rn '( input | split(" ") ) as $nums | $nums[] | . as $key | [{key:($key|tostring),value:($key|tonumber)}] | from_entries' | jq -cs 'add')

# view file
echo "$thousandone_fields_json"

# create index
curl -H 'Content-Type: application/json' --location -XPUT  'http://localhost:9200/big-objects'

# insert big file with many fiels
curl -H 'Content-Type: application/json' -XPOST  'http://localhost:9200/big-objects/_doc?pretty' \
-d "$thousandone_fields_json"
 
# set mappings filds limit
curl -H 'Content-Type: application/json' --location -XPUT  'http://localhost:9200/big-objects/_settings' \
-d '{
"index.mapping.total_fields.limit": 1001
}'