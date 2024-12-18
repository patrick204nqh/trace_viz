# frozen_string_literal: true

require "trace_viz/trace_data/trace_point/method_call"
require "trace_viz/trace_data/trace_point/method_return"

module TraceViz
  module TraceData
    class TracePointBuilder
      class << self
        def build(tp)
          case tp.event
          when :call
            TracePoint::MethodCall.new(tp)
          when :return
            TracePoint::MethodReturn.new(tp)
          else
            raise ArgumentError, "Unsupported TracePoint event: #{tp.event}"
          end
        end
      end
    end
  end
end
