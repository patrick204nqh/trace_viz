# frozen_string_literal: true

module TraceViz
  module Utils
    module Colorize
      class << self
        def colorize(text, *styles)
          return text if text.nil? || styles.empty?

          "#{build_color_sequence(styles)}#{text}#{Defaults.colors[:reset]}"
        end

        private

        def build_color_sequence(styles)
          styles
            .map { |style| Defaults.colors[style] }
            .compact
            .join
        end
      end
    end
  end
end
