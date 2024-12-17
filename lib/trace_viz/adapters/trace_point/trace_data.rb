# frozen_string_literal: true

require "trace_viz/adapters/trace_point/depth_manager"
require "trace_viz/adapters/trace_point/trace_logger"

module TraceViz
  module Adapters
    module TracePoint
      class TraceData
        attr_reader :trace_point, :config, :timestamp, :depth

        def initialize(trace_point)
          @trace_point = trace_point
          @config = Context.for(:config).configuration
          @logger = TraceLogger.new(self)
          @depth_manager = DepthManager.new(self)

          record_timestamp
          assign_depth
        end

        def id
          trace_point.method_id
        end

        def event
          trace_point.event
        end

        def path
          trace_point.path
        end

        def line_number
          trace_point.lineno
        end

        def klass
          trace_point.defined_class
        end

        def params
          trace_point.binding.local_variables
        end

        def result
          trace_point.return_value
        end

        def internal_call?
          internal_path? || internal_class?
        end

        def exceeded_max_depth?
          return false unless config.max_display_depth

          depth > config.max_display_depth
        end

        def duration
          # TODO: Implement duration calculation
        end

        def log_trace
          logger.log_trace
        end

        private

        attr_reader :logger, :depth_manager

        def internal_path?
          path.include?("<internal:")
        end

        def internal_class?
          klass.to_s.start_with?("TracePoint")
        end

        def record_timestamp
          @timestamp = Time.now
        end

        def assign_depth
          @depth = @depth_manager.assign_depth
        end
      end
    end
  end
end
