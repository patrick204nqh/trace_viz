# frozen_string_literal: true

require "trace_viz/adapters/trace_point/trace_formatter"

module TraceViz
  module Adapters
    module TracePoint
      class TraceLogger
        def initialize(trace_data)
          @trace_data = trace_data
          @config = @trace_data.config
          @formatter = TraceFormatter.new(@trace_data)
        end

        def log_trace
          return unless should_log?

          case trace_data.event
          when :call
            log_call
          when :return
            log_return
          end
        end

        private

        attr_reader :trace_data, :config, :formatter

        def log_call
          formatted_call = formatter.format_call
          TraceViz.logger.start(formatted_call)
        end

        def log_return
          formatted_return = formatter.format_return
          TraceViz.logger.finish(formatted_return)
        end

        def should_log?
          config.show_trace_events.include?(trace_data.event)
        end
      end
    end
  end
end
