#!/usr/bin/env zsh

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && source "../../utils.zsh" \
    && source "./utils.zsh"

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
            <n>Pseudo repository to mirror external repositories initially using HTTP.</n>
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

# Create modular configuration file for Java
create_java_config() {
    local config_dir="$HOME/.jarvistoolset/zsh_configs"
    local config_file="$config_dir/java.zsh"
    
    # Create directory if it doesn't exist
    mkdir -p "$config_dir"
    
    # Create Java configuration file
    cat > "$config_file" << 'EOL'
#!/bin/zsh
#
# Java configuration for zsh
# This file contains all Java-related configurations
#

# SDKMAN configuration
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

# Java aliases
alias j="java"
alias jc="javac"
alias jshell="jshell"
alias mvn="mvn"
alias mvnw="./mvnw"
alias gradle="gradle"
alias gradlew="./gradlew"
alias gw="./gradlew"
alias gwb="./gradlew build"
alias gwt="./gradlew test"
alias gwr="./gradlew run"

# Java project creation functions
new-spring() {
    if [[ -n "$1" ]]; then
        spring init --build=gradle --java-version=21 --dependencies=web,actuator,devtools --packaging=jar --name="$1" "$1"
        cd "$1" || return
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
        echo "Spring Boot project $1 created successfully!"
    else
        echo "Please provide a project name"
    fi
}

new-quarkus() {
    if [[ -n "$1" ]]; then
        quarkus create app "$1"
        cd "$1" || return
        git init
        echo "# $1" > README.md
        echo ".gradle/" >> .gitignore
        echo "build/" >> .gitignore
        echo ".idea/" >> .gitignore
        echo "*.iml" >> .gitignore
        echo "*.iws" >> .gitignore
        echo "*.ipr" >> .gitignore
        echo ".DS_Store" >> .gitignore
        git add .
        git commit -m "Initial commit"
        echo "Quarkus project $1 created successfully!"
    else
        echo "Please provide a project name"
    fi
}

new-java() {
    if [ $# -lt 1 ]; then
        echo "Usage: new-java <project-name> [--gradle|--maven]"
        return 1
    fi
    
    local project_name=$1
    local build_tool=${2:-"--gradle"}
    
    # Create project directory
    mkdir -p "$project_name"
    cd "$project_name" || return
    
    # Create basic project structure
    mkdir -p src/main/java/com/example
    mkdir -p src/test/java/com/example
    mkdir -p src/main/resources
    
    # Create main application file
    cat > "src/main/java/com/example/App.java" << EOF
package com.example;

/**
 * Main application class
 */
public class App {
    public String getGreeting() {
        return "Hello, World!";
    }

    public static void main(String[] args) {
        System.out.println(new App().getGreeting());
    }
}
EOF
    
    # Create test file
    cat > "src/test/java/com/example/AppTest.java" << EOF
package com.example;

import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.*;

public class AppTest {
    @Test
    public void testAppGreeting() {
        App app = new App();
        assertEquals("Hello, World!", app.getGreeting());
    }
}
EOF
    
    if [[ "$build_tool" == "--gradle" ]]; then
        # Create build.gradle file
        cat > "build.gradle" << EOF
plugins {
    id 'java'
    id 'application'
}

group = 'com.example'
version = '1.0-SNAPSHOT'

repositories {
    mavenCentral()
}

dependencies {
    testImplementation 'org.junit.jupiter:junit-jupiter:5.9.1'
    testRuntimeOnly 'org.junit.platform:junit-platform-launcher'
}

application {
    mainClass = 'com.example.App'
}

java {
    toolchain {
        languageVersion = JavaLanguageVersion.of(21)
    }
}

tasks.named('test') {
    useJUnitPlatform()
}
EOF
        
        # Create settings.gradle file
        cat > "settings.gradle" << EOF
rootProject.name = '$project_name'
EOF
        
        # Create gradle wrapper
        if command -v gradle >/dev/null 2>&1; then
            gradle wrapper
        fi
        
    elif [[ "$build_tool" == "--maven" ]]; then
        # Create pom.xml file
        cat > "pom.xml" << EOF
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
    <modelVersion>4.0.0</modelVersion>

    <groupId>com.example</groupId>
    <artifactId>$project_name</artifactId>
    <version>1.0-SNAPSHOT</version>

    <properties>
        <maven.compiler.source>21</maven.compiler.source>
        <maven.compiler.target>21</maven.compiler.target>
        <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
    </properties>

    <dependencies>
        <dependency>
            <groupId>org.junit.jupiter</groupId>
            <artifactId>junit-jupiter</artifactId>
            <version>5.9.1</version>
            <scope>test</scope>
        </dependency>
    </dependencies>

    <build>
        <plugins>
            <plugin>
                <groupId>org.apache.maven.plugins</groupId>
                <artifactId>maven-compiler-plugin</artifactId>
                <version>3.11.0</version>
            </plugin>
            <plugin>
                <groupId>org.apache.maven.plugins</groupId>
                <artifactId>maven-surefire-plugin</artifactId>
                <version>3.1.2</version>
            </plugin>
            <plugin>
                <groupId>org.apache.maven.plugins</groupId>
                <artifactId>maven-jar-plugin</artifactId>
                <version>3.3.0</version>
                <configuration>
                    <archive>
                        <manifest>
                            <addClasspath>true</addClasspath>
                            <mainClass>com.example.App</mainClass>
                        </manifest>
                    </archive>
                </configuration>
            </plugin>
        </plugins>
    </build>
</project>
EOF
    fi
    
    # Create README.md
    cat > "README.md" << EOF
# $project_name

A Java project.

## Building

\`\`\`bash
# For Gradle
./gradlew build

# For Maven
mvn package
\`\`\`

## Running

\`\`\`bash
# For Gradle
./gradlew run

# For Maven
mvn exec:java -Dexec.mainClass="com.example.App"
\`\`\`

## Testing

\`\`\`bash
# For Gradle
./gradlew test

# For Maven
mvn test
\`\`\`
EOF
    
    # Create .gitignore
    cat > ".gitignore" << EOF
# Gradle
.gradle/
build/
gradle-app.setting
!gradle-wrapper.jar
.gradletasknamecache

# Maven
target/
pom.xml.tag
pom.xml.releaseBackup
pom.xml.versionsBackup
pom.xml.next
release.properties
dependency-reduced-pom.xml
buildNumber.properties
.mvn/timing.properties

# IntelliJ IDEA
.idea/
*.iml
*.iws
*.ipr
out/

# VS Code
.vscode/
.settings/
.classpath
.project

# Mac
.DS_Store
EOF
    
    # Initialize git repository if git is available
    if command -v git >/dev/null 2>&1; then
        git init
        git add .
        git commit -m "Initial commit"
    fi
    
    echo "Java project '$project_name' created successfully!"
}

# Java version management functions
java-use() {
    if [[ -n "$1" ]]; then
        sdk use java "$1"
    else
        echo "Please provide a Java version"
        sdk list java
    fi
}

java-default() {
    if [[ -n "$1" ]]; then
        sdk default java "$1"
    else
        echo "Please provide a Java version"
        sdk list java
    fi
}

java-install() {
    if [[ -n "$1" ]]; then
        sdk install java "$1"
    else
        echo "Please provide a Java version"
        sdk list java
    fi
}

java-list() {
    sdk list java
}
EOL
    
    print_result $? "Created Java configuration file"
}

# Create modular configuration
create_java_config

# Check if oh-my-zsh.zsh is already sourcing the modular configs
if ! grep -q "source \"\$HOME/.jarvistoolset/zsh_configs/java.zsh\"" "$HOME/.zshrc"; then
    # Add a line to source the Java config in .zshrc if oh-my-zsh.zsh isn't handling it
    cat >> "$HOME/.zshrc" << 'EOL'
# Load Java configuration
source "$HOME/.jarvistoolset/zsh_configs/java.zsh"
EOL
    print_result $? "Added Java configuration to .zshrc"
fi

print_in_green "\n  Java development environment setup complete!\n"
