# frozen_string_literal: true

# Provides access to the Environment Config
#----------------------------------------------------------
# Author:     Danny Smith (dsmith@testingcircle.com)
# Modified    2016-07-01
#
# Usage:
#
# EnvConfig.environment         Returns the current config environment, eg. "ci".
# EnvConfig.config              Returns the whole config hash.
# EnvConfig.data                Returns the test data loaded from support/data/* as a hash. Equivalent to EnvConfig['data'].
# EnvConfig['some_key']         Return the value of the key 'some_key' from the current config in config.yml
# EnvConfig.some.key.or.other   Returns the specified data. Is equivalent to EnvConfig['some']['key']['or']['other']
#
#----------------------------------------------------------

require 'singleton'
require 'yaml'

class EnvConfig
  include Singleton
  attr_reader :config, :environment

  def initialize
    config_file = load_config_yaml

    load_environment config_file

    load_test_data

    # The environment-specific config and the test data are accessible as @config
    @config = config_file[@environment]
    @config['data'] = @test_data
  end

  # Allow class like EnvConfig['some_key']
  def self.[](key_name)
    instance.value_for(key_name)
  end

  # Allow calls like EnvConfig.some_key
  def self.method_missing(name, *args, &block)
    instance.config[name.to_s].nil? ? super : instance.config[name.to_s]
  end

  def self.respond_to_missing?(method_name, include_private = false)
    instance.config[name.to_s].nil? ? super : true
  end

  # Allow calls like EnvConfig.some_key
  def self.respond_to?(name)
    instance.config[name.to_s].nil? ? super : true
  end

  def value_for(key_name)
    raise "There is no key '#{key_name}' for the config ' #{@environment}' in config.yml" if @config[key_name].nil?
    @config[key_name]
  end

  private
  
    def load_environment(config_file)
      # Get the current config setting from the environment. It should be passed in from the command line eg. CONFIG=ci (see rakefile)
      # It will use default_config from config.yaml if nothing is passed in.
      @environment = ENV['CONFIG']

      if @environment.nil?
        @environment = config_file.fetch('defaults').fetch('default_config') # .fetch() will raise an error if the keys aren't found.
        if @environment.nil?
          abort "Exiting: No CONFIG supplied from command line, and no default_config found in config.yml"
        end
      end
    end

    def load_test_data
      # Load in data files from /features/support/data/*
      @test_data = {}

      puts 'Loading test data YAML from data directory...'
      dir = Dir[File.dirname(__FILE__) + '/../features/support/data/*.yml']
      dir.each do |f|
        data = YAML.safe_load(File.open(f))
        @test_data.merge!(data)
        puts "Loaded #{f}"
      end
    end

    def load_config_yaml
      config_yaml = File.join(Dir.pwd, 'config.yml')
      unless File.exist? config_yaml
        raise 'Oooops. config.yml could not be found'
      end
      YAML.safe_load(File.open(config_yaml))
    end
end
