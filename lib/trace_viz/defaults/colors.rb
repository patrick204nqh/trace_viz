# frozen_string_literal: true

module TraceViz
  module Defaults
    class Colors
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

      class << self
        def all
          COLORS
        end

        def fetch(color)
          COLORS.fetch(color, COLORS[:reset])
        end
      end
    end
  end
end
