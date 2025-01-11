# frozen_string_literal: true

require_relative "base_extractor"

module TraceViz
  module DiagramBuilders
    module Extractors
      class ParticipantExtractor < BaseExtractor
        def extract
          participants = []
          data.map do |node|
            participants << node.klass
          end

          generate_aliases(participants.uniq)
        end

        private

        def data
          collector.collection
        end

        def generate_aliases(participants)
          aliases = {}
          participants.each do |participant|
            aliases[participant] = generate_alias(participant, aliases)
          end
          aliases
        end

        def generate_alias(klass, existing_aliases = {})
          # Convert class to string
          klass_name = klass.to_s

          # Split into namespace components
          parts = klass_name.split("::")

          # Extract uppercase letters from each part
          initials = parts.map { |part| part.scan(/[A-Z]/).join }

          # Join initials with `_` to preserve hierarchy
          alias_candidate = initials.join("_")

          # Ensure uniqueness
          unique_alias = alias_candidate
          counter = 1
          while existing_aliases.value?(unique_alias)
            unique_alias = "#{alias_candidate}_#{counter}"
            counter += 1
          end

          unique_alias
        end
      end
    end
  end
end
