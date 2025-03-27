#!/bin/zsh
#
# Ruby configuration for zsh
# This file contains all Ruby-related configurations
#

# Ruby environment setup with rbenv
if command -v rbenv 1>/dev/null 2>&1; then
  export PATH="$HOME/.rbenv/bin:$PATH"
  eval "$(rbenv init -)"
fi

# Ruby aliases
alias be="bundle exec"
alias bi="bundle install"
alias bu="bundle update"
alias rb="ruby"
alias gem-update="gem update --system && gem update && gem cleanup"

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
    
    # Create Gemfile
    cat > Gemfile << EOF
source 'https://rubygems.org'

gem 'rspec', '~> 3.10'
EOF
    
    # Create lib directory and main file
    mkdir -p lib
    cat > "lib/${project_name}.rb" << EOF
# Main module for ${project_name}
module ${project_name^}
  VERSION = '0.1.0'
  
  # Your code goes here...
end
EOF
    
    # Create spec directory and spec helper
    mkdir -p spec
    cat > spec/spec_helper.rb << EOF
require '${project_name}'
EOF
    
    # Create README.md
    cat > README.md << EOF
# ${project_name^}

A Ruby project.

## Installation

Add this line to your application's Gemfile:

\`\`\`ruby
gem '${project_name}'
\`\`\`

And then execute:

    $ bundle install

## Usage

TODO: Write usage instructions here.

## Development

After checking out the repo, run \`bin/setup\` to install dependencies. Then, run \`rake spec\` to run the tests.

## License

The gem is available as open source under the terms of the MIT License.
EOF
    
    # Create .gitignore
    cat > .gitignore << EOF
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
    
    # Initialize bundler
    bundle init
    
    echo "Ruby project '${project_name}' created successfully!"
}
