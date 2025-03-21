# frozen_string_literal: true

require "fileutils"
require "trace_viz/helpers"
require "trace_viz/shared"
require "trace_viz/renderers/renderer_builder"
require "trace_viz/formatters/export/formatter_factory"

module TraceViz
  module Exporters
    class BaseExporter
      include Helpers::ConfigHelper
      include Shared::RendererHelper

      def initialize(collector)
        @export_config = config.export
        @logger = config.logger

        @collector = collector

        @renderer = Renderers::RendererBuilder.build(
          collector,
          key: renderer_mode,
          formatter_factory: Formatters::Export::FormatterFactory.new,
        )
      end

      def export
        unless export_enabled?
          logger.warn("Export is disabled in configuration. Skipping export process.")
          return
        end

        ensure_directory_exists
        return if handle_empty_content == :skip
        return if handle_existing_file == :skip

        write_file(content)

        logger.exported("Data successfully exported to #{file_path}")
      end

      private

      attr_reader :export_config, :logger, :collector, :renderer

      def renderer_mode
        fetch_general_config(:mode)
      end

      def content
        data.join("\n")
      end

      def data
        process_lines(renderer.to_lines) { |line| line[:line] }
      end

      def export_enabled?
        export_config[:enabled]
      end

      def ensure_directory_exists
        FileUtils.mkdir_p(File.dirname(file_path))
      end

      def handle_existing_file
        return unless File.exist?(file_path)

        if export_config[:overwrite]
          logger.processing("Overwriting existing file: #{file_path}")
        else
          logger.skipped("File already exists and overwrite is disabled: #{file_path}. Export skipped.")
          :skip
        end
      end

      def handle_empty_content
        if content.nil? || content.strip.empty?
          logger.skipped("Export content is empty. Export skipped.")
          :skip
        end
      end

      def file_path
        "#{export_directory}/trace_output#{file_extension}"
      end

      def export_directory
        export_config[:path]
      end

      def file_extension
        raise NotImplementedError
      end

      def write_file(data)
        File.write(file_path, data)
      end
    end
  end
end
