# frozen_string_literal: true

require "trace_viz/context"
require_relative "id_generator"

module TraceViz
  module TraceData
    class Base
      attr_reader :config,
        :timestamp
      attr_accessor :depth

      def initialize
        @config = Context.for(:config).configuration

        @depth = 0
        record_timestamp
        populate_trace_attributes
        assign_ids
      end

      # Shared ID betweem events for the same method call
      def action_id
        raise NotImplementedError
      end

      def memory_id
        raise NotImplementedError
      end

      def action
        raise NotImplementedError
      end

      def event
        raise NotImplementedError
      end

      def path
        raise NotImplementedError
      end

      def line_number
        raise NotImplementedError
      end

      def klass
        raise NotImplementedError
      end

      private

      def record_timestamp
        @timestamp = Time.now
      end

      def assign_ids
        @id = IDGenerator.generate_unique_id(
          memory_id: memory_id,
          action: action,
          path: path,
          line_number: line_number,
        )

        @action_id = IDGenerator.generate_action_id(
          memory_id: memory_id,
          action: action,
        )
      end

      def populate_trace_attributes
        raise NotImplementedError
      end
    end
  end
end
