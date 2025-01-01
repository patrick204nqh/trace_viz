# frozen_string_literal: true

require "trace_viz/helpers"
require "trace_viz/traits"

module TraceViz
  module TraceData
    class Base
      include Helpers::ConfigHelper
      include Traits::DepthTrackable
      include Traits::TimeTrackable

      def initialize
        assign_depth(0)
        initialize_timestamp
      end

      def memory_id
        raise NotImplementedError
      end

      def action
        raise NotImplementedError
      end

      def event
        raise NotImplementedError
      end

      def path
        raise NotImplementedError
      end

      def line_number
        raise NotImplementedError
      end

      def klass
        raise NotImplementedError
      end
    end
  end
end
