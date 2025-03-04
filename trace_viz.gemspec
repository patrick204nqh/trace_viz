# frozen_string_literal: true

lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "trace_viz/version"

Gem::Specification.new do |spec|
  spec.name = "trace_viz"
  spec.version = TraceViz::VERSION
  spec.authors = ["Huy Nguyen"]
  spec.email = ["patrick204nqh@gmail.com"]

  spec.summary = "Trace method and attribute usage in Ruby classes and generate diagrams."
  spec.description = <<~DESC
    TraceViz is a Ruby library designed to trace and visualize events executed#{" "}
    in a block of code. Useful for debugging and logging.
  DESC
  spec.homepage = "https://github.com/patrick204nqh/trace_viz"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.0.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = "https://github.com/patrick204nqh/trace_viz/blob/main/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  gemspec = File.basename(__FILE__)
  spec.files = IO.popen(["git", "ls-files", "-z"], chdir: __dir__, err: IO::NULL) do |ls|
    ls.readlines("\x0", chomp: true).reject do |f|
      (f == gemspec) ||
        f.start_with?("bin/", "spec/", ".git", ".github", "Gemfile")
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"
end
