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

    {"timestamp":"2011-08-26T06:59:06.908Z","message":"l1"}
    {"timestamp":"2011-08-26T06:59:06.909Z","message":"l2","foo":"bar"}
    {"timestamp":"2011-08-26T06:59:06.910Z","message":"l3","bar":"baz","foo":"bar"}
    {"timestamp":"2011-08-26T06:59:06.910Z","message":"Some funky errors, man","exception":{"stack":"Error: Woo\n    at Object.<anonymous> (/home/jls/projects/nodejs-logging/build/lib/logging.js:60:11)\n    at Object.<anonymous> (/home/jls/projects/nodejs-logging/build/lib/logging.js:66:4)\n    at Module._compile (module.js:407:26)\n    at Object..js (module.js:413:10)\n    at Module.load (module.js:339:31)\n    at Function._load (module.js:298:12)\n    at Array.0 (module.js:426:10)\n    at EventEmitter._tickCallback (node.js:126:26)","message":"Woo"},"bar":"baz","foo":"bar"}

