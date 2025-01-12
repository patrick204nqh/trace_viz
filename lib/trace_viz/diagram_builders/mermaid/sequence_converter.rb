# frozen_string_literal: true

require_relative "sequence_data"
require_relative "sequence_syntax"

module TraceViz
  module DiagramBuilders
    module Mermaid
      class SequenceConverter
        def initialize
          @syntax = SequenceSyntax.new(indent_level: 2)
        end

        def convert(builder)
          SequenceData.new(
            header: syntax.header,
            participants: convert_participants(builder.participants),
            messages: convert_messages(builder.messages),
          )
        end

        private

        attr_reader :syntax

        def convert_participants(participants)
          participants.map do |klass, alias_name|
            syntax.participant(alias_name, klass)
          end
        end

        def convert_messages(messages)
          messages.map do |message|
            case message[:type]
            when :loop_start
              syntax.loop_start(message[:message])
            when :loop_end
              syntax.loop_end
            when :activate
              syntax.activate(message[:participant])
            when :deactivate
              syntax.deactivate(message[:participant])
            when :message
              syntax.message(message[:from], message[:to], message[:message])
            when :return_message
              syntax.return_message(message[:from], message[:to], message[:message])
            else
              raise "Unknown message type: #{message[:type]}"
            end
          end
        end
      end
    end
  end
end
