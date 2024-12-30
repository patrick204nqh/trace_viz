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
    }

    # Reference ASCII color codes
    # https://talyian.github.io/ansicolors/

    # Map 256-color ANSI codes
    (0..255).each do |i|
      COLORS["color_#{i}".to_sym] = "\e[38;5;#{i}m"
    end

    # To add background colors
    (0..255).each do |i|
      COLORS["bg_color_#{i}".to_sym] = "\e[48;5;#{i}m"
    end

    # Predefined names
    COLORS.merge!({
      black: "\e[30m",
      red: "\e[31m",
      green: "\e[32m",
      yellow: "\e[33m",
      blue: "\e[34m",
      magenta: "\e[35m",
      cyan: "\e[36m",
      white: "\e[37m",
      bright_black: "\e[90m",
      bright_red: "\e[91m",
      bright_green: "\e[92m",
      bright_yellow: "\e[93m",
      bright_blue: "\e[94m",
      bright_magenta: "\e[95m",
      bright_cyan: "\e[96m",
      bright_white: "\e[97m",
    })

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
      # Default actions
      default: :reset,
      info: :cyan,
      success: :green,
      error: :bright_red,
      warn: :yellow,

      # Processing actions
      start: :bright_cyan,
      processing: [:dim, :bright_white],
      finish: :bright_magenta,

      # Export & stats actions
      exported: :bright_green,
      skipped: :bright_white,
      stats: [:bold, :underline, :bright_white],

      # Trace data actions
      trace_indent: :dim,
      trace_depth: :blue,
      trace_depth_prefix: [:dim, :italic, :blue],
      trace_depth_open: [:dim, :bright_blue],
      trace_depth_value: :bright_red,
      trace_depth_close: [:dim, :bright_blue],
      trace_method_name: :bright_cyan,
      trace_method_class: :bright_green,
      trace_method_sign: :blue,
      trace_method_action: [:bold, :bright_cyan],
      trace_source_location: [:dim, :bright_white],
      trace_params_key: :bright_yellow,
      trace_params_value: [:dim, :bright_yellow],
      trace_result_prefix: [:italic, :bright_blue],
      trace_result_value: :bright_white,
      trace_execution_time: [:dim, :bright_red],
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

      def color_code_for(color)
        COLORS.fetch(color, COLORS[:reset])
      end

      def action_colors_for(action)
        action_colors = ACTION_COLORS.fetch(action, ACTION_COLORS[:default])

        Array(action_colors)
      end

      def emoji_for(action)
        ACTION_EMOJIS.fetch(action, ACTION_EMOJIS[:default])
      end
    end
  end
end
