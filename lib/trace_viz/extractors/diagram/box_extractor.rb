# frozen_string_literal: true

require_relative "base_extractor"
require_relative "participant_extractor"
require "trace_viz/models/box"

module TraceViz
  module Extractors
    module Diagram
      class BoxExtractor < BaseExtractor
        def initialize(collector)
          super(collector)

          @participants = ParticipantExtractor.new(collector).extract
        end

        def extract
          grouped_participants = group_by_namespace(@participants)

          grouped_participants.map do |namespace, participants|
            box = Models::Box.new(
              color: random_rgb,
              description: namespace,
            )

            participants.each do |participant|
              box.add_participant(participant)
            end

            box
          end
        end

        private

        def group_by_namespace(participants)
          participants.group_by { |participant| extract_namespace(participant.name) }
        end

        def extract_namespace(klass_name)
          klass_name.split("::").first
        end

        def random_rgb
          "rgb(#{rand(200..255)}, #{rand(200..255)}, #{rand(200..255)})"
        end
      end
    end
  end
end
