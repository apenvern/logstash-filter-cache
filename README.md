# Logstash Filter Cache

This filter provide a cache where you can store data. This cache isn't here to store lots of elements or large elements.

## Installation
```sh
bin/plugin install logstash-filter-cache
```

## Usage

Put data in cache
```javascript
   filter {
     cache {
       key => "keyTest"
       value => "TEST"
     }
   }
```

Get data from cache and put in a field
```javascript
   filter {
     cache {
       key => "keyTest"
       get => true
       field => "data_in_cache"
     }
   }
```

## Example

```sh

bin/logstash -e 'input { stdin {} } filter { cache { key => "keyTest" value => "TEST" } cache { key => "keyTest" get => true field => "data_in_cache" } } output {stdout { codec => rubydebug }}'
Logstash startup completed
Test
{
          "message" => "Test",
         "@version" => "1",
       "@timestamp" => "2015-11-19T22:01:04.191Z",
    "data_in_cache" => "TEST"
}

```
