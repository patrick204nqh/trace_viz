# frozen_string_literal: true

require "fileutils"
require_relative "base_exporter"

module TraceViz
  module Exporters
    class TextExporter < BaseExporter
      def export
        ensure_directory_exists!

        File.write(file_path, content)
        puts "Data exported to #{file_path}"
      end

      private

      def content
        data.join("\n")
      end

      def ensure_directory_exists!
        FileUtils.mkdir_p(File.dirname(file_path))
      end

      def file_path
        "trace_viz_output.txt"
      end
    end
  end
end
