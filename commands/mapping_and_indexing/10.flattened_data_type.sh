
# create
curl -H 'Content-Type: application/json' -XPUT "http://127.0.0.1:9200/demo-default/_doc/1" -d'{
  "message": "[5592:1:0309/123054.737712:ERROR:child_process_sandbox_support_impl_linux.cc(79)] FontService unique font name matching request did not receive a response.",
  "fileset": {
    "name": "syslog"
  },
  "process": {
    "name": "org.gnome.Shell.desktop",
    "pid": 3383
  },
  "@timestamp": "2020-03-09T18:00:54.000+05:30",
  "host": {
    "hostname": "bionic",
    "name": "bionic"
  }
}'
 
# view mappings 
curl -H 'Content-Type: application/json' -XGET "http://127.0.0.1:9200/demo-default/_mapping?pretty=true"
 
# get cluster state
curl -H 'Content-Type: application/json' -XGET "http://127.0.0.1:9200/_cluster/state?pretty=true" >> es-cluster-state.json
 
# create index 
curl -H 'Content-Type: application/json' -XPUT "http://127.0.0.1:9200/demo-flattened"
 
# set flattened index
curl -H 'Content-Type: application/json' -XPUT "http://127.0.0.1:9200/demo-flattened/_mapping" -d'{
  "properties": {
    "host": {
      "type": "flattened"
    }
  }
}'
 
# indexing doc 
curl -H 'Content-Type: application/json' -XPUT "http://127.0.0.1:9200/demo-flattened/_doc/1" -d'{
  "message": "[5592:1:0309/123054.737712:ERROR:child_process_sandbox_support_impl_linux.cc(79)] FontService unique font name matching request did not receive a response.",
  "fileset": {
    "name": "syslog"
  },
  "process": {
    "name": "org.gnome.Shell.desktop",
    "pid": 3383
  },
  "@timestamp": "2020-03-09T18:00:54.000+05:30",
  "host": {
    "hostname": "bionic",
    "name": "bionic"
  }
}'
 
# view mappings 
curl -H 'Content-Type: application/json' -XGET "http://127.0.0.1:9200/demo-flattened/_mapping?pretty=true"
 
# add more fields
curl -H 'Content-Type: application/json' -XPOST "http://127.0.0.1:9200/demo-flattened/_update/1" -d'{
  "doc": {
    "host": {
      "osVersion": "Bionic Beaver",
      "osArchitecture": "x86_64"
    }
  }
}'
 
# search
curl -H 'Content-Type: application/json' -XGET "http://127.0.0.1:9200/demo-flattened/_search?pretty=true" -d'{
  "query": {
    "term": {
      "host": "Bionic Beaver"
    }
  }
}'
 
# search
curl -H 'Content-Type: application/json' -XGET "http://127.0.0.1:9200/demo-flattened/_search?pretty=true" -d'{
  "query": {
    "term": {
      "host.osVersion": "Bionic Beaver"
    }
  }
}'
 
# search
curl -H 'Content-Type: application/json' -XGET "http://127.0.0.1:9200/demo-flattened/_search?pretty=true" -d'{
  "query": {
    "term": {
      "host.osVersion": "Beaver"
    }
  }
}'