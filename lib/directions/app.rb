module Directions
  class App
    def initialize(arguments, defaults={})
      @arguments = arguments
      @options = {}.merge!(defaults)
    end

    attr_reader :options

    def run
      if parsed_options? && options_valid?

        # ...
        r = Directions::Api.request( options )

        steps = r['routes'][0]['legs'][0]['steps']
        steps.each_with_index do |step, index|
          puts "#{index+1}. #{step['html_instructions'].gsub(/<\/?[^>]*>/, '')}"
        end

      else
        output_usage
      end
    end

    protected

    MANDATORY_OPTIONS = [:origin, :destination]

    def parsed_options?
      @options_parser ||= OptionParser.new do |opts|
        opts.banner = <<BANNER
RMU S4E1: Google Directions API - CLI
by Estanislau Trepat

Usage:
  directions -o [ORIGIN] -d [DESTINATION] [options]

Examples:

  directions -o ""
  directions -o Toledo -d Madrid -r es

Options are:
BANNER

        opts.separator ''

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
          @options[:mode] = mode.strip
        end

        opts.on('-a', '--avoid=VALUE', String, [:tolls, :highways],
          'Features to avoid (tolls, highways)') do |avoid|
          @options[:avoid] = avoid.strip
        end

        opts.on('-u', '--units=SYSTEM', String, [:metric, :imperial],
          'Force unit system for output (metric, imperial)') do |units|
          @options[:units] = units.strip
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
      @options_parser.parse!(@arguments) rescue return nil
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

