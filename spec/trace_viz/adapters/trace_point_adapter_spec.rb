# frozen_string_literal: true

RSpec.describe(TraceViz::Adapters::TracePointAdapter) do
  let(:output) { StringIO.new }

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
    it "creates a TracePointAdapter instance" do
      expect(described_class.new).to(be_instance_of(described_class))
    end

    it "creates a TracePointAdapter instance that inherits from BaseAdapter" do
      expect(described_class.new).to(be_kind_of(TraceViz::Adapters::BaseAdapter))
    end
  end

  describe "#trace" do
    it "traces the block" do
      TraceViz::Context::Manager.enter_context(:config)
      described_class.new.trace do
        puts("Hello, world!")
      end
      TraceViz::Context::Manager.exit_context(:config)

      expect(output.string).to(include("Hello, world!"))
    end
  end
end
