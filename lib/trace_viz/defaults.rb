# frozen_string_literal: true

module TraceViz
  class Defaults
    COLORS = {
      reset: "\e[0m",
      bold: "\e[1m",
      dim: "\e[2m",
      italic: "\e[3m",
      underline: "\e[4m",
      reverse: "\e[7m",
      hidden: "\e[8m",
      strikethrough: "\e[9m",

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

      bg_black: "\e[40m",
      bg_red: "\e[41m",
      bg_green: "\e[42m",
      bg_yellow: "\e[43m",
      bg_blue: "\e[44m",
      bg_magenta: "\e[45m",
      bg_cyan: "\e[46m",
      bg_dark_gray: "\e[100m",
      bg_light_red: "\e[101m",
      bg_light_green: "\e[102m",
      bg_light_yellow: "\e[103m",
      bg_light_blue: "\e[104m",
      bg_light_magenta: "\e[105m",
      bg_light_cyan: "\e[106m",
      bg_white: "\e[107m",

      bright_black: "\e[90m",
      bright_red: "\e[91m",
      bright_green: "\e[92m",
      bright_yellow: "\e[93m",
      bright_blue: "\e[94m",
      bright_magenta: "\e[95m",
      bright_cyan: "\e[96m",
      bright_white: "\e[97m",
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
      stats: "📊",
    }.freeze

    ACTION_COLORS = {
      default: :reset,
      info: :cyan,
      success: :green,
      error: :light_red,
      warn: :yellow,
      start: :light_cyan,
      processing: :dark_gray,
      finish: :light_magenta,
      exported: :light_green,
      skipped: :dark_gray,
      stats: [:bold, :underline, :bright_white],
    }.freeze

    CONFIG = {
      general: {
        tab_size: 2,
        show_indent: true,
        show_depth: true,
        max_display_depth: 3,
        show_method_name: true,
      },
      source_location: {
        show: false,
        truncate_length: 100,
      },
      params: {
        show: true,
        mode: :name_and_value,
        truncate_values: 10,
      },
      result: {
        show: true,
        truncate_length: 50,
      },
      execution: {
        show_time: true,
        show_trace_events: [:call, :return],
      },
      filters: [
        :exclude_internal_call,
        # :exclude_default_classes,
        # :exclude_rails_framework,
        # include_classes: {
        #   classes: [],
        # },
        # exclude_classes: {
        #   classes: [],
        # },
        # include_gems: {
        #   app_running: true,
        #   app_path: Dir.pwd,
        #   gems: [],
        # },
        # exclude_gems: {
        #   gems: [],
        # },
      ],
      log: {
        enabled: true,
        runtime: false,
        post_collection: true,
        stats: true,
      },
      export: {
        enabled: true,
        path: "tmp",
        format: :txt,
        overwrite: false,
      },
    }.freeze

    VALID_PARAM_MODES = [:name_and_value, :name_only, :value_only].freeze
    VALID_EXPORT_FORMATS = [:txt, :json, :yaml].freeze

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

      def valid_param_modes
        VALID_PARAM_MODES
      end

      def valid_export_formats
        VALID_EXPORT_FORMATS
      end
    end
  end
end
