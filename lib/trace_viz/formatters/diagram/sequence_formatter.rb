# frozen_string_literal: true

module TraceViz
  module Formatters
    module Diagram
      class SequenceFormatter
        def initialize(indent_level: 2)
          @indent = " " * indent_level
        end

        def indentation
          @indent
        end

        def format_participant_name(name)
          name
        end

        def format_message_content(content)
          content[0..50]
        end
      end
    end
  end
end
