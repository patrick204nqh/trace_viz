# frozen_string_literal: true

require "trace_viz/models/participant" # Adjust path if needed
require_relative "../base_extractor"

module TraceViz
  module Extractors
    module Diagram
      class ParticipantExtractor < BaseExtractor
        def extract
          unique_names = data.map(&:klass).uniq

          assigned_aliases = {}

          unique_names.map do |raw_name|
            alias_name = generate_alias(raw_name, assigned_aliases)

            Models::Participant.new(
              name: raw_name.to_s,
              alias_name: alias_name,
            )
          end
        end

        private

        def data
          collector.collection
        end

        # Generates a unique alias for a name and stores it in assigned_aliases
        def generate_alias(name, assigned_aliases)
          # Convert name to string in case it's not already
          str_name = name.to_s

          # Split into namespace components
          parts = str_name.split("::")

          # Extract uppercase letters from each component
          initials = parts.map { |part| part.scan(/[A-Z]/).join }

          # Join initials with `_` to preserve hierarchy
          alias_candidate = initials.join("_")

          # Ensure uniqueness by appending a counter if needed
          unique_alias = alias_candidate
          counter      = 1
          while assigned_aliases.value?(unique_alias)
            unique_alias = "#{alias_candidate}_#{counter}"
            counter     += 1
          end

          # Record the final alias in the map
          assigned_aliases[name] = unique_alias
          unique_alias
        end
      end
    end
  end
end
