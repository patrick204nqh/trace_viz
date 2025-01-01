# frozen_string_literal: true

require "trace_viz/utils/id_generator"

module TraceViz
  module Traits
    module Identifiable
      attr_reader :id, :action_id

      def assign_ids
        @id = Utils::IDGenerator.generate_unique_id(
          memory_id: memory_id,
          action: action,
          path: path,
          line_number: line_number,
        )

        @action_id = Utils::IDGenerator.generate_action_id(
          memory_id: memory_id,
          action: action,
        )
      end
    end
  end
end
