require 'rubygems'
require 'bundler/setup'
Bundler.require

require_relative 'models/robot.rb'
require_relative 'models/nil_class.rb'
Robot.start
