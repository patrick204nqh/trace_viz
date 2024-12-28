# frozen_string_literal: true

require_relative "registry"

module TraceViz
  module Exporters
    class ExportManager
      def initialize(config)
        @config = config
      end

      def export(collector)
        return unless export_enabled?

        exporter = build_exporter(collector)
        exporter.export
      end

      private

      attr_reader :config

      def build_exporter(collector)
        Registry.build(export_format, collector)
      end

      def export_format
        config.export[:format]
      end

      def export_enabled?
        config.export[:enabled]
      end
    end
  end
end
