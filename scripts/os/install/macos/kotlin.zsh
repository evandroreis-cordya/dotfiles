#!/usr/bin/env zsh

# Get the directory of the current script
SCRIPT_DIR=${0:a:h}
source "${SCRIPT_DIR}/../../utils.zsh"
source "${SCRIPT_DIR}/utils.zsh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "\n   Kotlin Development Tools\n\n"

# Install SDKMAN if not already installed
if [[ ! -s "$HOME/.sdkman/bin/sdkman-init.sh" ]]; then
    print_in_purple "\n   Installing SDKMAN\n\n"
    print_in_yellow "  [ ] SDKMAN"
    
    # Install SDKMAN with error handling
    curl -s "https://get.sdkman.io" | bash &> /dev/null
    if [[ $? -eq 0 && -s "$HOME/.sdkman/bin/sdkman-init.sh" ]]; then
        print_success "SDKMAN"
        # Source SDKMAN to make it available in this script
        source "$HOME/.sdkman/bin/sdkman-init.sh"
    else
        print_error "SDKMAN installation failed"
        exit 1
    fi
else
    print_success "SDKMAN (already installed)"
    # Source SDKMAN to make it available in this script
    source "$HOME/.sdkman/bin/sdkman-init.sh"
fi

# Verify sdk command is available
if ! command -v sdk &> /dev/null; then
    print_error "SDKMAN 'sdk' command not found. Please check your SDKMAN installation."
    exit 1
fi

# Install Kotlin
print_in_purple "\n   Installing Kotlin\n\n"
print_in_yellow "  [ ] Kotlin"
yes | sdk install kotlin &> /dev/null
print_result $? "Kotlin"

# Install build tools
print_in_purple "\n   Installing Build Tools\n\n"

# Install Gradle
print_in_yellow "  [ ] Gradle"
yes | sdk install gradle &> /dev/null
print_result $? "Gradle"

# Install Maven
print_in_yellow "  [ ] Maven"
yes | sdk install maven &> /dev/null
print_result $? "Maven"

# Install IntelliJ IDEA if not already installed
print_in_purple "\n   Installing IntelliJ IDEA\n\n"
if brew list --cask | grep -q "intellij-idea"; then
    print_success "IntelliJ IDEA (already installed)"
else
    print_in_yellow "  [ ] IntelliJ IDEA"
    brew install --cask intellij-idea &> /dev/null
    print_result $? "IntelliJ IDEA"
fi

# Install development tools
print_in_purple "\n   Installing Development Tools\n\n"

# Install Kotlin Language Server
if brew list | grep -q "kotlin-language-server"; then
    print_success "Kotlin Language Server (already installed)"
else
    print_in_yellow "  [ ] Kotlin Language Server"
    brew install kotlin-language-server &> /dev/null
    print_result $? "Kotlin Language Server"
fi

# Install ktlint
print_in_purple "\n   Installing Kotlin Linter\n\n"

# Check if ktlint is already installed
if command -v ktlint &> /dev/null; then
    print_success "ktlint (already installed)"
else
    print_in_yellow "  [ ] ktlint"
    brew install ktlint &> /dev/null
    print_result $? "ktlint"
fi

# Create a Kotlin project template
print_in_purple "\n   Creating Kotlin Project Template\n\n"
mkdir -p "$HOME/.kotlin_project_template/src/main/kotlin/com/example/app"
mkdir -p "$HOME/.kotlin_project_template/src/test/kotlin/com/example/app"

# Create a sample Main.kt file
cat > "$HOME/.kotlin_project_template/src/main/kotlin/com/example/app/Main.kt" << 'EOL'
package com.example.app

fun main() {
    println("Hello, Kotlin World!")
}
EOL

# Create a sample build.gradle.kts file
cat > "$HOME/.kotlin_project_template/build.gradle.kts" << 'EOL'
plugins {
    kotlin("jvm") version "1.9.0"
    application
}

group = "com.example"
version = "1.0-SNAPSHOT"

repositories {
    mavenCentral()
}

dependencies {
    testImplementation(kotlin("test"))
}

tasks.test {
    useJUnitPlatform()
}

kotlin {
    jvmToolchain(17)
}

application {
    mainClass.set("com.example.app.MainKt")
}
EOL

# Create a sample settings.gradle.kts file
cat > "$HOME/.kotlin_project_template/settings.gradle.kts" << 'EOL'
rootProject.name = "kotlin-app"
EOL

print_success "Kotlin project template"

# Add Kotlin helper functions to shell
if ! grep -q 'new-kotlin' "$HOME/.zshrc"; then
    print_in_purple "\n   Adding Kotlin Helper Functions\n\n"
    cat >> "$HOME/.zshrc" << 'EOL'

# Kotlin development functions
new-kotlin() {
    if [[ -n "$1" ]]; then
        mkdir -p "$1"
        cp -r "$HOME/.kotlin_project_template/"* "$1/"
        cd "$1"
        # Replace placeholder with actual project name
        sed -i '' "s/com.example/$1/g" build.gradle.kts
        sed -i '' "s/kotlin-app/$1/g" settings.gradle.kts
        mkdir -p "src/main/kotlin/${1//.//}"
        mkdir -p "src/test/kotlin/${1//.//}"
        mv src/main/kotlin/com/example/app/Main.kt "src/main/kotlin/${1//.//}/"
        sed -i '' "s/package com.example.app/package $1/g" "src/main/kotlin/${1//.//}/Main.kt"
        sed -i '' "s/com.example.app.MainKt/$1.MainKt/g" build.gradle.kts
        rm -rf src/main/kotlin/com
        rm -rf src/test/kotlin/com
        git init
        echo "build/" > .gitignore
        echo ".gradle/" >> .gitignore
        echo ".idea/" >> .gitignore
        echo "*.iml" >> .gitignore
        git add .
        git commit -m "Initial commit"
        echo "Kotlin project $1 created successfully!"
    else
        echo "Please provide a project name (e.g., com.example.myapp)"
    fi
}

# Kotlin aliases
alias ktc="kotlinc"
alias ktrun="kotlin"
alias ktcj="kotlinc-jvm"
alias gw="./gradlew"
alias gwb="./gradlew build"
alias gwt="./gradlew test"
alias gwr="./gradlew run"
EOL
    print_success "Kotlin helper functions"
fi

print_in_green "\n  Kotlin development environment setup complete!\n"
