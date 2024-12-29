# frozen_string_literal: true

require_relative "base"

module TraceViz
  module TraceData
    module TracePoint
      class MethodReturn < Base
        attr_reader :result, :method_call

        def initialize(trace_point)
          super(trace_point)

          populate_result
        end

        def link(method_call)
          @method_call = method_call
          method_call.link(self)
        end

        def duration
          return 0 unless method_call

          timestamp - method_call.timestamp
        end

        private

        def populate_result
          @result = @trace_point.return_value
        end
      end
    end
  end
end
