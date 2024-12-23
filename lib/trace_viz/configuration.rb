# frozen_string_literal: true

require "trace_viz/logger"
require_relative "config/export_config"

module TraceViz
  class Configuration
    VALID_PARAM_DISPLAY_MODES = [:name_and_value, :name_only, :value_only].freeze

    DEFAULTS = {
      tab_size: 2,
      show_indent: true,
      show_depth: true,
      max_display_depth: 3,
      show_method_name: true,
      show_source_location: false,
      show_params: true,
      param_display_mode: :name_and_value,
      show_return_value: true,
      show_execution_time: true,
      show_trace_events: [:call, :return],
      filters: [:exclude_internal_call],
    }.freeze

    attr_reader :logger, :export

    ATTRIBUTES = DEFAULTS.keys.freeze
    ATTRIBUTES.each { |attr| attr_accessor attr }

    def initialize
      @logger = Logger.new
      @export = Config::ExportConfig.new

      DEFAULTS.each { |key, value| send("#{key}=", value) }
    end

    def param_display_mode=(mode)
      unless VALID_PARAM_DISPLAY_MODES.include?(mode)
        raise ArgumentError,
          "Invalid param_display_mode: #{mode}. Valid modes are #{VALID_PARAM_DISPLAY_MODES.join(", ")}."
      end

      @param_display_mode = mode
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
