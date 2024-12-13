# frozen_string_literal: true

require "trace_viz/logger"

module TraceViz
  class Configuration
    attr_accessor :logger,
      :tab_size,
      :show_indent,
      :show_depth,
      :max_display_depth,
      :show_method_name,
      :show_source_location,
      :show_params,
      :show_return_value,
      :show_execution_time

    def initialize
      @logger = Logger.new
      @tab_size = 2
      @show_indent = true
      @show_depth = true
      @max_display_depth = 3 # Recommended to keep this value between 3 and 5
      @show_method_name = true
      @show_source_location = false
      @show_params = true
      @show_return_value = true
      @show_execution_time = true
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
