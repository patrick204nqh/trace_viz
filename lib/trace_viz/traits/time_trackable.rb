# frozen_string_literal: true

module TraceViz
  module Traits
    module TimeTrackable
      attr_reader :timestamp

      def initialize_timestamp
        @timestamp = Time.now
      end
    end
  end
end
