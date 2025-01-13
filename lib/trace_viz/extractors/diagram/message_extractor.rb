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
          root.children.flat_map { |child| traverse(child, nil) }
        end

        private

        attr_reader :message_builder, :participants_manager

        def traverse(node, caller_node)
          trace = node.data
          caller_trace = caller_node&.data

          messages = []

          # Handle inter-participant messages
          messages << handle_call_message(caller_trace, trace)

          # Handle loop structures
          messages << message_builder.build_loop_start_message(trace) if loop?(trace)

          # Internal message
          messages << message_builder.build_internal_message(trace)

          # Activation of participant
          messages << message_builder.build_activate_message(trace) if node_has_children?(trace)

          # Process child nodes
          messages.concat(process_children(node))

          # Deactivation of participant
          messages << message_builder.build_deactivate_message(trace) if node_has_children?(trace)

          # End loop structures
          messages << message_builder.build_loop_end_message if loop?(trace)

          # Handle return messages
          messages << handle_return_message(caller_trace, trace)

          messages.compact
        end

        def handle_call_message(caller_trace, current_trace)
          return unless caller_trace

          from_participant = participants_manager.find(caller_trace.klass)
          to_participant = participants_manager.find(current_trace.klass)

          if from_participant != to_participant
            message_builder.build_call_message(caller_trace, current_trace)
          end
        end

        def handle_return_message(caller_trace, current_trace)
          return unless caller_trace

          from_participant = participants_manager.find(caller_trace.klass)
          to_participant = participants_manager.find(current_trace.klass)

          if from_participant != to_participant
            message_builder.build_return_message(current_trace, caller_trace)
          end
        end

        def process_children(node)
          node.children.flat_map { |child| traverse(child, node) }
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
