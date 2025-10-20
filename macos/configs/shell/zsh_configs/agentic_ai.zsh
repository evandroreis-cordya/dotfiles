#!/bin/zsh
#==============================================================================
# AGENTIC AI CONFIGURATION
#==============================================================================
# Configuration for agentic AI frameworks and autonomous agent systems
# Provides environment setup for multi-agent systems, autonomous workflows,
# and agent-based code generation tools
#
# Dependencies: autogen, langgraph, agentgpt, babyagi, agentforge
#==============================================================================

# Agentic AI configuration
export AGENTIC_CONFIG_DIR="$HOME/.config/agentic"
export AGENTIC_CONFIG_FILE="$AGENTIC_CONFIG_DIR/config.yaml"
export AGENTIC_LOGS_DIR="$HOME/.agentic/logs"
export AGENTIC_WORKSPACE_DIR="$HOME/.agentic/workspace"
export AGENTIC_MODELS_DIR="$HOME/.agentic/models"
export AGENTIC_AGENTS_DIR="$HOME/.agentic/agents"

# Create agentic AI directories
mkdir -p "$AGENTIC_CONFIG_DIR"
mkdir -p "$AGENTIC_LOGS_DIR"
mkdir -p "$AGENTIC_WORKSPACE_DIR"
mkdir -p "$AGENTIC_MODELS_DIR"
mkdir -p "$AGENTIC_AGENTS_DIR"

# Agentic AI environment variables
export AGENTIC_DEFAULT_MODEL="gpt-4"
export AGENTIC_DEFAULT_TEMPERATURE="0.7"
export AGENTIC_DEFAULT_MAX_TOKENS="4096"
export AGENTIC_DEFAULT_VERBOSE="true"
export AGENTIC_DEFAULT_DEBUG="false"
export AGENTIC_DEFAULT_TIMEOUT="300"

# Agentic AI API keys
export AGENTIC_OPENAI_API_KEY="${OPENAI_API_KEY:-}"
export AGENTIC_ANTHROPIC_API_KEY="${ANTHROPIC_API_KEY:-}"
export AGENTIC_GOOGLE_API_KEY="${GOOGLE_API_KEY:-}"

# AutoGen configuration
export AUTOGEN_CONFIG_DIR="$AGENTIC_CONFIG_DIR/autogen"
export AUTOGEN_WORKSPACE_DIR="$AGENTIC_WORKSPACE_DIR/autogen"

# LangGraph configuration
export LANGGRAPH_CONFIG_DIR="$AGENTIC_CONFIG_DIR/langgraph"
export LANGGRAPH_WORKSPACE_DIR="$AGENTIC_WORKSPACE_DIR/langgraph"

# AgentGPT configuration
export AGENTGPT_CONFIG_DIR="$AGENTIC_CONFIG_DIR/agentgpt"
export AGENTGPT_WORKSPACE_DIR="$AGENTIC_WORKSPACE_DIR/agentgpt"

# BabyAGI configuration
export BABYAGI_CONFIG_DIR="$AGENTIC_CONFIG_DIR/babyagi"
export BABYAGI_WORKSPACE_DIR="$AGENTIC_WORKSPACE_DIR/babyagi"

# AgentForge configuration
export AGENTFORGE_CONFIG_DIR="$AGENTIC_CONFIG_DIR/agentforge"
export AGENTFORGE_WORKSPACE_DIR="$AGENTIC_WORKSPACE_DIR/agentforge"

# Create framework-specific directories
mkdir -p "$AUTOGEN_CONFIG_DIR" "$AUTOGEN_WORKSPACE_DIR"
mkdir -p "$LANGGRAPH_CONFIG_DIR" "$LANGGRAPH_WORKSPACE_DIR"
mkdir -p "$AGENTGPT_CONFIG_DIR" "$AGENTGPT_WORKSPACE_DIR"
mkdir -p "$BABYAGI_CONFIG_DIR" "$BABYAGI_WORKSPACE_DIR"
mkdir -p "$AGENTFORGE_CONFIG_DIR" "$AGENTFORGE_WORKSPACE_DIR"

