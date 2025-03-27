#!/usr/bin/env zsh

# Get the directory of the current script
SCRIPT_DIR=${0:a:h}
source "${SCRIPT_DIR}/../../utils.zsh"
source "${SCRIPT_DIR}/utils.zsh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "\n   Java Development Tools\n\n"

# Install SDKMAN if not already installed
if [[ ! -s "$HOME/.sdkman/bin/sdkman-init.sh" ]]; then
    print_in_purple "\n   Installing SDKMAN\n\n"
    
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

# Install Java versions
print_in_purple "\n   Installing Java Versions\n\n"

# Install Java 21 (latest LTS)
yes | sdk install java 21.0.2-tem &> /dev/null
if [[ $? -eq 0 ]]; then
    print_success "Java 21 (Temurin)"
    
    # Set as default
    sdk default java 21.0.2-tem &> /dev/null
    print_result $? "Setting Java 21 as default"
else
    print_error "Java 21 (Temurin)"
fi

# Install Java 17 (previous LTS)
yes | sdk install java 17.0.9-tem &> /dev/null
if [[ $? -eq 0 ]]; then
    print_success "Java 17 (Temurin)"
else
    print_error "Java 17 (Temurin)"
fi

# Install Java 11 (older LTS for legacy projects)
yes | sdk install java 11.0.22-tem &> /dev/null
if [[ $? -eq 0 ]]; then
    print_success "Java 11 (Temurin)"
else
    print_error "Java 11 (Temurin)"
fi

# Install build tools
print_in_purple "\n   Installing Java Build Tools\n\n"

# Install Maven
yes | sdk install maven &> /dev/null
print_result $? "Maven"

# Install Gradle
yes | sdk install gradle &> /dev/null
print_result $? "Gradle"

# Install Ant
yes | sdk install ant &> /dev/null
print_result $? "Ant"

# Install development tools
print_in_purple "\n   Installing Java Development Tools\n\n"

# Install Spring Boot CLI
yes | sdk install springboot &> /dev/null
print_result $? "Spring Boot CLI"

# Install Quarkus CLI
yes | sdk install quarkus &> /dev/null
print_result $? "Quarkus CLI"

# Install JBang
yes | sdk install jbang &> /dev/null
print_result $? "JBang"

# Install VisualVM
yes | sdk install visualvm &> /dev/null
print_result $? "VisualVM"

# Configure Maven settings
print_in_purple "\n   Configuring Maven\n\n"

# Create Maven settings directory if it doesn't exist
mkdir -p "$HOME/.m2" &> /dev/null

# Create Maven settings.xml with sensible defaults
cat > "$HOME/.m2/settings.xml" << 'EOL'
<settings xmlns="http://maven.apache.org/SETTINGS/1.0.0"
          xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
          xsi:schemaLocation="http://maven.apache.org/SETTINGS/1.0.0
                             http://maven.apache.org/xsd/settings-1.0.0.xsd">
    <localRepository>${user.home}/.m2/repository</localRepository>
    <interactiveMode>true</interactiveMode>
    <usePluginRegistry>false</usePluginRegistry>
    <offline>false</offline>

    <mirrors>
        <mirror>
            <id>maven-default-http-blocker</id>
            <mirrorOf>external:http:*</mirrorOf>
            <name>Pseudo repository to mirror external repositories initially using HTTP.</name>
            <url>http://0.0.0.0/</url>
            <blocked>true</blocked>
        </mirror>
    </mirrors>

    <proxies>
    </proxies>

    <profiles>
        <profile>
            <id>standard-profile</id>
            <activation>
                <activeByDefault>true</activeByDefault>
            </activation>
            <properties>
                <maven.compiler.source>21</maven.compiler.source>
                <maven.compiler.target>21</maven.compiler.target>
                <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
                <project.reporting.outputEncoding>UTF-8</project.reporting.outputEncoding>
            </properties>
        </profile>
    </profiles>
</settings>
EOL
print_result $? "Maven configuration"

# Configure Gradle settings
print_in_purple "\n   Configuring Gradle\n\n"

# Create Gradle properties directory if it doesn't exist
mkdir -p "$HOME/.gradle" &> /dev/null

# Create gradle.properties with sensible defaults
cat > "$HOME/.gradle/gradle.properties" << 'EOL'
# Gradle memory settings
org.gradle.jvmargs=-Xmx2g -XX:MaxMetaspaceSize=512m -XX:+HeapDumpOnOutOfMemoryError
org.gradle.daemon=true
org.gradle.parallel=true
org.gradle.caching=true
org.gradle.configureondemand=true

# Kotlin settings
kotlin.incremental=true
kotlin.code.style=official

# Android settings (if applicable)
android.useAndroidX=true
android.enableJetifier=true
EOL
print_result $? "Gradle configuration"

# Add Java helper functions to shell
cat >> "$HOME/.zshrc" << 'EOL'

# Java development functions
new-spring() {
    if [[ -n "$1" ]]; then
        spring init --build=gradle --java-version=21 --dependencies=web,actuator,devtools --packaging=jar --name="$1" "$1"
        cd "$1"
        git init
        echo "# $1" > README.md
        echo ".gradle/" > .gitignore
        echo "build/" >> .gitignore
        echo ".idea/" >> .gitignore
        echo "*.iml" >> .gitignore
        echo "*.iws" >> .gitignore
        echo "*.ipr" >> .gitignore
        echo ".DS_Store" >> .gitignore
        git add .
        git commit -m "Initial commit"
    else
        echo "Please provide a project name"
    fi
}

# Java aliases
alias j="java"
alias jc="javac"
alias jj="java -jar"
alias mvn="mvn -T 1C"
alias mvnci="mvn clean install"
alias mvncp="mvn clean package"
alias mvnct="mvn clean test"
alias gw="./gradlew"
alias gwb="./gradlew build"
alias gwc="./gradlew clean"
alias gwcb="./gradlew clean build"
EOL
print_result $? "Java development environment"

# Install additional Java tools with Homebrew
brew_install "jenv" "jenv"  # Java version manager (alternative)
brew_install "openjdk" "openjdk"  # OpenJDK from Homebrew

print_in_green "\n  Java development environment setup complete!\n"
