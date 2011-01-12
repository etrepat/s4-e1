module Directions
  class App
    def initialize(arguments, stdin, defaults={})
      @arguments = arguments
      @stdin = stdin

      @options = {}.merge!(defaults)
    end

    attr_reader :options

    def run
      if parsed_options? && arguments_valid?
        # Main
      else
        output_usage
      end
    end

    protected

      def parsed_options?
        @options_parser ||= OptionParser.new do |opts|
          opts.banner = %(
Google Directions API - CLI

Usage:
  directions -o [ORIGIN] -d [DESTINATION] [options]

Examples:

  directions -o "Madrid, Spain" -d "Barcelona, Spain"
  ... add more usage examples ...

Options:
)

          opts.on('-o', '--origin [LOCATION]', String, 'Origin location') do |orig|
            @options[:origin] = orig.strip.chomp('"')
          end

          opts.on('-d', '--destination [LOCATION]', String, 'Destination location') do |dest|
            @options[:destination] = dest.strip.chomp('"')
          end

          opts.on('-h', '--help', 'Show this message') do
            puts opts
            exit
          end
        end
        @options_parser.parse!(@arguments) rescue return nil
      end

      def arguments_valid?
        # TODO: Check for required options...
        false
      end

      def output_usage
        puts @options_parser
      end

      def required_options

      end
  end
end

