# frozen_string_literal: true

require_relative "base_policy"

module TraceViz
  module Collectors
    module Policies
      class EventPolicy < BasePolicy
        def initialize
          super()
          @allowed_events = config.show_trace_events
        end

        def applicable?(trace_data)
          allowed_events.include?(trace_data.event)
        end

        private

        attr_reader :allowed_events
      end
    end
  end
end
