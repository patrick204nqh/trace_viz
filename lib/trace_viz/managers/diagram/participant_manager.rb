# frozen_string_literal: true

module TraceViz
  module Managers
    module Diagram
      class ParticipantsManager
        def initialize(participants)
          @participants_map = build_participants_map(participants)
        end

        def find(name)
          @participants_map[name.to_s]
        end

        private

        def build_participants_map(participants)
          participants.each_with_object({}) { |participant, memo| memo[participant.name] = participant }
        end
      end
    end
  end
end
