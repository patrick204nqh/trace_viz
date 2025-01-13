# frozen_string_literal: true

require "trace_viz/helpers"

module TraceViz
  module Syntax
    module Mermaid
      class SequenceSyntax
        include Helpers::ConfigHelper

        def header
          "sequenceDiagram"
        end

        def participant(participant)
          alias_name = participant.alias_name
          name = participant.name
          "#{indent}participant #{alias_name} as #{name}"
        end

        def message(message)
          from = message.from
          to = message.to
          content = message.content

          case message.type
          when :call
            "#{indent}#{from&.alias_name} ->> #{to&.alias_name}: #{content}"
          when :return
            "#{indent}#{from&.alias_name} -->> #{to&.alias_name}: #{content}"
          when :activate
            "#{indent}activate #{to&.alias_name}"
          when :deactivate
            "#{indent}deactivate #{to&.alias_name}"
          when :loop_start
            "#{indent}loop #{content}"
          when :loop_end
            "#{indent}end"
          end
        end

        private

        def indent
          " " * fetch_general_config(:tab_size)
        end
      end
    end
  end
end
