#!/bin/zsh
#==============================================================================
# CREW AI AUTONOMOUS AGENTS CONFIGURATION
#==============================================================================
# Configuration for CrewAI autonomous agent framework
# Provides environment setup for multi-agent systems and autonomous workflows
#
# Dependencies: crewai, langchain, autogen
#==============================================================================

# CrewAI configuration
export CREWAI_CONFIG_DIR="$HOME/.config/crewai"
export CREWAI_CONFIG_FILE="$CREWAI_CONFIG_DIR/config.yaml"
export CREWAI_LOGS_DIR="$HOME/.crewai/logs"
export CREWAI_WORKSPACE_DIR="$HOME/.crewai/workspace"

# Create CrewAI directories
mkdir -p "$CREWAI_CONFIG_DIR"
mkdir -p "$CREWAI_LOGS_DIR"
mkdir -p "$CREWAI_WORKSPACE_DIR"

# CrewAI environment variables
export CREWAI_DEFAULT_MODEL="gpt-4"
export CREWAI_DEFAULT_TEMPERATURE="0.7"
export CREWAI_DEFAULT_MAX_TOKENS="2048"
export CREWAI_DEFAULT_VERBOSE="true"
export CREWAI_DEFAULT_DEBUG="false"

# CrewAI API keys
export CREWAI_OPENAI_API_KEY="${OPENAI_API_KEY:-}"
export CREWAI_ANTHROPIC_API_KEY="${ANTHROPIC_API_KEY:-}"
export CREWAI_GOOGLE_API_KEY="${GOOGLE_API_KEY:-}"

# CrewAI configuration functions
crewai_init() {
    # Initialize CrewAI project
    local project_name="${1:-crewai-project}"
    local project_dir="$CREWAI_WORKSPACE_DIR/$project_name"
    
    if [[ ! -d "$project_dir" ]]; then
        mkdir -p "$project_dir"
        cd "$project_dir"
        
        # Create basic CrewAI structure
        cat > "crew.py" << 'EOF'
from crewai import Agent, Task, Crew, Process
from crewai_tools import SerperDevTool

# Define agents
researcher = Agent(
    role='Researcher',
    goal='Find and analyze information',
    backstory='You are a research specialist',
    verbose=True,
    allow_delegation=False
)

writer = Agent(
    role='Writer',
    goal='Create compelling content',
    backstory='You are a content creation expert',
    verbose=True,
    allow_delegation=False
)

# Define tasks
research_task = Task(
    description='Research the topic',
    agent=researcher
)

writing_task = Task(
    description='Write content based on research',
    agent=writer
)

# Create crew
crew = Crew(
    agents=[researcher, writer],
    tasks=[research_task, writing_task],
    verbose=True,
    process=Process.sequential
)

# Execute crew
result = crew.kickoff()
print(result)
EOF

        cat > "requirements.txt" << 'EOF'
crewai
crewai-tools
langchain
openai
anthropic
google-generativeai
EOF

        echo "CrewAI project '$project_name' initialized in $project_dir"
        echo "Run 'cd $project_dir && python crew.py' to execute"
    else
        echo "Project '$project_name' already exists"
    fi
}

crewai_create_agent() {
    # Create a new CrewAI agent
    local agent_name="${1:-}"
    local role="${2:-Agent}"
    local goal="${3:-Complete assigned tasks}"
    local backstory="${4:-You are an AI agent}"
    
    if [[ -n "$agent_name" ]]; then
        local agent_file="$CREWAI_WORKSPACE_DIR/agents/${agent_name}.py"
        mkdir -p "$CREWAI_WORKSPACE_DIR/agents"
        
        cat > "$agent_file" << EOF
from crewai import Agent

${agent_name} = Agent(
    role='$role',
    goal='$goal',
    backstory='$backstory',
    verbose=True,
    allow_delegation=False
)
EOF
        
        echo "Agent '$agent_name' created in $agent_file"
    else
        echo "Usage: crewai_create_agent 'name' 'role' 'goal' 'backstory'"
        return 1
    fi
}

