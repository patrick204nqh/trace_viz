# frozen_string_literal: true

require "trace_viz/transformers/summary_transformer"
require "trace_viz/formatters/diagram/sequence/message_formatter"
require "trace_viz/builders/diagram/message_builder"
require "trace_viz/managers/diagram/participant_manager"
require_relative "../base_extractor"

module TraceViz
  module Extractors
    module Diagram
      class MessageExtractor < BaseExtractor
        def initialize(collector, participants)
          super(collector)

          @formatter = Formatters::Diagram::Sequence::MessageFormatter.new
          @message_builder = Builders::Diagram::MessageBuilder.new(@formatter, participants)
          @participants_manager = Managers::Diagram::ParticipantsManager.new(participants)
        end

        def extract
          root = data
          root.children.flat_map { |child| process_node(child, nil) }
        end

        private

        attr_reader :message_builder, :participants_manager

        def process_node(node, caller_node)
          trace = node.data
          caller_trace = caller_node&.data

          [].tap do |messages|
            messages << handle_inter_participant_message(caller_trace, trace)
            messages << handle_loop_start(trace)
            messages << handle_internal_message(trace)
            messages << handle_activation(trace)
            messages.concat(process_children(node))
            messages << handle_deactivation(trace)
            messages << handle_loop_end(trace)
            messages << handle_return_message(trace, caller_trace)
          end.compact
        end

        # Handle inter-participant messages
        def handle_inter_participant_message(caller_trace, trace)
          return unless caller_trace

          message_builder.build_call_message(caller_trace, trace)
        end

        # Handle loop start messages
        def handle_loop_start(trace)
          return unless loop?(trace)

          message_builder.build_loop_start_message(trace)
        end

        # Handle internal messages
        def handle_internal_message(trace)
          message_builder.build_internal_message(trace)
        end

        # Handle activation of participants
        def handle_activation(trace)
          return unless node_has_children?(trace)

          message_builder.build_activate_message(trace)
        end

        # Handle deactivation of participants
        def handle_deactivation(trace)
          return unless node_has_children?(trace)

          message_builder.build_deactivate_message(trace)
        end

        # Handle loop end messages
        def handle_loop_end(trace)
          return unless loop?(trace)

          message_builder.build_loop_end_message
        end

        # Handle return messages
        def handle_return_message(trace, caller_trace)
          return unless caller_trace

          message_builder.build_return_message(trace, caller_trace)
        end

        # Process child nodes recursively
        def process_children(node)
          node.children.flat_map { |child| process_node(child, node) }
        end

        # -- Helper methods for logic --

        def loop?(trace)
          trace.key == :summary_group
        end

        def node_has_children?(trace)
          trace.children.any?
        end

        def data
          @data ||= Transformers::SummaryTransformer.new(collector).transform
        end
      end
    end
  end
end
