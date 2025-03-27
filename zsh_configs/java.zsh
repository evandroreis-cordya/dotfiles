#!/bin/zsh
#
# Java configuration for zsh
# This file contains all Java-related configurations
#

# Java environment variables
export JAVA_HOME=$(/usr/libexec/java_home)
export PATH="$JAVA_HOME/bin:$PATH"

# Maven configuration (from SDKMAN)
if [ -d "$HOME/.sdkman/candidates/maven/current" ]; then
  export M2_HOME="$HOME/.sdkman/candidates/maven/current"
  export PATH="$M2_HOME/bin:$PATH"
fi

# Gradle configuration (from SDKMAN)
if [ -d "$HOME/.sdkman/candidates/gradle/current" ]; then
  export GRADLE_HOME="$HOME/.sdkman/candidates/gradle/current"
  export PATH="$GRADLE_HOME/bin:$PATH"
fi

# Java aliases
alias javac-version="javac -version"
alias java-version="java -version"
alias mvn-version="mvn -version"
alias gradle-version="gradle -version"

# Java project creation function
new-java() {
    if [ $# -lt 1 ]; then
        echo "Usage: new-java <project-name> [package-name]"
        return 1
    fi
    
    local project_name=$1
    local package_name=${2:-"com.example"}
    
    # Create project directory
    mkdir -p "$project_name/src/main/java/${package_name//.//}"
    mkdir -p "$project_name/src/test/java/${package_name//.//}"
    
    # Create Maven pom.xml
    cat > "$project_name/pom.xml" << EOF
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
    <modelVersion>4.0.0</modelVersion>

    <groupId>${package_name}</groupId>
    <artifactId>${project_name}</artifactId>
    <version>1.0-SNAPSHOT</version>

    <properties>
        <maven.compiler.source>11</maven.compiler.source>
        <maven.compiler.target>11</maven.compiler.target>
        <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
    </properties>

    <dependencies>
        <dependency>
            <groupId>junit</groupId>
            <artifactId>junit</artifactId>
            <version>4.13.2</version>
            <scope>test</scope>
        </dependency>
    </dependencies>
</project>
EOF
    
    # Create Main.java
    cat > "$project_name/src/main/java/${package_name//.//}/Main.java" << EOF
package ${package_name};

public class Main {
    public static void main(String[] args) {
        System.out.println("Hello, ${project_name}!");
    }
}
EOF
    
    # Create .gitignore
    cat > "$project_name/.gitignore" << EOF
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

# IDE
.idea/
*.iml
.classpath
.project
.settings/

# Compiled class file
*.class

# Log file
*.log
EOF
    
    echo "Java project '$project_name' created successfully!"
}
