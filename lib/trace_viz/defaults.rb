# frozen_string_literal: true

module TraceViz
  class Defaults
    COLORS = {
      reset: "\e[0m",
      black: "\e[30m",
      red: "\e[31m",
      green: "\e[32m",
      yellow: "\e[33m",
      blue: "\e[34m",
      magenta: "\e[35m",
      cyan: "\e[36m",
      light_gray: "\e[37m",
      dark_gray: "\e[90m",
      light_red: "\e[91m",
      light_green: "\e[92m",
      light_yellow: "\e[93m",
      light_blue: "\e[94m",
      light_magenta: "\e[95m",
      light_cyan: "\e[96m",
      white: "\e[97m",
      dim_light_gray: "\e[2;37m",
    }.freeze

    ACTION_EMOJIS = {
      default: "",
      info: "ℹ️",
      success: "✅",
      error: "❌",
      warn: "⚠️",
      start: "🚀",
      processing: "🔄",
      finish: "🏁",
      exported: "📤",
      skipped: "⏩",
    }.freeze

    ACTION_COLORS = {
      default: :reset,
      info: :blue,
      success: :green,
      error: :red,
      warn: :yellow,
      start: :cyan,
      processing: :dim_light_gray,
      finish: :magenta,
      exported: :light_green,
      skipped: :light_yellow,
    }.freeze

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
      def colors
        COLORS
      end

      def action_colors
        ACTION_COLORS
      end

      def action_emojis
        ACTION_EMOJIS
      end

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
