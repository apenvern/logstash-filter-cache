# Logstash Filter Cache

This filter provide a cache where you can store data.

## Installation
```sh
bin/plugin install logstash-filter-cache
```

## Usage

```javascript

```

## Example

```sh
bin/logstash -e 'input { stdin {} } filter { sequence { field => "sequence" } } output {stdout { codec => rubydebug }}' -w 1
Default settings used: Filter workers: 1
Logstash startup completed

```