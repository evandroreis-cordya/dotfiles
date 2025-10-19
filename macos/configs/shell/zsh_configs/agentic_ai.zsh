#!/bin/zsh
#==============================================================================
# AGENTIC AI FRAMEWORKS CONFIGURATION
#==============================================================================
# Configuration for agentic AI frameworks and autonomous agent systems
# Provides environment setup for AutoGen, LangGraph, AgentGPT, BabyAGI, and AgentForge
#
# Dependencies: autogen, langgraph, agentgpt, babyagi, agentforge
#==============================================================================

# Agentic AI configuration
export AGENTIC_AI_CONFIG_DIR="$HOME/.config/agentic-ai"
export AGENTIC_AI_CONFIG_FILE="$AGENTIC_AI_CONFIG_DIR/config.json"
export AGENTIC_AI_WORKSPACE_DIR="$HOME/.agentic-ai/workspace"
export AGENTIC_AI_AGENTS_DIR="$HOME/.agentic-ai/agents"
export AGENTIC_AI_LOGS_DIR="$HOME/.agentic-ai/logs"

# Create Agentic AI directories
mkdir -p "$AGENTIC_AI_CONFIG_DIR"
mkdir -p "$AGENTIC_AI_WORKSPACE_DIR"
mkdir -p "$AGENTIC_AI_AGENTS_DIR"
mkdir -p "$AGENTIC_AI_LOGS_DIR"

# Agentic AI environment variables
export AGENTIC_AI_DEFAULT_MODEL="gpt-4"
export AGENTIC_AI_DEFAULT_TEMPERATURE="0.7"
export AGENTIC_AI_DEFAULT_MAX_TOKENS="4096"
export AGENTIC_AI_DEFAULT_MAX_ITERATIONS="10"
export AGENTIC_AI_DEFAULT_VERBOSE="true"

# API Keys for agentic AI frameworks
export AGENTIC_AI_OPENAI_API_KEY="${OPENAI_API_KEY:-}"
export AGENTIC_AI_ANTHROPIC_API_KEY="${ANTHROPIC_API_KEY:-}"
export AGENTIC_AI_GOOGLE_API_KEY="${GOOGLE_API_KEY:-}"

# AutoGen configuration
export AUTOGEN_CONFIG_DIR="$HOME/.config/autogen"
export AUTOGEN_CONFIG_FILE="$AUTOGEN_CONFIG_DIR/config.json"

# LangGraph configuration
export LANGGRAPH_CONFIG_DIR="$HOME/.config/langgraph"
export LANGGRAPH_CONFIG_FILE="$LANGGRAPH_CONFIG_DIR/config.json"

# AgentGPT configuration
export AGENTGPT_CONFIG_DIR="$HOME/.config/agentgpt"
export AGENTGPT_CONFIG_FILE="$AGENTGPT_CONFIG_DIR/config.json"

# BabyAGI configuration
export BABYAGI_CONFIG_DIR="$HOME/.config/babyagi"
export BABYAGI_CONFIG_FILE="$BABYAGI_CONFIG_DIR/config.json"

# AgentForge configuration
export AGENTFORGE_CONFIG_DIR="$HOME/.config/agentforge"
export AGENTFORGE_CONFIG_FILE="$AGENTFORGE_CONFIG_DIR/config.json"

# Create framework-specific directories
mkdir -p "$AUTOGEN_CONFIG_DIR"
mkdir -p "$LANGGRAPH_CONFIG_DIR"
mkdir -p "$AGENTGPT_CONFIG_DIR"
mkdir -p "$BABYAGI_CONFIG_DIR"
mkdir -p "$AGENTFORGE_CONFIG_DIR"

# Agentic AI initialization functions
agentic_ai_init() {
    # Initialize agentic AI project
    local project_name="${1:-agentic-project}"
    local project_dir="$AGENTIC_AI_WORKSPACE_DIR/$project_name"
    
    if [[ ! -d "$project_dir" ]]; then
        mkdir -p "$project_dir"
        cd "$project_dir"
        
        # Create basic agentic AI structure
        cat > "agentic_config.json" << 'EOF'
{
    "framework": "autogen",
    "model": "gpt-4",
    "temperature": 0.7,
    "max_tokens": 4096,
    "max_iterations": 10,
    "verbose": true,
    "agents": {
        "user_proxy": {
            "name": "UserProxyAgent",
            "role": "User Proxy",
            "description": "Represents the user in conversations"
        },
        "assistant": {
            "name": "AssistantAgent",
            "role": "Assistant",
            "description": "AI assistant agent"
        }
    }
}
EOF

        cat > "requirements.txt" << 'EOF'
pyautogen
langgraph
langchain
openai
anthropic
google-generativeai
EOF

        echo "Agentic AI project '$project_name' initialized in $project_dir"
    else
        echo "Project '$project_name' already exists"
    fi
}

