# frozen_string_literal: true

require "trace_viz/logger"
require "trace_viz/config/validator"

module TraceViz
  class Configuration
    attr_reader :logger
    attr_reader(*Defaults.fetch_defaults.keys)

    def initialize
      @logger = Logger.new
      @validator = Config::Validator.new
      reset_defaults
    end

    Defaults.fetch_defaults.each_key do |attr|
      define_method("#{attr}=") do |value|
        @validator.validate(attr, value)
        current_value = instance_variable_get("@#{attr}")

        # Handle partial updates for hashes like `export`
        if current_value.is_a?(Hash) && value.is_a?(Hash)
          current_value.merge!(value)
        else
          instance_variable_set("@#{attr}", value)
        end
      end

      # define_method(attr) do
      #   instance_variable_get("@#{attr}")
      # end
    end

    def reset_defaults
      Defaults.fetch_defaults.each { |key, value| send("#{key}=", value) }
    end

    def dup
      copy = self.class.new
      instance_variables.each do |var|
        value = instance_variable_get(var)
        copy_value = begin
          value.dup
        rescue TypeError
          value
        end
        copy.instance_variable_set(var, copy_value)
      end
      copy
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
