# frozen_string_literal: true

module TraceViz
  module Adapters
    module TracePoint
      class TraceLogger
        def initialize(trace_data)
          @trace_data = trace_data
          @formatter = TraceFormatter.new(@trace_data)
        end

        def log_trace
          case trace_data.event
          when :call
            log_call
          when :return
            log_return
          end
        end

        private

        attr_reader :trace_data, :formatter

        def log_call
          formatted_call = formatter.format_call
          TraceViz.logger.start(formatted_call)
        end

        def log_return
          formatted_return = formatter.format_return
          TraceViz.logger.finish(formatted_return)
        end
      end
    end
  end
end
