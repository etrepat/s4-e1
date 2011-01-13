require 'rexml/document'

module Directions
  module Tools
    class HtmlToAnsi
      CODES = { :reset=>"\e[0m", :bold=>"\e[1m", :underline=>"\e[4m",
        :lgray=>"\e[0;37m", :gray=>"\e[1;30m", :red=>"\e[31m", :green=>"\e[32m",
        :yellow=>"\e[33m", :blue=>"\e[34m", :magenta=>"\e[35m", :cyan=>"\e[36m",
        :white=>"\e[37m" }

      def self.convert(input_string)
        return Directions::Tools::HtmlToAnsi.new.convert(input_string)
      end

      def initialize
        @output = ''
      end

      def convert(input_string)
        @output = ''
        doc = REXML::Document.new("<root>\n<figure>\n" + input_string + "\n</figure>\n</root>")
        root = doc.root
        root.elements.each do |element|
          parse_element(element)
        end

        return @output.strip
      end

      protected

      def parse_element(element)
        name = element.name.to_sym

        @output << replace_opening_tag(element)

        if element.has_text? && element.children.size < 2
          @output << element.text.strip.chomp
        end

        if element.has_elements?
          element.children.each do |child|
            if child.node_type.eql?(:element)
              parse_element(child)
            else
              @output << child.to_s.strip.chomp
            end
          end
        end

        @output << replace_end_tag(element)
      end

      def replace_opening_tag(tag)
        case tag.name.to_sym
          when :b
            " #{CODES[:bold]}"
          when :div
            "\n\t#{CODES[:yellow]}"
          else
            ''
        end
      end

      def replace_end_tag(tag)
        case tag.name.to_sym
          when :b
            "#{CODES[:reset]} "
          when :div
            CODES[:reset]
          else
            ''
        end
      end
    end
  end
end

