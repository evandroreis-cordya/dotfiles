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

# Install Java versions
print_in_purple "\n   Installing Java Versions\n\n"

# Install Java 21 (latest LTS)
print_in_yellow "  [ ] Java 21 (Temurin)"
yes | sdk install java 21.0.2-tem &> /dev/null
if [[ $? -eq 0 ]]; then
    print_success "Java 21 (Temurin)"
    
    # Set as default
    print_in_yellow "  [ ] Setting Java 21 as default"
    sdk default java 21.0.2-tem &> /dev/null
    print_result $? "Setting Java 21 as default"
else
    print_error "Java 21 installation failed"
fi

# Install Java 17 (previous LTS)
print_in_yellow "  [ ] Java 17 (Temurin)"
yes | sdk install java 17.0.10-tem &> /dev/null
print_result $? "Java 17 (Temurin)"

# Install build tools
print_in_purple "\n   Installing Build Tools\n\n"

# Install Maven
print_in_yellow "  [ ] Maven"
yes | sdk install maven &> /dev/null
print_result $? "Maven"

# Install Gradle
print_in_yellow "  [ ] Gradle"
yes | sdk install gradle &> /dev/null
print_result $? "Gradle"

# Install Ant
print_in_yellow "  [ ] Ant"
yes | sdk install ant &> /dev/null
print_result $? "Ant"

# Install Spring Boot CLI
print_in_purple "\n   Installing Spring Boot CLI\n\n"
print_in_yellow "  [ ] Spring Boot CLI"
yes | sdk install springboot &> /dev/null
print_result $? "Spring Boot CLI"

# Install additional JVM languages
print_in_purple "\n   Installing JVM Languages\n\n"

# Install Kotlin
print_in_yellow "  [ ] Kotlin"
yes | sdk install kotlin &> /dev/null
print_result $? "Kotlin"

# Install Groovy
print_in_yellow "  [ ] Groovy"
yes | sdk install groovy &> /dev/null
print_result $? "Groovy"

# Install Scala
print_in_yellow "  [ ] Scala"
yes | sdk install scala &> /dev/null
print_result $? "Scala"

# Install additional development tools via Homebrew
print_in_purple "\n   Installing Additional Development Tools\n\n"
brew_install "jEnv" "jenv"                     # Java version manager

# Add Java environment configuration
if ! grep -q 'JAVA_HOME' "$HOME/.zshrc"; then
    print_in_purple "\n   Configuring Java Environment\n\n"
    cat >> "$HOME/.zshrc" << 'EOL'

# Java configuration
export JAVA_HOME=$(/usr/libexec/java_home)
export PATH="$JAVA_HOME/bin:$PATH"

# Maven configuration (from SDKMAN)
export M2_HOME="$HOME/.sdkman/candidates/maven/current"
export PATH="$M2_HOME/bin:$PATH"

# Gradle configuration (from SDKMAN)
export GRADLE_HOME="$HOME/.sdkman/candidates/gradle/current"
export PATH="$GRADLE_HOME/bin:$PATH"
EOL
    print_success "Java environment configuration"
fi

# Configure Maven settings
print_in_purple "\n   Configuring Maven Settings\n\n"
mkdir -p "$HOME/.m2"
cat > "$HOME/.m2/settings.xml" << 'EOL'
<settings xmlns="http://maven.apache.org/SETTINGS/1.0.0"
          xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
          xsi:schemaLocation="http://maven.apache.org/SETTINGS/1.0.0
                             http://maven.apache.org/xsd/settings-1.0.0.xsd">
    <localRepository>${user.home}/.m2/repository</localRepository>
    <interactiveMode>true</interactiveMode>
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
    <profiles>
        <profile>
            <id>default</id>
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
print_success "Maven settings configuration"

# Create a sample Java project template
print_in_purple "\n   Creating Java Project Template\n\n"
mkdir -p "$HOME/.java_project_template/src/main/java/com/example/app"
mkdir -p "$HOME/.java_project_template/src/test/java/com/example/app"

# Create a sample Main.java file
cat > "$HOME/.java_project_template/src/main/java/com/example/app/Main.java" << 'EOL'
package com.example.app;

public class Main {
    public static void main(String[] args) {
        System.out.println("Hello, Java World!");
    }
}
EOL

# Create a sample pom.xml file
cat > "$HOME/.java_project_template/pom.xml" << 'EOL'
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
    <modelVersion>4.0.0</modelVersion>

    <groupId>com.example</groupId>
    <artifactId>app</artifactId>
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
            <version>5.10.0</version>
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
        </plugins>
    </build>
</project>
EOL
print_success "Java project template"

# Add Java helper functions to shell
if ! grep -q 'new-java' "$HOME/.zshrc"; then
    print_in_purple "\n   Adding Java Helper Functions\n\n"
    cat >> "$HOME/.zshrc" << 'EOL'

# Java development functions
new-java() {
    if [[ -n "$1" ]]; then
        mkdir -p "$1"
        cp -r "$HOME/.java_project_template/"* "$1/"
        cd "$1"
        # Replace placeholder with actual project name
        sed -i '' "s/com.example/$1/g" pom.xml
        sed -i '' "s/artifactId>app</artifactId>$1</g" pom.xml
        mkdir -p "src/main/java/${1//.//}"
        mkdir -p "src/test/java/${1//.//}"
        mv src/main/java/com/example/app/Main.java "src/main/java/${1//.//}/"
        sed -i '' "s/package com.example.app;/package $1;/g" "src/main/java/${1//.//}/Main.java"
        rm -rf src/main/java/com
        rm -rf src/test/java/com
        git init
        echo "target/" > .gitignore
        echo ".idea/" >> .gitignore
        echo "*.iml" >> .gitignore
        git add .
        git commit -m "Initial commit"
        echo "Java project $1 created successfully!"
    else
        echo "Please provide a project name (e.g., com.example.myapp)"
    fi
}

# Java aliases
alias mvnc="mvn clean"
alias mvnp="mvn package"
alias mvni="mvn install"
alias mvnt="mvn test"
alias mvnci="mvn clean install"
alias mvnct="mvn clean test"
alias mvncp="mvn clean package"
EOL
    print_success "Java helper functions"
fi

print_in_green "\n  Java development environment setup complete!\n"
