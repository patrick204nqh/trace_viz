# frozen_string_literal: true

module TraceViz
  module Models
    class Box
      attr_reader :participants, :color, :description

      def initialize(color:, description:)
        @color = color
        @description = description
        @participants = []
      end

      def add_participant(participant)
        @participants << participant
      end
    end
  end
end
