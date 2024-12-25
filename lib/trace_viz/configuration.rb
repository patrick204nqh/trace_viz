# frozen_string_literal: true

require "trace_viz/logger"
require "trace_viz/config/validator"
require "trace_viz/config/copier"

module TraceViz
  class Configuration
    attr_reader :logger, :settings
    attr_reader(*Defaults.fetch_defaults.keys)

    def initialize
      @logger = Logger.new
      @validator = Config::Validator.new
      @settings = Defaults.fetch_defaults
      define_dynamic_accessors
    end

    def [](key)
      settings[key]
    end

    def update(group, values)
      raise ArgumentError, "Invalid configuration group: #{group}" unless settings.key?(group)

      @validator.validate(group, values)
      if settings[group].is_a?(Hash)
        settings[group].merge!(values)
      else
        settings[group] = values
      end
    end

    def reset_defaults
      @settings = Defaults.fetch_defaults
    end

    def dup
      Config::Copier.new(self).copy
    end

    private

    def define_dynamic_accessors
      settings.each_key do |attr|
        define_singleton_method(attr) { settings[attr] }
        define_singleton_method("#{attr}=") do |value|
          update(attr, value)
        end
      end
    end
  end

  class << self
    def configuration
      @configuration ||= Configuration.new
    end

    def configure
      yield(configuration) if block_given?
    end

    def logger
      configuration.logger
    end
  end
end
