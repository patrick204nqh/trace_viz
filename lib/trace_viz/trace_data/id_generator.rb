# frozen_string_literal: true

module TraceViz
  module TraceData
    class IDGenerator
      ID_DELIMITER = "|"
      COMPONENT_DELIMITER = ":"

      class << self
        def generate_unique_id(memory_id:, action:, path:, line_number:)
          join_with_delimiters(
            memory: memory_id,
            action: action,
            path: path,
            line: line_number,
          )
        end

        def generate_action_id(memory_id:, action:)
          join_with_delimiters(
            memory: memory_id,
            action: action,
          )
        end

        private

        def join_with_delimiters(**components)
          components.map { |key, value| "#{key}#{COMPONENT_DELIMITER}#{value}" }
            .join(ID_DELIMITER)
        end
      end
    end
  end
end
