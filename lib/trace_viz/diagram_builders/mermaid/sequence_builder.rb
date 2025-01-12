# frozen_string_literal: true

module TraceViz
  module DiagramBuilders
    module Mermaid
      class SequenceBuilder
        attr_reader :participants, :messages

        def initialize
          @participants = {}
          @messages = []
        end

        def add_participant(alias_name, full_name)
          @participants[full_name] = alias_name
        end

        def add_message(message)
          @messages << message
        end
      end
    end
  end
end
