require 'optparse'
require 'ostruct'
require 'pp'
require 'rubygems'
require 'bundler/setup'
Bundler.require

require 'httparty'

require File.dirname(__FILE__) + '/directions/app.rb'
require File.dirname(__FILE__) + '/directions/api.rb'

module Directions
  def self.get(arguments)
    Directions::App.new(arguments).run
  end
end

