# frozen_string_literal: true

module TraceViz
  module Defaults
    class Themes
      SOLARIZED = {
        base03: :color_234,
        base02: :color_235,
        base01: :color_240,
        base00: :color_241,
        base0: :color_244,
        base1: :color_245,
        base2: :color_254,
        base3: :color_230,
        yellow: :color_136,
        orange: :color_166,
        red: :color_160,
        magenta: :color_125,
        violet: :color_61,
        blue: :color_33,
        cyan: :color_37,
        green: :color_64,
      }.freeze

      class << self
        def solarized
          SOLARIZED
        end

        def apply_solarized_theme
          colors = {
            default: SOLARIZED[:base0],
            info: SOLARIZED[:blue],
            success: SOLARIZED[:green],
            error: SOLARIZED[:red],
            warn: SOLARIZED[:yellow],
            start: SOLARIZED[:blue],
            processing: SOLARIZED[:base01],
            finish: SOLARIZED[:magenta],
            exported: SOLARIZED[:green],
            skipped: SOLARIZED[:base01],
            stats: [:bold, :underline, SOLARIZED[:base2]],
            trace_indent: SOLARIZED[:base03],
            trace_depth: SOLARIZED[:blue],
            trace_depth_prefix: [:italic, SOLARIZED[:base02]],
            trace_depth_open: SOLARIZED[:base02],
            trace_depth_value: SOLARIZED[:red],
            trace_depth_close: SOLARIZED[:base03],
            trace_method_name: SOLARIZED[:cyan],
            trace_method_class: [:bold, SOLARIZED[:green]],
            trace_method_sign: SOLARIZED[:violet],
            trace_method_action: [:bold, SOLARIZED[:blue]],
            trace_source_location: SOLARIZED[:base01],
            trace_params_key: SOLARIZED[:orange],
            trace_params_value: SOLARIZED[:base00],
            trace_result_prefix: SOLARIZED[:base1],
            trace_result_value: SOLARIZED[:base3],
            trace_execution_time: SOLARIZED[:cyan],
          }

          Defaults.action_colors = colors
        end
      end
    end
  end
end
