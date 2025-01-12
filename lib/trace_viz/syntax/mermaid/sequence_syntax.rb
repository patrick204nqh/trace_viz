# frozen_string_literal: true

module TraceViz
  module Syntax
    module Mermaid
      class SequenceSyntax
        def initialize(formatter:)
          @formatter = formatter
        end

        def header
          "sequenceDiagram"
        end

        def participant(participant)
          alias_name = participant.alias_name
          name = formatter.format_participant_name(participant.name)
          "#{indent}participant #{alias_name} as #{name}"
        end

        def message(message)
          from = message.from
          to = message.to
          content = formatter.format_message_content(message.content)

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

        attr_reader :formatter

        def indent
          @formatter.indentation
        end
      end
    end
  end
end
