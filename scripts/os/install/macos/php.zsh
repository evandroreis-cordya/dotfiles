#!/usr/bin/env zsh

# Get the directory of the current script
SCRIPT_DIR=${0:a:h}
source "${SCRIPT_DIR}/../../utils.zsh"
source "${SCRIPT_DIR}/utils.zsh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "\n   PHP Development Tools\n\n"

# Install PHP and core extensions
brew_install "PHP" "php"
brew_install "Composer" "composer"

# PHP Version Manager
brew_install "PHP Version Manager" "phpenv"

# Install common PHP extensions
print_in_purple "\n   Installing PHP Extensions\n\n"

brew_install "ImageMagick" "imagemagick"
brew_install "PHP ImageMagick Extension" "php-imagick"
brew_install "PHP XDebug" "php-xdebug"
brew_install "PHP Redis" "php-redis"
brew_install "PHP Memcached" "php-memcached"
brew_install "PHP MongoDB" "php-mongodb"

# Development Tools
print_in_purple "\n   Installing Development Tools\n\n"

# Install Laravel installer
composer global require laravel/installer
composer global require laravel/valet

# Install Symfony CLI
brew_install "Symfony CLI" "symfony-cli"

# Install development tools
composer global require "squizlabs/php_codesniffer"
composer global require "phpstan/phpstan"
composer global require "phpunit/phpunit"
composer global require "friendsofphp/php-cs-fixer"
composer global require "phan/phan"
composer global require "vimeo/psalm"
composer global require "phpmd/phpmd"
composer global require "infection/infection"

# Optional Development Tools
# Uncomment if needed
# composer global require "drupal/console"
# composer global require "wp-cli/wp-cli"
# composer global require "drush/drush"
# composer global require "codeception/codeception"
# composer global require "behat/behat"

# Configure PHP
PHP_INI_PATH="/usr/local/etc/php/php.ini"
if [[ ! -f "$PHP_INI_PATH" ]]; then
    cp "/usr/local/etc/php/php.ini.default" "$PHP_INI_PATH"
fi

# Update PHP configuration
cat >> "$PHP_INI_PATH" << 'EOL'

; Custom PHP settings
memory_limit = 512M
post_max_size = 100M
upload_max_filesize = 100M
max_execution_time = 300
max_input_time = 300
display_errors = On
error_reporting = E_ALL
log_errors = On
error_log = /usr/local/var/log/php_errors.log
date.timezone = America/Los_Angeles
opcache.enable = 1
opcache.memory_consumption = 128
opcache.interned_strings_buffer = 8
opcache.max_accelerated_files = 4000
opcache.revalidate_freq = 60
opcache.fast_shutdown = 1
EOL

# Create PHP error log
touch /usr/local/var/log/php_errors.log
chmod 666 /usr/local/var/log/php_errors.log

# Configure Composer
composer config --global process-timeout 2000

# Add Composer bin directory to PATH
if ! grep -q "export PATH=\"\$HOME/.composer/vendor/bin:\$PATH\"" "$HOME/.zshrc"; then
    echo 'export PATH="$HOME/.composer/vendor/bin:$PATH"' >> "$HOME/.zshrc"
fi

print_result $? "PHP development environment"

# Start PHP-FPM
brew services start php

print_result $? "PHP-FPM service"
