# frozen_string_literal: true

require_relative "base_formatter"
require "trace_viz/formatters/helpers"

module TraceViz
  module Formatters
    module Diagram
      module Sequence
        class MessageFormatter < BaseFormatter
          include Helpers::ParamsHelper
          include Helpers::Diagram::ActionHelper
          include Helpers::Diagram::ResultHelper

          def format_internal_message(trace)
            [
              action_representation(trace),
              params_representation(trace),
            ].join("")
          end

          def format_result(trace)
            result_representation(trace)
          end

          def format_call
            "Calling"
          end

          def format_return
            "Returning"
          end
        end
      end
    end
  end
end
