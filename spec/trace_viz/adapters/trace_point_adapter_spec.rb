# frozen_string_literal: true

RSpec.describe(TraceViz::Adapters::TracePointAdapter) do
  let(:output) { StringIO.new }

  include_context "with TraceViz contexts", config: {}

  before do
    # Redirect stdout to capture output
    allow($stdout).to(receive(:write) { |message| output.write(message) })
  end

  after do
    # Reset the captured output
    output.truncate(0)
    output.rewind
  end

  describe "#initialize" do
    subject { described_class.new }

    it { is_expected.to(be_instance_of(described_class)) }
    it { is_expected.to(be_kind_of(TraceViz::Adapters::BaseAdapter)) }
  end

  describe "#trace" do
    subject { described_class.new }

    it "traces the block" do
      subject.trace { puts "Hello, world!" }

      expect(output.string).to(include("Hello, world!"))
    end
  end
end
