#!/usr/bin/env zsh

# Get the directory of the current script
SCRIPT_DIR=${0:a:h}
source "${SCRIPT_DIR}/../../utils.zsh"
source "${SCRIPT_DIR}/utils.zsh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "\n   Ruby Development Tools\n\n"

# Install rbenv for Ruby version management
brew_install "rbenv" "rbenv"
brew_install "ruby-build" "ruby-build"

# Add rbenv to shell configuration
if ! grep -q 'eval "$(rbenv init -)"' "$HOME/.zshrc"; then
    cat >> "$HOME/.zshrc" << 'EOL'

# rbenv configuration
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
EOL
fi

# Initialize rbenv
eval "$(rbenv init -)"

# Install latest Ruby versions
print_in_purple "\n   Installing Ruby Versions\n\n"
rbenv install 3.3.0
rbenv global 3.3.0

# Update RubyGems and install Bundler
print_in_purple "\n   Updating RubyGems and Installing Bundler\n\n"
gem update --system
gem install bundler

# Install global development tools
print_in_purple "\n   Installing Development Tools\n\n"

# Package Management
gem install bundler
gem install rake

# Development Tools
gem install solargraph          # Language server
gem install rubocop            # Linter
gem install ruby-debug-ide    # Debugger
gem install debase           # Debugger
gem install fasterer        # Performance suggestions
gem install reek          # Code smell detector
gem install rails        # Web framework

# Testing Tools
gem install rspec
gem install minitest
gem install cucumber
gem install capybara
gem install selenium-webdriver

# Documentation Tools
gem install yard
gem install rdoc

# Web Development
gem install sinatra
gem install hanami
gem install rack

# Database Tools
gem install pg
gem install sqlite3
gem install redis

# CLI Tools
gem install thor
gem install commander
gem install tty

# Optional Development Tools
# Uncomment if needed
# gem install pry
# gem install byebug
# gem install factory_bot
# gem install faker
# gem install vcr
# gem install webmock
# gem install sidekiq

# Configure Bundler
bundle config --global jobs 4
bundle config --global path vendor/bundle

# Create default Gemfile template
cat > "$HOME/.gemfile_template" << 'EOL'
source "https://rubygems.org"

ruby File.read(".ruby-version").strip

# Add your dependencies here
# gem "rails"
# gem "pg"
# gem "puma"

group :development, :test do
  gem "rspec"
  gem "rubocop"
  gem "pry"
  gem "byebug"
end

group :development do
  gem "solargraph"
  gem "ruby-debug-ide"
  gem "debase"
end

group :test do
  gem "minitest"
  gem "capybara"
  gem "selenium-webdriver"
end
EOL

# Add Ruby helper functions to shell
cat >> "$HOME/.zshrc" << 'EOL'

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

# Bundler aliases
alias b="bundle"
alias be="bundle exec"
alias bi="bundle install"
alias bu="bundle update"
alias bx="bundle exec"
EOL

print_result $? "Ruby development environment"