crewai_create_task() {
    # Create a new CrewAI task
    local task_name="${1:-}"
    local description="${2:-Complete the assigned task}"
    local agent="${3:-researcher}"
    
    if [[ -n "$task_name" ]]; then
        local task_file="$CREWAI_WORKSPACE_DIR/tasks/${task_name}.py"
        mkdir -p "$CREWAI_WORKSPACE_DIR/tasks"
        
        cat > "$task_file" << EOF
from crewai import Task

${task_name} = Task(
    description='$description',
    agent=$agent
)
EOF
        
        echo "Task '$task_name' created in $task_file"
    else
        echo "Usage: crewai_create_task 'name' 'description' 'agent'"
        return 1
    fi
}

# CrewAI execution functions
crewai_run() {
    # Run CrewAI crew
    local crew_file="${1:-crew.py}"
    
    if [[ -f "$crew_file" ]]; then
        python3 "$crew_file"
    else
        echo "Crew file '$crew_file' not found"
        return 1
    fi
}

crewai_debug() {
    # Run CrewAI with debug mode
    export CREWAI_DEFAULT_DEBUG="true"
    export CREWAI_DEFAULT_VERBOSE="true"
    crewai_run "$@"
}

# CrewAI utility functions
crewai_status() {
    # Show CrewAI configuration status
    echo "CrewAI Configuration:"
    echo "  Config Dir: $CREWAI_CONFIG_DIR"
    echo "  Logs Dir: $CREWAI_LOGS_DIR"
    echo "  Workspace Dir: $CREWAI_WORKSPACE_DIR"
    echo "  Default Model: $CREWAI_DEFAULT_MODEL"
    echo "  Default Temperature: $CREWAI_DEFAULT_TEMPERATURE"
    echo "  OpenAI API Key: ${CREWAI_OPENAI_API_KEY:+***set***}"
    echo "  Anthropic API Key: ${CREWAI_ANTHROPIC_API_KEY:+***set***}"
    echo "  Google API Key: ${CREWAI_GOOGLE_API_KEY:+***set***}"
}

