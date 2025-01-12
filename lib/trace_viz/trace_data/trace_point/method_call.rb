# frozen_string_literal: true

require "trace_viz/helpers/trace_point/param_helper"
require_relative "base"

module TraceViz
  module TraceData
    module TracePoint
      class MethodCall < Base
        include Helpers::TracePoint::ParamHelper

        attr_reader :params, :method_return

        def initialize(trace_point)
          super(trace_point)

          populate_params
        end

        def result
          method_return&.result
        end

        def link(method_return)
          @method_return = method_return
        end

        def duration
          return 0 unless method_return

          method_return.timestamp - timestamp
        end

        def to_h
          super.merge(
            {
              params: params,
              method_return_id: method_return&.id,
            },
          )
        end

        private

        def populate_params
          @params = extract_params(trace_point.binding, action)
        end
      end
    end
  end
end
