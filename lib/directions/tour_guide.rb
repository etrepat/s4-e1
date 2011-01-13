module Directions
  class TourGuide
    def initialize(options)
      @options = options
      @routes = []
      @last_response = nil
    end

    attr_reader :options, :routes

    def ask_directions
      q = build_query_params
      @last_response = Directions::Api.new.get_directions(q)
      parse_response if response_valid?
    end

    def main_route
      nil if routes.empty?
      routes.first
    end

    protected

    attr_reader :last_response

    def build_query_params
      query_params = {}
      query_params[:origin] = options[:origin]
      query_params[:destination] = options[:destination]
      query_params[:mode] = options[:mode] if options[:mode]
      query_params[:avoid] = options[:avoid] if options[:avoid]
      query_params[:units] = options[:units] if options[:avoid]
      query_params[:region] = options[:region] if options[:region]
      query_params[:language] = options[:language] if options[:language]

      query_params
    end

    def response_valid?
      raise Directions::ParsingError if last_response.nil?
      raise Directions::ParsingError unless last_response['status']

      status = last_response['status'].strip.upcase
      return true if status == 'OK'

      case status
        when 'NOT_FOUND'; raise Directions::LocationNotFoundError
        when 'ZERO_RESULTS'; raise Directions::ZeroResultsError
        when 'MAX_WAYPOINTS_EXCEEDED'; raise Directions::WaypointsExceededError
        when 'INVALID_REQUEST'; raise Directions::InvalidRequestError
        when 'OVER_QUERY_LIMIT'; raise Directions::QueryLimitError
        when 'REQUEST_DENIED'; raise Directions::RequestDenied
        else raise Directions::UnknownError
      end
    end

    def parse_response
      last_response['routes'].each do |route|
        @routes << Directions::Route.build_from_api_data(route)
      end
    end
  end
end

