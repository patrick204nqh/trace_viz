# frozen_string_literal: true

require "trace_viz/logger"
require "trace_viz/adapters/trace_point/trace_formatter"

module TraceViz
  module Adapters
    module TracePoint
      class TraceLogger
        def initialize(trace_data)
          @trace_data = trace_data
          @logger = Logger.new
          @formatter = TraceFormatter.new(@trace_data)
        end

        def log_trace
          case @trace_data.event
          when :call
            log_call
          when :return
            log_return
          end
        end

        private

        def log_call
          formatted_call = @formatter.format_call
          @logger.start(formatted_call)
        end

        def log_return
          formatted_return = @formatter.format_return
          @logger.finish(formatted_return)
        end
      end
    end
  end
end
