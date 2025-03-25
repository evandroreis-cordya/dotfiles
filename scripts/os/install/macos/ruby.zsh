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
rbenv_install "3.3.0" "true"

# Update RubyGems and install Bundler
print_in_purple "\n   Updating RubyGems and Installing Bundler\n\n"

# Use direct command execution instead of the execute function
print_in_yellow "  [ ] RubyGems"
gem update --system &> /dev/null
print_result $? "RubyGems"

gem_install "Bundler" "bundler"

# Install global development tools
print_in_purple "\n   Installing Development Tools\n\n"

# Package Management
gem_install "Bundler" "bundler"
gem_install "Rake" "rake"

# Development Tools
gem_install "Solargraph" "solargraph"          # Language server
gem_install "RuboCop" "rubocop"                # Linter
gem_install "Ruby Debug IDE" "ruby-debug-ide"  # Debugger
gem_install "Debase" "debase"                  # Debugger
gem_install "Fasterer" "fasterer"              # Performance suggestions
gem_install "Reek" "reek"                      # Code smell detector
gem_install "Rails" "rails"                    # Web framework

# Testing Tools
gem_install "RSpec" "rspec"
gem_install "Minitest" "minitest"
gem_install "Cucumber" "cucumber"
gem_install "Capybara" "capybara"
gem_install "Selenium WebDriver" "selenium-webdriver"

# Documentation Tools
gem_install "YARD" "yard"
gem_install "SDoc" "sdoc"

# Web Development
gem_install "Sinatra" "sinatra"
gem_install "Rack" "rack"
gem_install "Puma" "puma"

# Fix Thin gem installation
print_in_yellow "  [ ] Thin"
gem install thin --no-document &> /dev/null || gem install thin --no-document --conservative &> /dev/null
print_result $? "Thin"

# Database Tools
gem_install "ActiveRecord" "activerecord"
gem_install "Sequel" "sequel"
gem_install "PG" "pg"

# Fix MySQL2 gem installation
print_in_yellow "  [ ] MySQL2"
gem install mysql2 --no-document &> /dev/null || gem install mysql2 --no-document --conservative &> /dev/null
print_result $? "MySQL2"

gem_install "SQLite3" "sqlite3"

# API Development
gem_install "Grape" "grape"
gem_install "Jbuilder" "jbuilder"
gem_install "GraphQL" "graphql"

# Background Processing
gem_install "Sidekiq" "sidekiq"
gem_install "Resque" "resque"
gem_install "Delayed Job" "delayed_job"

# Utility Tools
gem_install "Nokogiri" "nokogiri"
gem_install "HTTParty" "httparty"
gem_install "Faraday" "faraday"
gem_install "JSON" "json"
gem_install "YAML" "yaml"
gem_install "Thor" "thor"

# DevOps Tools
print_in_yellow "  [ ] Capistrano"
gem install capistrano &> /dev/null
print_result $? "Capistrano"

print_in_yellow "  [ ] Mina"
gem install mina &> /dev/null
print_result $? "Mina"

print_in_yellow "  [ ] Puppet"
gem install puppet &> /dev/null
print_result $? "Puppet"

print_in_yellow "  [ ] Chef"
gem install chef &> /dev/null
print_result $? "Chef"

# Security Tools
print_in_yellow "  [ ] Brakeman"
gem install brakeman &> /dev/null
print_result $? "Brakeman"

print_in_yellow "  [ ] Bundler Audit"
gem install bundler-audit &> /dev/null
print_result $? "Bundler Audit"

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
