# frozen_string_literal: true

module TraceViz
  class Logger
    COLORS = {
      reset: "\e[0m",
      info: "\e[34m",
      success: "\e[32m",
      error: "\e[31m",
      warn: "\e[33m",
      start: "\e[36m",
      finish: "\e[35m",
      exported: "\e[92m",
      skipped: "\e[93m",
    }.freeze

    EMOJIS = {
      info: "ℹ️",
      success: "✅",
      error: "❌",
      warn: "⚠️",
      start: "🚀",
      finish: "🏁",
      exported: "📤",
      skipped: "⏩",
    }.freeze

    LEVELS = [:info, :success, :error, :warn, :start, :finish, :exported, :skipped].freeze

    def initialize(output: $stdout)
      @output = output
    end

    def info(message)
      log(:info, message)
    end

    def success(message)
      log(:success, message)
    end

    def error(message)
      log(:error, message)
    end

    def warn(message)
      log(:warn, message)
    end

    def start(message)
      log(:start, message)
    end

    def finish(message)
      log(:finish, message)
    end

    def exported(message)
      log(:exported, message)
    end

    def skipped(message)
      log(:skipped, message)
    end

    def log(level, message)
      return unless LEVELS.include?(level)

      color = COLORS[level] || COLORS[:info]
      emoji = EMOJIS[level] || EMOJIS[:info]

      # Build the full message with emoji, level, and text
      raw_message = format(
        "%-3s %-8s %s",
        emoji,
        "[#{level.to_s.upcase}]",
        message,
      )

      # Apply color to the full message if color is enabled
      formatted_message = wrap_in_color(raw_message, color)

      @output.puts(formatted_message)
    end

    private

    def wrap_in_color(message, color)
      "#{color}#{message}#{COLORS[:reset]}"
    end
  end
end
