# frozen_string_literal: true

require "trace_viz/logger"

module TraceViz
  class Configuration
    attr_accessor :show_indent,
      :show_depth,
      :max_display_depth,
      :show_method_name,
      :show_source_location,
      :show_parameters,
      :show_return_value,
      :show_execution_time,
      :tab_size,
      :logger

    def initialize
      @show_indent = true
      @show_depth = true
      @max_display_depth = 3 # Recommended to keep this value between 3 and 5
      @show_method_name = true
      @show_source_location = true
      @show_parameters = true
      @show_return_value = true
      @show_execution_time = true
      @tab_size = 2
      @logger = Logger.new
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