# Agentic AI initialization functions
agentic_init() {
    # Initialize agentic AI project
    local project_name="${1:-agentic-project}"
    local project_dir="$AGENTIC_WORKSPACE_DIR/$project_name"
    
    if [[ ! -d "$project_dir" ]]; then
        mkdir -p "$project_dir"
        cd "$project_dir"
        
        # Create basic agentic AI structure
        cat > "agentic_config.yaml" << 'EOF'
# Agentic AI Configuration
project:
  name: agentic-project
  version: 1.0.0
  description: Multi-agent system project

agents:
  - name: researcher
    role: Research Specialist
    goal: Conduct thorough research
    backstory: Expert researcher with web search capabilities
    model: gpt-4
    temperature: 0.7
    
  - name: writer
    role: Content Writer
    goal: Create compelling content
    backstory: Professional content writer
    model: gpt-4
    temperature: 0.7

workflow:
  type: sequential
  timeout: 300
  retry_attempts: 3
  verbose: true

logging:
  level: INFO
  file: logs/agentic.log
  console: true
EOF

        cat > "requirements.txt" << 'EOF'
pyautogen
langgraph
agentgpt
babyagi
agentforge
langchain
openai
anthropic
google-generativeai
pyyaml
pydantic
python-dotenv
EOF

        # Create subdirectories
        mkdir -p agents tasks workflows logs
        
        echo "Agentic AI project '$project_name' initialized in $project_dir"
    else
        echo "Project '$project_name' already exists"
    fi
}

# AutoGen functions
autogen_init() {
    # Initialize AutoGen project
    local project_name="${1:-autogen-project}"
    local project_dir="$AUTOGEN_WORKSPACE_DIR/$project_name"
    
    if [[ ! -d "$project_dir" ]]; then
        mkdir -p "$project_dir"
        cd "$project_dir"
        
        cat > "autogen_config.py" << 'EOF'
import autogen
from autogen import ConversableAgent

# Create agents
researcher = ConversableAgent(
    name="researcher",
    system_message="You are a research specialist. Find and analyze information.",
    llm_config={
        "model": "gpt-4",
        "temperature": 0.7,
        "max_tokens": 2048,
    }
)

writer = ConversableAgent(
    name="writer",
    system_message="You are a content writer. Create compelling content based on research.",
    llm_config={
        "model": "gpt-4",
        "temperature": 0.7,
        "max_tokens": 2048,
    }
)

# Create group chat
group_chat = autogen.GroupChat(
    agents=[researcher, writer],
    messages=[],
    max_round=10,
    speaker_selection_method="round_robin"
)

# Create manager
manager = autogen.GroupChatManager(
    groupchat=group_chat,
    llm_config={
        "model": "gpt-4",
        "temperature": 0.7,
        "max_tokens": 2048,
    }
)

# Start conversation
researcher.initiate_chat(manager, message="Research the topic: AI and Machine Learning trends")
EOF
        
        echo "AutoGen project '$project_name' initialized in $project_dir"
    else
        echo "AutoGen project '$project_name' already exists"
    fi
}

# LangGraph functions
langgraph_init() {
    # Initialize LangGraph project
    local project_name="${1:-langgraph-project}"
    local project_dir="$LANGGRAPH_WORKSPACE_DIR/$project_name"
    
    if [[ ! -d "$project_dir" ]]; then
        mkdir -p "$project_dir"
        cd "$project_dir"
        
        cat > "langgraph_workflow.py" << 'EOF'
from langgraph import StateGraph, END
from langchain_openai import ChatOpenAI
from typing import TypedDict, Annotated
from langchain_core.messages import BaseMessage

class AgentState(TypedDict):
    messages: Annotated[list[BaseMessage], "The messages in the conversation"]

# Create the model
model = ChatOpenAI(model="gpt-4", temperature=0.7)

# Define nodes
def research_node(state: AgentState):
    """Research node"""
    messages = state["messages"]
    response = model.invoke(messages)
    return {"messages": [response]}

def write_node(state: AgentState):
    """Write node"""
    messages = state["messages"]
    response = model.invoke(messages)
    return {"messages": [response]}

# Create the graph
workflow = StateGraph(AgentState)

# Add nodes
workflow.add_node("research", research_node)
workflow.add_node("write", write_node)

# Add edges
workflow.set_entry_point("research")
workflow.add_edge("research", "write")
workflow.add_edge("write", END)

# Compile the graph
app = workflow.compile()

# Run the workflow
result = app.invoke({"messages": [{"role": "user", "content": "Research AI trends and write a summary"}]})
print(result)
EOF
        
        echo "LangGraph project '$project_name' initialized in $project_dir"
    else
        echo "LangGraph project '$project_name' already exists"
    fi
}

