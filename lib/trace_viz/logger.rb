# frozen_string_literal: true

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

      color = color_for(level)
      emoji = emoji_for(level)

      raw_message = build_message(message, level, emoji)
      formatted_message = wrap_in_color(raw_message, color)

      @output.puts(formatted_message)
    end

    private

    def validate_message!(message)
      raise ArgumentError, "Message must be a String" unless message.is_a?(String)
    end

    def validate_level!(level)
      raise ArgumentError, "Invalid log level: #{level}" unless LEVELS.include?(level)
    end

    def color_for(level)
      color_key = Defaults.action_colors.fetch(level)
      Defaults.colors.fetch(color_key)
    end

    def default_color
      color_for(:default)
    end

    def emoji_for(level)
      Defaults.action_emojis.fetch(level, "")
    end

    def build_message(message, level, emoji)
      if level == :default
        "#{emoji} #{message}" # No [DEFAULT] for :default level
      else
        format("%-3s %-8s %s", emoji, "[#{level.to_s.upcase}]", message)
      end
    end

    def wrap_in_color(message, color)
      "#{color}#{message}#{default_color}"
    end
  end
end
