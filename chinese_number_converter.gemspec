# frozen_string_literal: true

require_relative "lib/chinese_number_converter/version"

Gem::Specification.new do |spec|
  spec.name = "chinese_number_converter"
  spec.version = ChineseNumberConverter::VERSION
  spec.authors = ["alanyeh20001"]
  spec.email = ["alanyeh20001@hotmail.com"]

  spec.summary = "Convert chinese number to number."
  spec.description = "Convert number in chinese character, including chinese character aliases, to number."
  spec.homepage = "https://github.com/alanyeh20001/chinese_number_converter"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/alanyeh20001/chinese_number_converter"
  spec.metadata["changelog_uri"] = "https://github.com/alanyeh20001/chinese_number_converter/blob/main/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (File.expand_path(f) == __FILE__) || f.start_with?(*%w[bin/ test/ spec/ features/ .git .circleci appveyor])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
  spec.add_development_dependency 'rspec', '~> 3.13.0'
end
