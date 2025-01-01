# frozen_string_literal: true

module TraceViz
  module Traits
    module DepthTrackable
      attr_reader :depth

      def assign_depth(depth)
        @depth = depth
      end
    end
  end
end
