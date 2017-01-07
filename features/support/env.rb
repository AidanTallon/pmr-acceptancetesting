require 'watir'
require 'yaml'
require 'pry'
require 'time'

Dir[File.join(File.dirname(__FILE__), '/../../lib/*.rb')].each { |f| require f }

require File.join(File.dirname(__FILE__), '/pages/generic.rb')
Dir[File.join(File.dirname(__FILE__), '/pages/*.rb')].each { |f| require f }
