# frozen_string_literal: true

require "trace_viz/context/base_context"

module TraceViz
  module Context
    class ConfigContext < BaseContext
      attr_reader :configuration

      def initialize(**options)
        super

        @configuration = apply_options(options)
      end

      def temp_configuration
        @temp_configuration ||= TraceViz.configuration.dup
      end

      # Apply options, supporting both top-level and nested keys
      def apply_options(options)
        options.each do |key, value|
          if value.is_a?(Hash)
            update_nested_config(key, value)
          else
            update_top_level_config(key, value)
          end
        end

        temp_configuration
      end

      # Update a top-level configuration option
      def update_top_level_config(key, value)
        if temp_configuration.respond_to?("#{key}=")
          temp_configuration.send("#{key}=", value)
        else
          log_warning("Unknown configuration option '#{key}'")
        end
      end

      # Update a nested configuration using a hash
      def update_nested_config(parent_key, hash)
        nested_config = temp_configuration.send(parent_key)
        unless nested_config
          log_warning("Unknown nested configuration '#{parent_key}'")
          return
        end

        hash.each do |key, value|
          if nested_config.respond_to?("#{key}=")
            nested_config.send("#{key}=", value)
          else
            log_warning("Unknown nested configuration option '#{parent_key}.#{key}'")
          end
        end
      end

      # Log warnings for unknown keys
      def log_warning(message)
        TraceViz.logger.warn("TraceViz: #{message}")
      end
    end
  end
end
