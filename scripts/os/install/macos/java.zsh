#!/usr/bin/env zsh

# Get the directory of the current script
SCRIPT_DIR=${0:a:h}
source "${SCRIPT_DIR}/../../utils.zsh"
source "${SCRIPT_DIR}/utils.zsh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "\n   Java Development Tools\n\n"

# Install Java Version Manager
brew_install "SDKMAN" "sdkman-cli"

# Source SDKMAN
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

# Install Java versions
print_in_purple "\n   Installing Java Versions\n\n"
sdk install java 21.0.2-tem      # Latest LTS Temurin
sdk install java 17.0.10-tem     # Previous LTS
sdk default java 21.0.2-tem     # Set default version

# Install build tools
print_in_purple "\n   Installing Build Tools\n\n"
sdk install maven
sdk install gradle
sdk install ant

# Install Spring Boot CLI
sdk install springboot

# Install additional JVM languages
print_in_purple "\n   Installing JVM Languages\n\n"
sdk install kotlin
sdk install groovy
sdk install scala

# Install development tools
brew_install "jEnv" "jenv"       # Java version manager
brew_install "Maven" "maven"     # Build tool
brew_install "Gradle" "gradle"  # Build tool

# Optional Development Tools
# Uncomment if needed
# brew_install "Ant" "ant"      # Build tool
# brew_install "Tomcat" "tomcat" # Application server

# Add Java environment configuration
if ! grep -q 'JAVA_HOME' "$HOME/.zshrc"; then
    cat >> "$HOME/.zshrc" << 'EOL'

# Java configuration
export JAVA_HOME=$(/usr/libexec/java_home)
export PATH="$JAVA_HOME/bin:$PATH"

# Maven configuration
export MAVEN_HOME="/usr/local/opt/maven"
export PATH="$MAVEN_HOME/bin:$PATH"

# Gradle configuration
export GRADLE_HOME="/usr/local/opt/gradle"
export PATH="$GRADLE_HOME/bin:$PATH"
EOL
fi

# Configure Maven settings
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

# Configure Gradle
mkdir -p "$HOME/.gradle"
cat > "$HOME/.gradle/gradle.properties" << 'EOL'
org.gradle.daemon=true
org.gradle.parallel=true
org.gradle.configureondemand=true
org.gradle.jvmargs=-Xmx2048m -XX:MaxPermSize=512m -XX:+HeapDumpOnOutOfMemoryError -Dfile.encoding=UTF-8
EOL

# Add Java helper functions to shell
cat >> "$HOME/.zshrc" << 'EOL'

# Java development functions
new-spring() {
    if [[ -n "$1" ]]; then
        spring init \
            --build=gradle \
            --java-version=21 \
            --dependencies=web,actuator,devtools \
            --groupId=com.example \
            --artifactId="$1" \
            --name="$1" \
            --description="Spring Boot application" \
            --package-name="com.example.$1" \
            --packaging=jar \
            "$1"
        cd "$1"
        git init
        git add .
        git commit -m "Initial commit"
    else
        echo "Please provide a project name"
    fi
}

new-maven() {
    if [[ -n "$1" ]]; then
        mvn archetype:generate \
            -DgroupId=com.example \
            -DartifactId="$1" \
            -DarchetypeArtifactId=maven-archetype-quickstart \
            -DarchetypeVersion=1.4 \
            -DinteractiveMode=false
        cd "$1"
        git init
        git add .
        git commit -m "Initial commit"
    else
        echo "Please provide a project name"
    fi
}

# Java aliases
alias mvnc="mvn clean"
alias mvnp="mvn package"
alias mvni="mvn install"
alias mvnt="mvn test"
alias mvnd="mvn deploy"
alias mvnci="mvn clean install"
alias mvncp="mvn clean package"
alias mvnct="mvn clean test"

# Gradle aliases
alias gw="./gradlew"
alias gwb="./gradlew build"
alias gwc="./gradlew clean"
alias gwt="./gradlew test"
alias gwi="./gradlew install"
alias gwci="./gradlew clean install"
alias gwcb="./gradlew clean build"
EOL

print_result $? "Java development environment"

# Install additional tools
brew_install "jmeter" "jmeter"            # Performance testing
brew_install "visualvm" "visualvm"        # Profiling
brew_install "jd-gui" "jd-gui" "--cask"  # Java decompiler
