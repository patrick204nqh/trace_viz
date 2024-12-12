# frozen_string_literal: true

RSpec.describe(TraceViz::Adapters::TracePointAdapter) do
  let(:output) { StringIO.new }
  let(:original_stdout) { $stdout }

  before do
    # Redirect stdout to capture output
    # $stdout = output
  end

  after do
    # Restore the original stdout
    $stdout = original_stdout
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
      described_class.new.trace do
        puts("Hello, world!")
      end

      expect(output.string).to(include("Hello, world!"))
    end

    context "with ComplexClass" do
      it "traces the block" do
        described_class.new.trace do
          complex = ComplexClass.new(value: 50)
          complex.process_data
        end

        expect(output.string).to(include("ComplexClass#process_data"))
      end
    end
  end
end
