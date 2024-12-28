# frozen_string_literal: true

module TraceViz
  module Collectors
    class TraceLinker
      def link_return_to_call(return_trace, call_trace)
        return unless valid_link?(return_trace, call_trace)

        perform_link(return_trace, call_trace)
      end

      private

      def valid_link?(return_trace, call_trace)
        call_trace && return_trace.action_id == call_trace.action_id
      end

      def perform_link(return_trace, call_trace)
        return_trace.link(call_trace)
      end
    end
  end
end
