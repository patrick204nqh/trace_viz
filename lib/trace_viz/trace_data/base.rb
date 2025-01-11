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
        record_timestamp
      end

      #
      # Represents trace data type code
      #
      def key
        raise NotImplementedError
      end

      def event
        raise NotImplementedError
      end

      def klass
        raise NotImplementedError
      end

      def action
        raise NotImplementedError
      end

      def path
        raise NotImplementedError
      end

      def line_number
        raise NotImplementedError
      end

      def to_h
        {
          event: event,
          klass: klass,
          action: action,
          path: path,
          line_number: line_number,
        }
      end
    end
  end
end