crewai_logs() {
    # Show CrewAI logs
    local log_file="${1:-latest}"
    
    if [[ "$log_file" == "latest" ]]; then
        ls -t "$CREWAI_LOGS_DIR"/*.log 2>/dev/null | head -1 | xargs cat
    else
        cat "$CREWAI_LOGS_DIR/$log_file"
    fi
}

crewai_clean() {
    # Clean CrewAI logs and temporary files
    rm -f "$CREWAI_LOGS_DIR"/*.log
    rm -rf "$CREWAI_WORKSPACE_DIR"/__pycache__
    echo "CrewAI logs and cache cleaned"
}

# CrewAI aliases
alias cai='crewai_init'
alias cagent='crewai_create_agent'
alias ctask='crewai_create_task'
alias crun='crewai_run'
alias cdebug='crewai_debug'
alias cstatus='crewai_status'
alias clogs='crewai_logs'
alias cclean='crewai_clean'

# CrewAI project management
crewai_list_projects() {
    # List CrewAI projects
    ls -la "$CREWAI_WORKSPACE_DIR" 2>/dev/null | grep -v "^total" | awk '{print $9}' | grep -v "^\.$\|^\.\.$"
}

crewai_activate_project() {
    # Activate CrewAI project
    local project_name="${1:-}"
    
    if [[ -n "$project_name" ]]; then
        local project_dir="$CREWAI_WORKSPACE_DIR/$project_name"
        if [[ -d "$project_dir" ]]; then
            cd "$project_dir"
            echo "Activated CrewAI project: $project_name"
        else
            echo "Project '$project_name' not found"
            return 1
        fi
    else
        echo "Usage: crewai_activate_project 'project_name'"
        return 1
    fi
}

# CrewAI template functions
crewai_template_research() {
    # Create research crew template
    crewai_init "research-crew"
    cd "$CREWAI_WORKSPACE_DIR/research-crew"
    
    cat > "research_crew.py" << 'EOF'
from crewai import Agent, Task, Crew, Process
from crewai_tools import SerperDevTool, WebsiteSearchTool

# Define research agent
researcher = Agent(
    role='Research Specialist',
    goal='Conduct thorough research on given topics',
    backstory='You are an expert researcher with access to web search tools',
    tools=[SerperDevTool(), WebsiteSearchTool()],
    verbose=True,
    allow_delegation=False
)

# Define analysis agent
analyst = Agent(
    role='Data Analyst',
    goal='Analyze and synthesize research findings',
    backstory='You are a data analysis expert who can process and interpret information',
    verbose=True,
    allow_delegation=False
)

# Define tasks
research_task = Task(
    description='Research the topic: {topic}',
    agent=researcher,
    expected_output='Comprehensive research findings'
)

analysis_task = Task(
    description='Analyze the research findings and provide insights',
    agent=analyst,
    expected_output='Detailed analysis and insights'
)

# Create crew
research_crew = Crew(
    agents=[researcher, analyst],
    tasks=[research_task, analysis_task],
    verbose=True,
    process=Process.sequential
)

# Execute crew
result = research_crew.kickoff(inputs={'topic': 'AI and Machine Learning trends'})
print(result)
EOF
    
    echo "Research crew template created"
}

crewai_template_content() {
    # Create content creation crew template
    crewai_init "content-crew"
    cd "$CREWAI_WORKSPACE_DIR/content-crew"
    
    cat > "content_crew.py" << 'EOF'
from crewai import Agent, Task, Crew, Process

# Define content strategist
strategist = Agent(
    role='Content Strategist',
    goal='Develop content strategy and outlines',
    backstory='You are a content strategy expert',
    verbose=True,
    allow_delegation=False
)

# Define content writer
writer = Agent(
    role='Content Writer',
    goal='Create engaging and informative content',
    backstory='You are a professional content writer',
    verbose=True,
    allow_delegation=False
)

# Define editor
editor = Agent(
    role='Content Editor',
    goal='Review and improve content quality',
    backstory='You are an experienced content editor',
    verbose=True,
    allow_delegation=False
)

# Define tasks
strategy_task = Task(
    description='Develop content strategy for: {topic}',
    agent=strategist,
    expected_output='Content strategy and outline'
)

writing_task = Task(
    description='Write content based on the strategy',
    agent=writer,
    expected_output='Draft content'
)

editing_task = Task(
    description='Review and edit the content for quality',
    agent=editor,
    expected_output='Final polished content'
)

# Create crew
content_crew = Crew(
    agents=[strategist, writer, editor],
    tasks=[strategy_task, writing_task, editing_task],
    verbose=True,
    process=Process.sequential
)

# Execute crew
result = content_crew.kickoff(inputs={'topic': 'The Future of AI'})
print(result)
EOF
    
    echo "Content creation crew template created"
}

# CrewAI installation check
crewai_install_check() {
    # Check if CrewAI tools are properly installed
    local missing=()
    
    if ! command -v python3 &> /dev/null; then
        missing+=("python3")
    fi
    
    if ! python3 -c "import crewai" 2>/dev/null; then
        missing+=("crewai")
    fi
    
    if ! python3 -c "import langchain" 2>/dev/null; then
        missing+=("langchain")
    fi
    
    if [[ ${#missing[@]} -eq 0 ]]; then
        echo "All CrewAI dependencies are installed"
        return 0
    else
        echo "Missing dependencies: ${missing[*]}"
        return 1
    fi
}

# CrewAI configuration validation
if [[ -n "$CREWAI_OPENAI_API_KEY" ]] || [[ -n "$CREWAI_ANTHROPIC_API_KEY" ]] || [[ -n "$CREWAI_GOOGLE_API_KEY" ]]; then
    export CREWAI_CONFIGURED=true
else
    export CREWAI_CONFIGURED=false
fi

# CrewAI integration complete
if [[ "$CREWAI_CONFIGURED" == "true" ]]; then
    export CREWAI_INTEGRATION="active"
else
    export CREWAI_INTEGRATION="limited"
fi
