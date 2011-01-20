module Directions
  Error                   = Class.new(StandardError)
  ParsingError            = Class.new(Error)
  InvalidRequestError     = Class.new(Error)
  RequestDenied           = Class.new(Error)
  LocationNotFoundError   = Class.new(Error)
  ZeroResultsError        = Class.new(Error)
  WaypointsExceededError  = Class.new(Error)
  QueryLimitError         = Class.new(Error)
  UnknownError            = Class.new(Error)
end

