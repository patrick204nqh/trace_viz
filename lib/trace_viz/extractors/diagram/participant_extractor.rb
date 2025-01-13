# frozen_string_literal: true

require "trace_viz/utils/alias_generator"
require "trace_viz/models/participant"
require_relative "../base_extractor"

module TraceViz
  module Extractors
    module Diagram
      class ParticipantExtractor < BaseExtractor
        def extract
          unique_names = data.map(&:klass).uniq

          assigned_aliases = {}

          unique_names.map do |raw_name|
            alias_name = Utils::AliasGenerator.generate(
              name: raw_name,
              assigned_aliases: assigned_aliases,
            )

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
      end
    end
  end
end
