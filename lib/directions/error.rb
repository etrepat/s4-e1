module Directions
  class Error < ::StandardError;        end
  class ParsingError < Error;           end
  class InvalidRequestError < Error;    end
  class RequestDenied < Error;          end
  class LocationNotFoundError < Error;  end
  class ZeroResultsError < Error;       end
  class WaypointsExceededError < Error; end
  class QueryLimitError < Error;        end
  class UnknownError < Error;           end
end

