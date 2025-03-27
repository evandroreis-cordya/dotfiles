#!/bin/zsh
#
# Node.js configuration for zsh
# This file contains all Node.js-related configurations
#

# NVM (Node Version Manager) setup
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Node.js aliases
alias npm-update="npm update -g"
alias npm-list="npm list -g --depth=0"
alias yarn-update="yarn global upgrade"
alias yarn-list="yarn global list"

# Node.js project creation function
new-node() {
    if [ $# -lt 1 ]; then
        echo "Usage: new-node <project-name> [template]"
        echo "Available templates: basic, express, typescript"
        return 1
    fi
    
    local project_name=$1
    local template=${2:-"basic"}
    
    # Create project directory
    mkdir -p "$project_name"
    cd "$project_name" || return
    
    # Initialize npm
    npm init -y
    
    # Update package.json with better defaults
    node -e "
        const fs = require('fs');
        const pkg = JSON.parse(fs.readFileSync('./package.json'));
        pkg.description = '${project_name} project';
        pkg.author = '$(git config user.name) <$(git config user.email)>';
        pkg.license = 'MIT';
        pkg.scripts = pkg.scripts || {};
        pkg.scripts.start = 'node index.js';
        pkg.scripts.test = 'echo \"Error: no test specified\" && exit 1';
        fs.writeFileSync('./package.json', JSON.stringify(pkg, null, 2));
    "
    
    # Create basic files based on template
    case "$template" in
        "express")
            # Install Express dependencies
            npm install express body-parser cors
            npm install --save-dev nodemon
            
            # Update scripts in package.json
            node -e "
                const fs = require('fs');
                const pkg = JSON.parse(fs.readFileSync('./package.json'));
                pkg.scripts.start = 'node app.js';
                pkg.scripts.dev = 'nodemon app.js';
                fs.writeFileSync('./package.json', JSON.stringify(pkg, null, 2));
            "
            
            # Create Express app.js
            cat > app.js << EOF
const express = require('express');
const bodyParser = require('body-parser');
const cors = require('cors');

const app = express();
const PORT = process.env.PORT || 3000;

// Middleware
app.use(cors());
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));

// Routes
app.get('/', (req, res) => {
  res.json({ message: 'Welcome to ${project_name} API' });
});

// Start server
app.listen(PORT, () => {
  console.log(\`Server is running on port \${PORT}\`);
});
EOF
            ;;
            
        "typescript")
            # Install TypeScript dependencies
            npm install --save-dev typescript ts-node @types/node
            
            # Update scripts in package.json
            node -e "
                const fs = require('fs');
                const pkg = JSON.parse(fs.readFileSync('./package.json'));
                pkg.scripts.start = 'node dist/index.js';
                pkg.scripts.build = 'tsc';
                pkg.scripts.dev = 'ts-node src/index.ts';
                fs.writeFileSync('./package.json', JSON.stringify(pkg, null, 2));
            "
            
            # Create tsconfig.json
            cat > tsconfig.json << EOF
{
  "compilerOptions": {
    "target": "es2018",
    "module": "commonjs",
    "outDir": "./dist",
    "rootDir": "./src",
    "strict": true,
    "esModuleInterop": true,
    "skipLibCheck": true,
    "forceConsistentCasingInFileNames": true
  },
  "include": ["src/**/*"],
  "exclude": ["node_modules", "**/*.test.ts"]
}
EOF
            
            # Create src directory and index.ts
            mkdir -p src
            cat > src/index.ts << EOF
/**
 * ${project_name} - TypeScript project
 */

function greet(name: string): string {
  return \`Hello, \${name}!\`;
}

console.log(greet('${project_name}'));

export { greet };
EOF
            ;;
            
        *)  # basic template
            # Create index.js
            cat > index.js << EOF
/**
 * ${project_name} - Node.js project
 */

console.log('Hello, ${project_name}!');
EOF
            ;;
    esac
    
    # Create .gitignore
    cat > .gitignore << EOF
# Logs
logs
*.log
npm-debug.log*
yarn-debug.log*
yarn-error.log*

# Runtime data
pids
*.pid
*.seed
*.pid.lock

# Dependency directories
node_modules/

# Optional npm cache directory
.npm

# Optional eslint cache
.eslintcache

# Output of 'npm pack'
*.tgz

# dotenv environment variables file
.env

# Build output
dist/
build/
EOF
    
    # Initialize git repository if git is available
    if command -v git >/dev/null 2>&1; then
        git init
        git add .
        git commit -m "Initial commit"
    fi
    
    echo "Node.js project '${project_name}' created successfully with '${template}' template!"
}