# AutoGen functions
autogen_setup() {
    # Setup AutoGen framework
    if [[ -n "$AGENTIC_AI_OPENAI_API_KEY" ]]; then
        cat > "$AUTOGEN_CONFIG_FILE" << EOF
{
    "openai_api_key": "$AGENTIC_AI_OPENAI_API_KEY",
    "model": "$AGENTIC_AI_DEFAULT_MODEL",
    "temperature": $AGENTIC_AI_DEFAULT_TEMPERATURE,
    "max_tokens": $AGENTIC_AI_DEFAULT_MAX_TOKENS,
    "max_iterations": $AGENTIC_AI_DEFAULT_MAX_ITERATIONS,
    "verbose": $AGENTIC_AI_DEFAULT_VERBOSE
}
EOF
        echo "AutoGen configured"
    else
        echo "AGENTIC_AI_OPENAI_API_KEY not set. Please set it first."
        return 1
    fi
}

autogen_create_agent() {
    # Create AutoGen agent
    local agent_name="${1:-}"
    local role="${2:-Assistant}"
    local description="${3:-AI assistant agent}"
    
    if [[ -n "$agent_name" ]]; then
        local agent_file="$AGENTIC_AI_AGENTS_DIR/${agent_name}_agent.py"
        
        cat > "$agent_file" << EOF
import autogen

# Create ${agent_name} agent
${agent_name}_agent = autogen.AssistantAgent(
    name="${agent_name}",
    system_message="You are a ${role}. ${description}",
    llm_config={
        "model": "$AGENTIC_AI_DEFAULT_MODEL",
        "temperature": $AGENTIC_AI_DEFAULT_TEMPERATURE,
        "max_tokens": $AGENTIC_AI_DEFAULT_MAX_TOKENS,
    }
)

# Create user proxy agent
user_proxy = autogen.UserProxyAgent(
    name="user_proxy",
    system_message="You are a user proxy agent.",
    human_input_mode="NEVER",
    max_consecutive_auto_reply=10,
    is_termination_msg=lambda x: x.get("content", "").rstrip().endswith("TERMINATE"),
    code_execution_config={"work_dir": "groupchat", "use_docker": False},
)
EOF
        
        echo "AutoGen agent '$agent_name' created in $agent_file"
    else
        echo "Usage: autogen_create_agent 'name' 'role' 'description'"
        return 1
    fi
}

