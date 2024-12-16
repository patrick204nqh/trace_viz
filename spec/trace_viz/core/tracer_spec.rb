# frozen_string_literal: true

RSpec.describe(TraceViz::Core::Tracer) do
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
    it "creates a Core::Tracer instance" do
      expect(described_class.new).to(be_instance_of(described_class))
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
