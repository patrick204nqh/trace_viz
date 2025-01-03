# frozen_string_literal: true

module TraceViz
  module Defaults
    class Actions
      EMOJIS = {
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

      COLORS = {
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

      class << self
        def emojis
          EMOJIS
        end

        def colors
          COLORS
        end

        def keys
          colors.keys
        end

        def emoji_for(action)
          EMOJIS.fetch(action, EMOJIS[:default])
        end

        def source_colors
          Defaults.action_colors || COLORS
        end

        def colors_for(action)
          Array(source_colors.fetch(action, source_colors[:default]))
        end
      end
    end
  end
end
