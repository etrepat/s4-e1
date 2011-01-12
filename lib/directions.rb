require 'optparse'
require 'ostruct'
require 'pp'
require 'rubygems'
require 'bundler/setup'
Bundler.require

require 'httparty'

module Directions
end

require 'directions/app.rb'
require 'directions/api.rb'