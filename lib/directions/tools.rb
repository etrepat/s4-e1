module Directions
  module Tools
    extend self

    ANSI_CODES = { :reset=>"\e[0m", :bold=>"\e[1m", :underline=>"\e[4m",
      :lgray=>"\e[0;37m", :gray=>"\e[1;30m", :red=>"\e[31m", :green=>"\e[32m",
      :yellow=>"\e[33m", :blue=>"\e[34m", :magenta=>"\e[35m", :cyan=>"\e[36m",
      :white=>"\e[37m" }

    def tag_replace(html_input, replacements={})

    end

    def strip_tags(html_input)
      html_input.gsub(/<\/?([^>])*>/, "").strip.chomp
    end
  end
end

