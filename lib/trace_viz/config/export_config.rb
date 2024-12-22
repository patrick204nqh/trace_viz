# frozen_string_literal: true

module TraceViz
  module Config
    class ExportConfig
      attr_accessor :enabled, :format, :path, :overwrite

      def initialize
        @enabled = false
        @format = :txt
        @path = "exports"
        @overwrite = true
      end
    end
  end
end
