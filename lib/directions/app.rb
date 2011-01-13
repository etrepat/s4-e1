module Directions
  class App
    def initialize(arguments, defaults={})
      @arguments = arguments
      @options = {}.merge!(defaults)
    end

    attr_reader :options

    def run
      if parsed_options? && options_valid?
        begin
          tour_guide.ask_directions
          puts tour_guide.main_route.describe
        rescue Directions::ParsingError => e
          puts "ERROR: A parsing error occurred. Bad response."
        rescue Directions::InvalidRequestError => e
          puts "ERROR: Invalid request."
        rescue Directions::RequestDenied => e
          puts "ERROR: Request denied."
        rescue Directions::LocationNotFoundError => e
          puts "ERROR: Some of the locations could not be geocoded."
        rescue Directions::ZeroResultsError => e
          puts "ERROR: No route could be found between origin and destination."
        rescue Directions::WaypointsExceededError => e
          puts "ERROR: Too many waypoints."
        rescue Directions::QueryLimitError => e
          puts "ERROR: Too many requests."
        rescue Directions::Error => e
          puts "Unknown error. #{e}"
        rescue Exception => e
          puts "An unexpected excetion ocurred!\n#{e.message}"
        end
      else
        output_usage
      end
    end

    def tour_guide
      @tour_guide ||= Directions::TourGuide.new(options)
    end

    protected

    MANDATORY_OPTIONS = [:origin, :destination]

    def parsed_options?
      @options_parser ||= OptionParser.new do |opts|
        opts.banner = <<BANNER
Usage:
  directions -o [ORIGIN] -d [DESTINATION] [options]

Options are:
BANNER

        opts.on('-o', '--origin=LOCATION', String,
          'Origin location (required)') do |orig|
          @options[:origin] = orig.strip.chomp('"')
        end

        opts.on('-d', '--destination=LOCATION', String,
          'Destination location (required)') do |dest|
          @options[:destination] = dest.strip.chomp('"')
        end

        opts.separator ''

        opts.on('-m', '--mode=MODE', String, [:driving, :walking, :bicycling],
          'Travel mode (driving, walking, bicycling)') do |mode|
          @options[:mode] = mode.to_s.strip
        end

        opts.on('-a', '--avoid=VALUE', String, [:tolls, :highways],
          'Features to avoid (tolls, highways)') do |avoid|
          @options[:avoid] = avoid.to_s.strip
        end

        opts.on('-u', '--units=SYSTEM', String, [:metric, :imperial],
          'Force unit system for output (metric, imperial)') do |units|
          @options[:units] = units.to_s.strip
        end

        opts.on('-r', '--region=REGION', String,
          'Set region bias as ccTLD') do |region|
          @options[:region] = region.strip
        end

        # Supported Maps API language codes:
        # http://spreadsheets.google.com/pub?key=p9pdwsai2hDMsLkXsoM05KQ&gid=1
        opts.on('-l', '--language=LANGUAGE', String,
          'Get results on the specified language') do |lang|
          @options[:language] = lang
        end

        opts.separator ''

        opts.on('-h', '--help', 'Show this message') do
          puts opts
          exit
        end

        opts.separator ''
      end

      begin
        @options_parser.parse!(@arguments)
      rescue OptionParser::ParseError => e
        @options_parser.warn e.message
        nil
      end
    end

    # check if mandatory arguments are present
    def options_valid?
      missing = MANDATORY_OPTIONS.select { |arg| @options[arg].nil? }
      missing.empty?
    end

    def output_usage
      puts @options_parser
    end
  end
end

