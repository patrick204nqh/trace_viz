# frozen_string_literal: true

module TraceViz
  module Utils
    module Colorize
      class << self
        def colorize(text, *colors)
          return text if text.nil? || colors.empty?

          "#{build_color_sequence(colors)}#{text}#{Defaults::Colors.fetch(:default)}"
        end

        private

        def build_color_sequence(colors)
          colors
            .map { |color| Defaults::Colors.fetch(color) }
            .compact
            .join
        end
      end
    end
  end
end
