module Directions
  module Tools
    extend self

    ANSI_CODES = { :reset=>"\e[0m", :bold=>"\e[1m", :underline=>"\e[4m",
      :lgray=>"\e[0;37m", :gray=>"\e[1;30m", :red=>"\e[31m", :green=>"\e[32m",
      :yellow=>"\e[33m", :blue=>"\e[34m", :magenta=>"\e[35m", :cyan=>"\e[36m",
      :white=>"\e[37m" }
      
    NICE_DEFAULTS = {
      :b => ANSI_CODES[:bold] ,
      :div => "\n\t#{ANSI_CODES[:yellow]}"
    }
    
    def ansify_html(html_input, replacements={})
      ansi_output = html_input
      
      # perform *really* simple tag replacements
      replacements.each do |tag, replacement|
        ansi_output.gsub!(/<#{tag}([^>])*>/, replacement)
        ansi_output.gsub!(/<\/\s*#{tag}>/, ANSI_CODES[:reset])
      end
      
      # finally strip un-replaced html tags, spaces and eol chars
      ansi_output.gsub(/<\/?([^>])*>/, "").chomp.strip
    end
    
    def instructions_to_ansi(html_input)
      ansify_html(html_input, NICE_DEFAULTS)
    end
  end
end

