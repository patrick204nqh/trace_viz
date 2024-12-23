# frozen_string_literal: true

require "fileutils"

require "trace_viz/context"
require_relative "transformers/text_transformer"

module TraceViz
  module Exporters
    class BaseExporter
      def initialize(collector)
        @config = Context.for(:config).configuration
        @export_config = config.export
        @logger = config.logger
        @data = transform_collector_data(collector)
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

        logger.success("Data successfully exported to #{file_path}")
      end

      private

      attr_reader :config, :export_config, :logger, :data

      def transform_collector_data(collector)
        transformer = Transformers::TextTransformer.new(collector)
        transformer.transform
      end

      def content
        raise NotImplementedError
      end

      def export_enabled?
        export_config.enabled
      end

      def ensure_directory_exists
        FileUtils.mkdir_p(File.dirname(file_path))
      end

      def handle_existing_file
        return unless File.exist?(file_path)

        if export_config.overwrite
          logger.info("Overwriting existing file: #{file_path}")
        else
          logger.warn("File already exists and overwrite is disabled: #{file_path}. Export skipped.")
          :skip
        end
      end

      def handle_empty_content
        if content.nil? || content.strip.empty?
          logger.warn("Export content is empty. Export skipped.")
          :skip
        end
      end

      def file_path
        format = export_config.format
        path = export_config.path

        "#{path}/trace_output.#{format}"
      end

      def write_file(data)
        File.write(file_path, data)
      end
    end
  end
end