autogen_run_conversation() {
    # Run AutoGen conversation
    local agent_file="${1:-}"
    local message="${2:-Hello, how can you help me?}"
    
    if [[ -f "$agent_file" ]]; then
        python3 -c "
import sys
sys.path.append('$AGENTIC_AI_AGENTS_DIR')
exec(open('$agent_file').read())

# Start conversation
user_proxy.initiate_chat(${agent_file##*/}_agent, message='$message')
"
    else
        echo "Agent file '$agent_file' not found"
        return 1
    fi
}

# LangGraph functions
langgraph_setup() {
    # Setup LangGraph framework
    cat > "$LANGGRAPH_CONFIG_FILE" << EOF
{
    "model": "$AGENTIC_AI_DEFAULT_MODEL",
    "temperature": $AGENTIC_AI_DEFAULT_TEMPERATURE,
    "max_tokens": $AGENTIC_AI_DEFAULT_MAX_TOKENS,
    "verbose": $AGENTIC_AI_DEFAULT_VERBOSE
}
EOF
    echo "LangGraph configured"
}

langgraph_create_workflow() {
    # Create LangGraph workflow
    local workflow_name="${1:-}"
    local description="${2:-AI workflow}"
    
    if [[ -n "$workflow_name" ]]; then
        local workflow_file="$AGENTIC_AI_WORKSPACE_DIR/${workflow_name}_workflow.py"
        
        cat > "$workflow_file" << 'EOF'
from langgraph import StateGraph, END
from langchain_openai import ChatOpenAI
from langchain_core.messages import HumanMessage, AIMessage

# Define the state
from typing import TypedDict

class WorkflowState(TypedDict):
    messages: list
    result: str

# Define nodes
def process_input(state: WorkflowState):
    """Process the input message"""
    messages = state["messages"]
    last_message = messages[-1]
    
    # Process the message (example)
    result = f"Processed: {last_message.content}"
    
    return {"messages": messages, "result": result}

def generate_response(state: WorkflowState):
    """Generate AI response"""
    llm = ChatOpenAI(model="gpt-4", temperature=0.7)
    
    messages = state["messages"]
    response = llm.invoke(messages)
    
    return {"messages": messages + [response], "result": response.content}

# Create the workflow
workflow = StateGraph(WorkflowState)

# Add nodes
workflow.add_node("process", process_input)
workflow.add_node("generate", generate_response)

# Add edges
workflow.add_edge("process", "generate")
workflow.add_edge("generate", END)

# Compile the workflow
app = workflow.compile()

# Example usage
if __name__ == "__main__":
    initial_state = {
        "messages": [HumanMessage(content="Hello, world!")],
        "result": ""
    }
    
    result = app.invoke(initial_state)
    print(result["result"])
EOF
        
        echo "LangGraph workflow '$workflow_name' created in $workflow_file"
    else
        echo "Usage: langgraph_create_workflow 'name' 'description'"
        return 1
    fi
}

# AgentGPT functions
agentgpt_setup() {
    # Setup AgentGPT framework
    cat > "$AGENTGPT_CONFIG_FILE" << EOF
{
    "model": "$AGENTIC_AI_DEFAULT_MODEL",
    "temperature": $AGENTIC_AI_DEFAULT_TEMPERATURE,
    "max_tokens": $AGENTIC_AI_DEFAULT_MAX_TOKENS,
    "max_iterations": $AGENTIC_AI_DEFAULT_MAX_ITERATIONS,
    "verbose": $AGENTIC_AI_DEFAULT_VERBOSE
}
EOF
    echo "AgentGPT configured"
}

# BabyAGI functions
babyagi_setup() {
    # Setup BabyAGI framework
    cat > "$BABYAGI_CONFIG_FILE" << EOF
{
    "model": "$AGENTIC_AI_DEFAULT_MODEL",
    "temperature": $AGENTIC_AI_DEFAULT_TEMPERATURE,
    "max_tokens": $AGENTIC_AI_DEFAULT_MAX_TOKENS,
    "max_iterations": $AGENTIC_AI_DEFAULT_MAX_ITERATIONS,
    "verbose": $AGENTIC_AI_DEFAULT_VERBOSE
}
EOF
    echo "BabyAGI configured"
}

# AgentForge functions
agentforge_setup() {
    # Setup AgentForge framework
    cat > "$AGENTFORGE_CONFIG_FILE" << EOF
{
    "model": "$AGENTIC_AI_DEFAULT_MODEL",
    "temperature": $AGENTIC_AI_DEFAULT_TEMPERATURE,
    "max_tokens": $AGENTIC_AI_DEFAULT_MAX_TOKENS,
    "max_iterations": $AGENTIC_AI_DEFAULT_MAX_ITERATIONS,
    "verbose": $AGENTIC_AI_DEFAULT_VERBOSE
}
EOF
    echo "AgentForge configured"
}

# Agentic AI utility functions
agentic_ai_status() {
    # Show Agentic AI configuration status
    echo "Agentic AI Configuration:"
    echo "  Config Dir: $AGENTIC_AI_CONFIG_DIR"
    echo "  Workspace Dir: $AGENTIC_AI_WORKSPACE_DIR"
    echo "  Agents Dir: $AGENTIC_AI_AGENTS_DIR"
    echo "  Logs Dir: $AGENTIC_AI_LOGS_DIR"
    echo "  Default Model: $AGENTIC_AI_DEFAULT_MODEL"
    echo "  Default Temperature: $AGENTIC_AI_DEFAULT_TEMPERATURE"
    echo "  Default Max Tokens: $AGENTIC_AI_DEFAULT_MAX_TOKENS"
    echo "  Default Max Iterations: $AGENTIC_AI_DEFAULT_MAX_ITERATIONS"
    echo "  OpenAI API Key: ${AGENTIC_AI_OPENAI_API_KEY:+***set***}"
    echo "  Anthropic API Key: ${AGENTIC_AI_ANTHROPIC_API_KEY:+***set***}"
    echo "  Google API Key: ${AGENTIC_AI_GOOGLE_API_KEY:+***set***}"
}

agentic_ai_list_agents() {
    # List available agents
    ls -la "$AGENTIC_AI_AGENTS_DIR" 2>/dev/null | grep -v "^total" | awk '{print $9}' | grep -v "^\.$\|^\.\.$"
}

agentic_ai_list_workflows() {
    # List available workflows
    ls -la "$AGENTIC_AI_WORKSPACE_DIR"/*_workflow.py 2>/dev/null | awk '{print $9}' | xargs basename -s _workflow.py
}

# Agentic AI aliases
alias aai='agentic_ai_init'
alias aagent='autogen_create_agent'
alias aworkflow='langgraph_create_workflow'
alias astatus='agentic_ai_status'
alias alist='agentic_ai_list_agents'
alias awlist='agentic_ai_list_workflows'

# Agentic AI project management
agentic_ai_list_projects() {
    # List agentic AI projects
    ls -la "$AGENTIC_AI_WORKSPACE_DIR" 2>/dev/null | grep -v "^total" | awk '{print $9}' | grep -v "^\.$\|^\.\.$"
}

agentic_ai_activate_project() {
    # Activate agentic AI project
    local project_name="${1:-}"
    
    if [[ -n "$project_name" ]]; then
        local project_dir="$AGENTIC_AI_WORKSPACE_DIR/$project_name"
        if [[ -d "$project_dir" ]]; then
            cd "$project_dir"
            echo "Activated Agentic AI project: $project_name"
        else
            echo "Project '$project_name' not found"
            return 1
        fi
    else
        echo "Usage: agentic_ai_activate_project 'project_name'"
        return 1
    fi
}

# Agentic AI templates
agentic_ai_template_multi_agent() {
    # Create multi-agent system template
    agentic_ai_init "multi-agent-system"
    cd "$AGENTIC_AI_WORKSPACE_DIR/multi-agent-system"
    
    cat > "multi_agent_system.py" << 'EOF'
import autogen
import os

# Configure API key
os.environ["OPENAI_API_KEY"] = os.getenv("AGENTIC_AI_OPENAI_API_KEY")

# Create agents
user_proxy = autogen.UserProxyAgent(
    name="user_proxy",
    system_message="You are a user proxy agent.",
    human_input_mode="NEVER",
    max_consecutive_auto_reply=10,
    is_termination_msg=lambda x: x.get("content", "").rstrip().endswith("TERMINATE"),
    code_execution_config={"work_dir": "groupchat", "use_docker": False},
)

researcher = autogen.AssistantAgent(
    name="researcher",
    system_message="You are a research specialist. You gather and analyze information.",
    llm_config={
        "model": "gpt-4",
        "temperature": 0.7,
        "max_tokens": 4096,
    }
)

analyst = autogen.AssistantAgent(
    name="analyst",
    system_message="You are a data analyst. You analyze data and provide insights.",
    llm_config={
        "model": "gpt-4",
        "temperature": 0.7,
        "max_tokens": 4096,
    }
)

writer = autogen.AssistantAgent(
    name="writer",
    system_message="You are a content writer. You create compelling content based on research and analysis.",
    llm_config={
        "model": "gpt-4",
        "temperature": 0.7,
        "max_tokens": 4096,
    }
)

# Create group chat
groupchat = autogen.GroupChat(
    agents=[user_proxy, researcher, analyst, writer],
    messages=[],
    max_round=20,
    speaker_selection_method="round_robin",
)

manager = autogen.GroupChatManager(
    groupchat=groupchat,
    llm_config={
        "model": "gpt-4",
        "temperature": 0.7,
        "max_tokens": 4096,
    }
)

# Start conversation
if __name__ == "__main__":
    user_proxy.initiate_chat(
        manager,
        message="Research and write a comprehensive report on AI trends in 2024."
    )
EOF
    
    echo "Multi-agent system template created"
}

# Agentic AI installation check
agentic_ai_install_check() {
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
    
    if [[ ${#missing[@]} -eq 0 ]]; then
        echo "All Agentic AI dependencies are installed"
        return 0
    else
        echo "Missing dependencies: ${missing[*]}"
        return 1
    fi
}

# Agentic AI configuration validation
if [[ -n "$AGENTIC_AI_OPENAI_API_KEY" ]] || [[ -n "$AGENTIC_AI_ANTHROPIC_API_KEY" ]] || [[ -n "$AGENTIC_AI_GOOGLE_API_KEY" ]]; then
    export AGENTIC_AI_CONFIGURED=true
else
    export AGENTIC_AI_CONFIGURED=false
fi

# Agentic AI integration complete
if [[ "$AGENTIC_AI_CONFIGURED" == "true" ]]; then
    export AGENTIC_AI_INTEGRATION="active"
else
    export AGENTIC_AI_INTEGRATION="limited"
fi
