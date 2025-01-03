# frozen_string_literal: true

require "trace_viz/helpers"
require_relative "registry"

module TraceViz
  module Exporters
    class ExportManager
      include Helpers::ConfigHelper

      def export(collector)
        return unless export_enabled?

        exporter = build_exporter(collector)
        exporter.export
      end

      private

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
