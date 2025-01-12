# frozen_string_literal: true

module TraceViz
  module DiagramBuilders
    module Mermaid
      class SequenceSyntax
        def initialize(indent_level: 2)
          @indent = " " * indent_level
        end

        def header
          "sequenceDiagram"
        end

        def participant(alias_name, klass)
          "#{@indent}participant #{alias_name} as #{klass}"
        end

        def message(from, to, message)
          "#{@indent}#{from} ->> #{to}: #{message}"
        end

        def return_message(from, to, message)
          "#{@indent}#{from} -->> #{to}: #{message}"
        end

        def loop_start(message)
          "#{@indent}loop #{message}"
        end

        def loop_end
          "#{@indent}end"
        end

        def activate(participant)
          "#{@indent}activate #{participant}"
        end

        def deactivate(participant)
          "#{@indent}deactivate #{participant}"
        end
      end
    end
  end
end
