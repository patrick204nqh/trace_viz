# frozen_string_literal: true

require_relative "base_exporter"

module TraceViz
  module Exporters
    class TextExporter < BaseExporter
      def export
        # file_path = "~/trace_output.txt"
        # File.open(file_path, "w") do |file|
        #   collection.data.each do |item|
        #     file.puts item.event
        #   end
        # end
      end
    end
  end
end
