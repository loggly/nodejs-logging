class Logger
  @levels =
    fatal: 0
    error: 1
    warn: 2
    info: 3

  constructor: (settings) ->
    # TODO(sissel): Verify data in settings
    @settings = settings
    @data = {}
  # end constructor

  timestamp: () -> new Date()

  hashmerge: (target, source) ->
    for k, v of source
      target[k] = v
  # end hashmerge
  
  log: (level, message, context) ->
    return if Logger.levels[level] > @level

    event = {
      timestamp: @timestamp().toISOString(),
      message: message
    }
    
    # TODO(sissel): Include stack by default?

    @hashmerge(event, @data)

    console.log(JSON.stringify(event))
  # end log
  
  # Create a copy of this logger with some additional context.
  #
  # Args:
  #   data: should be an object or hash containing context to add.
  #
  # Returns:
  #   A new logger cloned from the current logger but with the 
  #   data added.
  context: (data) ->
    contextlogger = new Logger()

    @hashmerge(contextlogger, this)

    # merge previous context + new data
    contextlogger.data = data
    @hashmerge(contextlogger.data, @data)

    return contextlogger
  # end context
# class Logger

l1 = new Logger()
l1.level = 4
l2 = l1.context(foo: "bar")
l3 = l2.context(bar: "baz")
l1.log("info", "l1")
l2.log("info", "l2")
l3.log("info", "l3")

try
  throw new Error("Woo")
catch error
  l3.context(exception: error).log("error", "Some funky errors, man")