# AgentGPT functions
agentgpt_init() {
    # Initialize AgentGPT project
    local project_name="${1:-agentgpt-project}"
    local project_dir="$AGENTGPT_WORKSPACE_DIR/$project_name"
    
    if [[ ! -d "$project_dir" ]]; then
        mkdir -p "$project_dir"
        cd "$project_dir"
        
        cat > "agentgpt_config.yaml" << 'EOF'
# AgentGPT Configuration
agent:
  name: "Research Agent"
  role: "Research Specialist"
  goal: "Conduct thorough research on given topics"
  backstory: "You are an expert researcher with access to various tools"
  
  tools:
    - web_search
    - file_operations
    - data_analysis
  
  model:
    name: "gpt-4"
    temperature: 0.7
    max_tokens: 2048
  
  memory:
    enabled: true
    type: "vector"
    max_size: 1000

tasks:
  - name: "research_task"
    description: "Research the given topic thoroughly"
    priority: "high"
    
  - name: "analysis_task"
    description: "Analyze the research findings"
    priority: "medium"
    
  - name: "report_task"
    description: "Generate a comprehensive report"
    priority: "low"
EOF
        
        echo "AgentGPT project '$project_name' initialized in $project_dir"
    else
        echo "AgentGPT project '$project_name' already exists"
    fi
}

# BabyAGI functions
babyagi_init() {
    # Initialize BabyAGI project
    local project_name="${1:-babyagi-project}"
    local project_dir="$BABYAGI_WORKSPACE_DIR/$project_name"
    
    if [[ ! -d "$project_dir" ]]; then
        mkdir -p "$project_dir"
        cd "$project_dir"
        
        cat > "babyagi_config.py" << 'EOF'
from babyagi import BabyAGI
from langchain_openai import ChatOpenAI

# Initialize BabyAGI
baby_agi = BabyAGI(
    objective="Research and analyze AI and Machine Learning trends",
    initial_task="Start by researching the latest AI developments",
    llm=ChatOpenAI(model="gpt-4", temperature=0.7)
)

# Run BabyAGI
baby_agi.run()
EOF
        
        echo "BabyAGI project '$project_name' initialized in $project_dir"
    else
        echo "BabyAGI project '$project_name' already exists"
    fi
}

# AgentForge functions
agentforge_init() {
    # Initialize AgentForge project
    local project_name="${1:-agentforge-project}"
    local project_dir="$AGENTFORGE_WORKSPACE_DIR/$project_name"
    
    if [[ ! -d "$project_dir" ]]; then
        mkdir -p "$project_dir"
        cd "$project_dir"
        
        cat > "agentforge_config.yaml" << 'EOF'
# AgentForge Configuration
project:
  name: "AgentForge Project"
  description: "Multi-agent system using AgentForge framework"
  
agents:
  - name: "researcher"
    type: "research_agent"
    config:
      role: "Research Specialist"
      capabilities: ["web_search", "data_analysis"]
      model: "gpt-4"
      
  - name: "writer"
    type: "content_agent"
    config:
      role: "Content Writer"
      capabilities: ["content_generation", "editing"]
      model: "gpt-4"

workflows:
  - name: "research_workflow"
    agents: ["researcher", "writer"]
    sequence:
      - agent: "researcher"
        task: "Research the topic"
      - agent: "writer"
        task: "Write content based on research"
        
  - name: "analysis_workflow"
    agents: ["researcher"]
    sequence:
      - agent: "researcher"
        task: "Analyze findings and provide insights"

settings:
  max_iterations: 10
  timeout: 300
  verbose: true
  debug: false
EOF
        
        echo "AgentForge project '$project_name' initialized in $project_dir"
    else
        echo "AgentForge project '$project_name' already exists"
    fi
}

