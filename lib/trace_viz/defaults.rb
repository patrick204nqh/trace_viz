# frozen_string_literal: true

module TraceViz
  class Defaults
    CONFIG = {
      tab_size: 2,
      show_indent: true,
      show_depth: true,
      max_display_depth: 3,
      show_method_name: true,
      show_source_location: false,
      show_params: true,
      param_display_mode: :name_and_value,
      show_return_value: true,
      show_execution_time: true,
      show_trace_events: [:call, :return],
      filters: [:exclude_internal_call],
      export: {
        enabled: true,
        path: "exports",
        format: :txt,
        overwrite: false,
      },
    }.freeze

    VALID_PARAM_DISPLAY_MODES = [:name_and_value, :name_only, :value_only].freeze
    VALID_EXPORT_FORMATS = [:txt, :json, :yml].freeze

    class << self
      def fetch_defaults
        CONFIG.dup
      end

      def valid_param_display_modes
        VALID_PARAM_DISPLAY_MODES
      end

      def valid_export_formats
        VALID_EXPORT_FORMATS
      end
    end
  end
end
