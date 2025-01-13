# frozen_string_literal: true

require "trace_viz/managers/diagram/participant_manager"
require "trace_viz/models/message"
require_relative "base_builder"

module TraceViz
  module Builders
    module Diagram
      class MessageBuilder < BaseBuilder
        def initialize(formatter, participants)
          super()
          @formatter = formatter
          @participants_manager = Managers::Diagram::ParticipantsManager.new(participants)
        end

        def build(type, from, to, content)
          Models::Message.new(type: type, from: from, to: to, content: content)
        end

        def build_call_message(from_trace, to_trace)
          return if from_trace.klass == to_trace.klass

          build(
            :call,
            participants_manager.find(from_trace.klass),
            participants_manager.find(to_trace.klass),
            formatter.format_call,
          )
        end

        def build_return_message(from_trace, to_trace)
          return if from_trace.klass == to_trace.klass

          build(
            :return,
            participants_manager.find(from_trace.klass),
            participants_manager.find(to_trace.klass),
            formatter.format_return,
          )
        end

        def build_loop_start_message(trace)
          build(:loop_start, nil, nil, "#{trace.count} calls")
        end

        def build_loop_end_message
          build(:loop_end, nil, nil, "")
        end

        def build_activate_message(trace)
          build(:activate, nil, participants_manager.find(trace.klass), "")
        end

        def build_deactivate_message(trace)
          build(:deactivate, nil, participants_manager.find(trace.klass), "")
        end

        def build_internal_message(trace)
          build(
            :call,
            participants_manager.find(trace.klass),
            participants_manager.find(trace.klass),
            trace.action,
          )
        end

        private

        attr_reader :formatter, :participants_manager
      end
    end
  end
end
