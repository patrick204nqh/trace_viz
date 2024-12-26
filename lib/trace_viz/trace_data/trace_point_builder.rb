# frozen_string_literal: true

require_relative "trace_point/method_call"
require_relative "trace_point/method_return"

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
