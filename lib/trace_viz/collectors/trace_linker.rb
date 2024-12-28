# frozen_string_literal: true

module TraceViz
  module Collectors
    class TraceLinker
      def link_return_to_call(return_trace, call_trace)
        unless valid_link?(return_trace, call_trace)
          log_warning(return_trace, call_trace)
          return
        end

        perform_link(return_trace, call_trace)
      end

      private

      def log_warning(return_trace, call_trace)
        TraceViz.logger.warn(
          format(
            "Invalid link detected: " \
              "return_trace: %p, " \
              "call_trace: %p",
            return_trace.id,
            call_trace.id,
          ),
        )
      end

      def valid_link?(return_trace, call_trace)
        [
          return_trace.event == :return,
          call_trace.event == :call,
          return_trace.action_id == call_trace.action_id,
        ].all?
      end

      def perform_link(return_trace, call_trace)
        return_trace.link(call_trace)
      end
    end
  end
end
