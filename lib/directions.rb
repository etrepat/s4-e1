require 'optparse'
require 'ostruct'
require 'pp'
require 'rexml/document'
require 'rubygems'
require 'bundler/setup'
Bundler.require

require 'httparty'

module Directions
end

require 'directions/tools.rb'
require 'directions/error.rb'
require 'directions/location.rb'
require 'directions/measure.rb'
require 'directions/step.rb'
require 'directions/leg.rb'
require 'directions/route.rb'
require 'directions/tour_guide.rb'
require 'directions/api.rb'
require 'directions/app.rb'

