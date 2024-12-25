# frozen_string_literal: true

require "trace_viz/context"
require "trace_viz/loggers/trace_logger"
require_relative "evaluators/filter_evaluator"
require_relative "evaluators/hidden_evaluator"

module TraceViz
  module Collectors
    class BaseCollector
      attr_reader :collection

      # To implement collect trace data from the given event,
      # you need to enter the `config` context to perform the evaluation.
      def initialize
        @tracker = Context.for(:tracking)

        @collection = []

        @filter_evaluator = Evaluators::FilterEvaluator.new
        @hidden_evaluator = Evaluators::HiddenEvaluator.new
      end

      def collect(event)
        return unless collectible(event)

        trace_data = build_trace(event)
        return unless valid?(trace_data)

        trace_data = update_trace_depth(trace_data)
        return if hidden?(trace_data)

        log_trace(trace_data)
        store_trace(trace_data)
      end

      def clear
        @collection = []
      end

      private

      attr_reader :tracker,
        :filter_evaluator,
        :hidden_evaluator

      # Checks if trace data is collectible.
      def collectible?(event)
        raise NotImplementedError
      end

      # Validates trace data against filters.
      def valid?(trace_data)
        filter_evaluator.pass?(trace_data)
      end

      # Checks if trace data should be hidden.
      def hidden?(trace_data)
        hidden_evaluator.pass?(trace_data)
      end

      # Builds trace data from the given data.
      def build_trace(event)
        raise NotImplementedError
      end

      def update_trace_depth(trace_data)
        raise NotImplementedError
      end

      def log_trace(trace_data)
        Loggers::TraceLogger.log(trace_data)
      end

      def store_trace(trace_data)
        @collection << trace_data
      end
    end
  end
end