# Agentic AI utility functions
agentic_status() {
    # Show agentic AI configuration status
    echo "Agentic AI Configuration:"
    echo "  Config Dir: $AGENTIC_CONFIG_DIR"
    echo "  Logs Dir: $AGENTIC_LOGS_DIR"
    echo "  Workspace Dir: $AGENTIC_WORKSPACE_DIR"
    echo "  Models Dir: $AGENTIC_MODELS_DIR"
    echo "  Agents Dir: $AGENTIC_AGENTS_DIR"
    echo "  Default Model: $AGENTIC_DEFAULT_MODEL"
    echo "  Default Temperature: $AGENTIC_DEFAULT_TEMPERATURE"
    echo "  OpenAI API Key: ${AGENTIC_OPENAI_API_KEY:+***set***}"
    echo "  Anthropic API Key: ${AGENTIC_ANTHROPIC_API_KEY:+***set***}"
    echo "  Google API Key: ${AGENTIC_GOOGLE_API_KEY:+***set***}"
}

agentic_logs() {
    # Show agentic AI logs
    local log_file="${1:-latest}"
    
    if [[ "$log_file" == "latest" ]]; then
        ls -t "$AGENTIC_LOGS_DIR"/*.log 2>/dev/null | head -1 | xargs cat
    else
        cat "$AGENTIC_LOGS_DIR/$log_file"
    fi
}

agentic_clean() {
    # Clean agentic AI logs and temporary files
    rm -f "$AGENTIC_LOGS_DIR"/*.log
    rm -rf "$AGENTIC_WORKSPACE_DIR"/**/__pycache__
    rm -rf "$AGENTIC_WORKSPACE_DIR"/**/checkpoints
    echo "Agentic AI logs and cache cleaned"
}

# Agentic AI aliases
alias ai-init='agentic_init'
alias ai-status='agentic_status'
alias ai-logs='agentic_logs'
alias ai-clean='agentic_clean'
alias ag-init='autogen_init'
alias lg-init='langgraph_init'
alias agpt-init='agentgpt_init'
alias baby-init='babyagi_init'
alias af-init='agentforge_init'

# Agentic AI project management
agentic_list_projects() {
    # List agentic AI projects
    ls -la "$AGENTIC_WORKSPACE_DIR" 2>/dev/null | grep -v "^total" | awk '{print $9}' | grep -v "^\.$\|^\.\.$"
}

agentic_activate_project() {
    # Activate agentic AI project
    local project_name="${1:-}"
    
    if [[ -n "$project_name" ]]; then
        local project_dir="$AGENTIC_WORKSPACE_DIR/$project_name"
        if [[ -d "$project_dir" ]]; then
            cd "$project_dir"
            echo "Activated agentic AI project: $project_name"
        else
            echo "Project '$project_name' not found"
            return 1
        fi
    else
        echo "Usage: agentic_activate_project 'project_name'"
        return 1
    fi
}

# Agentic AI installation check
agentic_install_check() {
    # Check if agentic AI tools are properly installed
    local missing=()
    
    if ! command -v python3 &> /dev/null; then
        missing+=("python3")
    fi
    
    if ! python3 -c "import autogen" 2>/dev/null; then
        missing+=("pyautogen")
    fi
    
    if ! python3 -c "import langgraph" 2>/dev/null; then
        missing+=("langgraph")
    fi
    
    if ! python3 -c "import agentgpt" 2>/dev/null; then
        missing+=("agentgpt")
    fi
    
    if ! python3 -c "import babyagi" 2>/dev/null; then
        missing+=("babyagi")
    fi
    
    if [[ ${#missing[@]} -eq 0 ]]; then
        echo "All agentic AI dependencies are installed"
        return 0
    else
        echo "Missing dependencies: ${missing[*]}"
        return 1
    fi
}

# Agentic AI configuration validation
if [[ -n "$AGENTIC_OPENAI_API_KEY" ]] || [[ -n "$AGENTIC_ANTHROPIC_API_KEY" ]] || [[ -n "$AGENTIC_GOOGLE_API_KEY" ]]; then
    export AGENTIC_CONFIGURED=true
else
    export AGENTIC_CONFIGURED=false
fi

# Agentic AI integration complete
if [[ "$AGENTIC_CONFIGURED" == "true" ]]; then
    export AGENTIC_INTEGRATION="active"
else
    export AGENTIC_INTEGRATION="limited"
fi