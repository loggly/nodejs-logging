# Logging, yo.

Logging kind of sucks.

* Log metrics (record latencies, counts, rates, etc) 
* Log structured data 
* Should be context aware (Log a message + context)
* Allow writing to multiple targets (files, syslog, etc) 
* Support log levels 
* Support profiling (random sampling of requests) 
* Should be tunable at runtime 

Sample output

    {"timestamp":"2011-08-26T06:49:06.872Z","message":"l1"}
    {"timestamp":"2011-08-26T06:49:06.874Z","message":"l2","foo":"bar"}
    {"timestamp":"2011-08-26T06:49:06.875Z","message":"l3","bar":"baz","foo":"bar"}

