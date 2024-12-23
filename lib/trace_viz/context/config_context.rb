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

      # Apply the overrides from options
      def apply_options(options)
        options.each do |key, value|
          if temp_configuration.respond_to?("#{key}=")
            temp_configuration.send("#{key}=", value)
          else
            TraceViz.logger.warn("Unknown configuration option '#{key}'")
          end
        end

        temp_configuration
      end
    end
  end
end
