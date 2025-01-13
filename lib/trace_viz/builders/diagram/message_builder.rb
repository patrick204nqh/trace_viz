# frozen_string_literal: true

require "trace_viz/managers/diagram/participant_manager"
require "trace_viz/models"
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

        def build_call_message(from_trace, to_trace)
          return if same_class?(from_trace, to_trace)

          build(
            :call,
            from: participant_for(from_trace),
            to: participant_for(to_trace),
            content: formatter.format_call,
          )
        end

        def build_return_message(from_trace, to_trace)
          return if same_class?(from_trace, to_trace)

          build(
            :return,
            from: participant_for(from_trace),
            to: participant_for(to_trace),
            content: formatter.format_return,
          )
        end

        def build_loop_start_message(trace)
          build(:loop_start, content: "#{trace.count} calls")
        end

        def build_loop_end_message
          build(:loop_end)
        end

        def build_activate_message(trace)
          build(:activate, to: participant_for(trace))
        end

        def build_deactivate_message(trace)
          build(:deactivate, to: participant_for(trace))
        end

        def build_internal_message(trace)
          build(
            :call,
            from: participant_for(trace),
            to: participant_for(trace),
            content: formatter.format_internal_message(trace),
          )
        end

        def build_note(trace)
          build(
            :note,
            from: participant_for(trace),
            to: participant_for(trace),
            content: trace.duration,
          )
        end

        private

        attr_reader :formatter, :participants_manager

        def build(type, from: nil, to: nil, content: "")
          Models::Message.new(
            type: type,
            from: from,
            to: to,
            content: content,
          )
        end

        def same_class?(from_trace, to_trace)
          from_trace.klass == to_trace.klass
        end

        def participant_for(trace)
          participants_manager.find(trace.klass)
        end
      end
    end
  end
end
