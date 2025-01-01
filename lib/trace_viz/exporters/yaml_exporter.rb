# frozen_string_literal: true

require "yaml"
require_relative "base_exporter"
require_relative "transformers/yaml_transformer"

module TraceViz
  module Exporters
    class YamlExporter < BaseExporter
      private

      def transform_collector_data(collector)
        transformer = Transformers::YamlTransformer.new(collector)
        transformer.transform
      end

      def content
        YAML.dump(data)
      end
    end
  end
end
