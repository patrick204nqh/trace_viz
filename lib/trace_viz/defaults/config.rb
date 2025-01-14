# frozen_string_literal: true

module TraceViz
  module Defaults
    class Config
      DEFAULTS = {
        general: {
          tab_size: 2,
          mode: :summary, # :summary, :verbose
          group_keys: [:event, :klass, :action],
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
          truncate_value: 50,
          truncate_length: 30,
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

      class << self
        def fetch
          DEFAULTS.dup
        end

        def valid_param_modes
          [:name_and_value, :name_only, :value_only].freeze
        end

        def valid_param_mode?(mode)
          valid_param_modes.include?(mode)
        end

        def valid_export_formats
          [:txt, :json, :yaml, :mermaid].freeze
        end

        def valid_export_format?(format)
          valid_export_formats.include?(format)
        end
      end
    end
  end
end
