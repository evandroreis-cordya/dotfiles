#!/usr/bin/env zsh

# Get the directory of the current script
SCRIPT_DIR=${0:a:h}
source "${SCRIPT_DIR}/../../utils.zsh"
source "${SCRIPT_DIR}/utils.zsh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "\n   Kotlin Development Tools\n\n"

# Install SDKMAN if not already installed
if [[ ! -d "$HOME/.sdkman" ]]; then
    curl -s "https://get.sdkman.io" | bash
    source "$HOME/.sdkman/bin/sdkman-init.sh"
fi

# Install Kotlin
print_in_purple "\n   Installing Kotlin\n\n"
sdk install kotlin

# Install build tools
print_in_purple "\n   Installing Build Tools\n\n"
sdk install gradle
sdk install maven

# Install IntelliJ IDEA if not already installed
if ! command -v idea &> /dev/null; then
    brew_install "IntelliJ IDEA" "intellij-idea" "--cask"
fi

# Install development tools
print_in_purple "\n   Installing Development Tools\n\n"

# Install Kotlin Language Server
brew_install "Kotlin Language Server" "kotlin-language-server"

# Install additional tools via npm
npm install -g kotlin-language-server

# Configure Kotlin environment
if ! grep -q 'KOTLIN_HOME' "$HOME/.zshrc"; then
    cat >> "$HOME/.zshrc" << 'EOL'

# Kotlin configuration
export KOTLIN_HOME="$HOME/.sdkman/candidates/kotlin/current"
export PATH="$KOTLIN_HOME/bin:$PATH"
EOL
fi

# Add Kotlin helper functions to shell
cat >> "$HOME/.zshrc" << 'EOL'

# Kotlin development functions
new-kotlin() {
    if [[ -n "$1" ]]; then
        mkdir -p "$1"
        cd "$1"
        
        # Initialize Gradle project
        gradle init --type kotlin-application --dsl kotlin --project-name "$1" --package "com.example.$1"
        
        # Update build.gradle.kts with common dependencies
        cat > build.gradle.kts << 'EOF'
plugins {
    kotlin("jvm") version "1.9.22"
    application
}

group = "com.example"
version = "1.0-SNAPSHOT"

repositories {
    mavenCentral()
}

dependencies {
    implementation(kotlin("stdlib"))
    implementation("org.jetbrains.kotlinx:kotlinx-coroutines-core:1.7.3")
    
    testImplementation(kotlin("test"))
    testImplementation("io.kotest:kotest-runner-junit5:5.8.0")
    testImplementation("io.kotest:kotest-assertions-core:5.8.0")
    testImplementation("io.mockk:mockk:1.13.9")
}

tasks.test {
    useJUnitPlatform()
}

kotlin {
    jvmToolchain(21)
}

application {
    mainClass.set("com.example.${1}.MainKt")
}
EOF

        # Create .gitignore
        cat > .gitignore << 'EOF'
.gradle
build/
!gradle/wrapper/gradle-wrapper.jar
!**/src/main/**/build/
!**/src/test/**/build/

### IntelliJ IDEA ###
.idea/
*.iws
*.iml
*.ipr
out/
!**/src/main/**/out/
!**/src/test/**/out/

### VS Code ###
.vscode/

### Mac OS ###
.DS_Store
EOF

        # Initialize git repository
        git init
        git add .
        git commit -m "Initial commit"
        
        print_in_green "\nKotlin project '$1' created successfully!\n"
    else
        echo "Please provide a project name"
    fi
}

# Kotlin aliases
alias kt="kotlin"
alias kc="kotlinc"
alias kj="kotlinc-jvm"
alias kr="kotlin -classpath"

# Gradle aliases for Kotlin
alias gw="./gradlew"
alias gwb="./gradlew build"
alias gwc="./gradlew clean"
alias gwt="./gradlew test"
alias gwi="./gradlew install"
alias gwci="./gradlew clean install"
alias gwcb="./gradlew clean build"
alias gwrun="./gradlew run"
EOL

print_result $? "Kotlin development environment"

# Install additional tools
brew_install "ktlint" "ktlint"  # Kotlin linter
