# frozen_string_literal: true

module TraceViz
  module Loggers
    class BaseLogger
      def initialize
        @logger = TraceViz.logger
      end

      class << self
        def log(*args)
          new(*args).log
        end
      end

      def log
        raise NotImplementedError
      end

      private

      attr_reader :logger

      def log_message(level, message)
        logger.send(level, message)
      end
    end
  end
end
