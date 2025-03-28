#!/bin/zsh
#
# Ruby configuration for zsh
# This file contains all Ruby-related configurations
#

# Ruby environment variables
export RBENV_ROOT="$HOME/.rbenv"
export PATH="$RBENV_ROOT/bin:$PATH"
export PATH="$RBENV_ROOT/shims:$PATH"
export PATH="$HOME/.gem/ruby/3.0.0/bin:$PATH"

# Initialize rbenv
if command -v rbenv 1>/dev/null 2>&1; then
    eval "$(rbenv init -)"
fi

# Ruby aliases
alias rb="ruby"
alias gem-update="gem update --system"
alias bundle-update="bundle update"
alias bundle-install="bundle install"
alias bundle-exec="bundle exec"
alias be="bundle exec"
alias bi="bundle install"
alias bu="bundle update"
alias bx="bundle exec"
alias b="bundle"

# Ruby development functions
mkrepo() {
    if [[ -n "$1" ]]; then
        mkdir "$1"
        cd "$1"
        git init
        rbenv local 3.3.0
        echo "3.3.0" > .ruby-version
        cp "$HOME/.gemfile_template" Gemfile
        bundle install
        git add .
        git commit -m "Initial commit"
    else
        echo "Please provide a project name"
    fi
}

# Ruby project creation function
new-ruby() {
    if [ $# -lt 1 ]; then
        echo "Usage: new-ruby <project-name>"
        return 1
    fi
    
    local project_name=$1
    
    # Create project directory
    mkdir -p "$project_name"
    cd "$project_name" || return
    
    # Initialize bundler
    bundle init
    
    # Create basic project structure
    mkdir -p lib bin spec
    
    # Create main lib file
    cat > "lib/${project_name}.rb" << EOF
# Main module for ${project_name}
module $(echo "${project_name}" | sed -r 's/(^|_)([a-z])/\U\2/g')
  VERSION = '0.1.0'
end
EOF
    
    # Create executable
    cat > "bin/${project_name}" << EOF
#!/usr/bin/env ruby

require_relative '../lib/${project_name}'

# Your code here
EOF
    chmod +x "bin/${project_name}"
    
    # Create spec helper
    cat > "spec/spec_helper.rb" << EOF
require 'bundler/setup'
require '${project_name}'

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on \`Module\` and \`main\`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
EOF
    
    # Create main spec file
    cat > "spec/${project_name}_spec.rb" << EOF
require 'spec_helper'

RSpec.describe $(echo "${project_name}" | sed -r 's/(^|_)([a-z])/\U\2/g') do
  it "has a version number" do
    expect($(echo "${project_name}" | sed -r 's/(^|_)([a-z])/\U\2/g')::VERSION).not_to be nil
  end
end
EOF
    
    # Update Gemfile
    cat > "Gemfile" << EOF
source "https://rubygems.org"

# Specify your gem's dependencies in ${project_name}.gemspec
gemspec

gem "rake", "~> 13.0"
gem "rspec", "~> 3.0"
gem "rubocop", "~> 1.21"
EOF
    
    # Create gemspec
    cat > "${project_name}.gemspec" << EOF
# frozen_string_literal: true

Gem::Specification.new do |spec|
  spec.name = "${project_name}"
  spec.version = "0.1.0"
  spec.authors = ["Your Name"]
  spec.email = ["your.email@example.com"]

  spec.summary = "A short summary of your gem"
  spec.description = "A longer description of your gem"
  spec.homepage = "https://github.com/username/${project_name}"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = "\#{spec.homepage}/blob/main/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The \`git ls-files -z\` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    \`git ls-files -z\`.split("\\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir = "bin"
  spec.executables = spec.files.grep(%r{\Abin/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
end
EOF
    
    # Create README
    cat > "README.md" << EOF
# ${project_name}

A Ruby project.

## Installation

\`\`\`bash
gem install ${project_name}
\`\`\`

## Usage

\`\`\`ruby
require '${project_name}'
# Your code here
\`\`\`

## Development

After checking out the repo, run \`bin/setup\` to install dependencies. Then, run \`rake spec\` to run the tests. You can also run \`bin/console\` for an interactive prompt that will allow you to experiment.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
EOF
    
    # Create .gitignore
    cat > ".gitignore" << EOF
/.bundle/
/.yardoc
/_yardoc/
/coverage/
/doc/
/pkg/
/spec/reports/
/tmp/
*.gem
EOF
    
    # Initialize git repository if git is available
    if command -v git >/dev/null 2>&1; then
        git init
        git add .
        git commit -m "Initial commit"
    fi
    
    echo "Ruby project '${project_name}' created successfully!"
}
