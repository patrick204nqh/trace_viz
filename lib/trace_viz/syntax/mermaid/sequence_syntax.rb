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

        def box_start(box)
          "#{indent}box #{sanitize_name(box.color)} #{sanitize_name(box.description)}"
        end

        def box_end(_box)
          "#{indent}end"
        end

        def participant(participant)
          alias_name = sanitize_name(participant.alias_name)
          name = sanitize_name(participant.name)
          "#{indent}participant #{alias_name} as #{name}"
        end

        def message(message)
          from = sanitize_name(message.from&.alias_name)
          to = sanitize_name(message.to&.alias_name)
          content = sanitize_name(message.content)

          message_syntax(message.type, from, to, content)
        end

        private

        def message_syntax(type, from, to, content)
          case type
          when :call
            "#{indent}#{from} ->> #{to}: #{content}"
          when :return
            "#{indent}#{from} -->> #{to}: #{content}"
          when :activate
            "#{indent}activate #{to}"
          when :deactivate
            "#{indent}deactivate #{to}"
          when :loop_start
            "#{indent}loop #{content}"
          when :loop_end
            "#{indent}end"
          when :note
            "#{indent}Note over #{to}: #{content}"
          else
            raise ArgumentError, "Unsupported message type: #{type}"
          end
        end

        def indent
          " " * fetch_general_config(:tab_size)
        end

        def sanitize_name(name)
          return "" if name.nil?

          # Convert Symbols to Strings and handle string sanitization
          name = name.to_s

          # Handle `#<Class:...>` specifically
          name = name.gsub(/^#<Class:/, "[Class]").gsub(/>$/, "")

          # Replace unconventional method names with readable alternatives
          name = name.gsub("[]=", "set_value") # Replace `[]=` with `set_value`
            .gsub(/<<\z/, "append") # Replace `<<` with `append`
            .gsub("[]", "get_value") # Replace `[]` with `get_value`
            .gsub(/\A=/, "assign") # Replace `=` at the start with `assign`

          name
        end
      end
    end
  end
end
