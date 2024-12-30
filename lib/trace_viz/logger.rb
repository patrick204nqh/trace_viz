# frozen_string_literal: true

require "trace_viz/utils/colorize"

module TraceViz
  class Logger
    LEVELS = Defaults.action_colors.keys.freeze

    def initialize(output: $stdout)
      @output = output
    end

    LEVELS.each do |level|
      define_method(level) do |message|
        log(message, level)
      end
    end

    def log(message, level = :default)
      validate_message!(message)
      validate_level!(level)

      colors = Defaults.action_colors_for(level)
      emoji = Defaults.emoji_for(level)

      raw_message = build_message(message, level, emoji)
      formatted_message = apply_colors(raw_message, colors)

      @output.puts(formatted_message)
    end

    private

    def validate_message!(message)
      raise ArgumentError, "Message must be a String" unless message.is_a?(String)
    end

    def validate_level!(level)
      raise ArgumentError, "Invalid log level: #{level}" unless LEVELS.include?(level)
    end

    def build_message(message, level, emoji)
      level_str = level == :default ? "" : "[#{level.to_s.upcase}]"
      merged_emoji_level = "#{emoji} #{level_str}".strip
      format("%-12s %s", merged_emoji_level, message)
    end

    def apply_colors(message, colors)
      Utils::Colorize.colorize(message, *colors)
    end
  end
end
