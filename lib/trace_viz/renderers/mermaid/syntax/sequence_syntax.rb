# frozen_string_literal: true

module TraceViz
  module Renderers
    module Mermaid
      module Syntax
        class SequenceSyntax
          def header
            "sequenceDiagram"
          end

          def participant(alias_name, name)
            "participant #{alias_name} as #{name}"
          end

          def message(from, to, message)
            "#{from} ->> #{to}: #{message}"
          end

          def return_message(from, to, return_value)
            "#{to} -->> #{from}: #{return_value}"
          end
        end
      end
    end
  end
end
