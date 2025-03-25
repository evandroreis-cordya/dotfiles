#!/usr/bin/env zsh

# Get the directory of the current script
SCRIPT_DIR=${0:a:h}
source "${SCRIPT_DIR}/../../utils.zsh"
source "${SCRIPT_DIR}/utils.zsh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Add warning function if not already defined
print_warning() {
    print_in_yellow "  [!] $1\n"
}

print_in_purple "\n   Database Tools\n\n"

# Traditional Database Tools
print_in_purple "   Traditional Database Tools\n\n"

# Azure Data Studio
if brew list --cask | grep -q "azure-data-studio"; then
    print_success "Azure Data Studio (already installed)"
else
    print_in_yellow "  [ ] Azure Data Studio"
    brew install --cask azure-data-studio &> /dev/null
    print_result $? "Azure Data Studio"
fi

# MongoDB Compass
if brew list --cask | grep -q "mongodb-compass"; then
    print_success "MongoDB Compass (already installed)"
else
    print_in_yellow "  [ ] MongoDB Compass"
    brew install --cask mongodb-compass &> /dev/null
    print_result $? "MongoDB Compass"
fi

# MySQL Shell
if brew list | grep -q "mysql-shell"; then
    print_success "MySQL Shell (already installed)"
else
    print_in_yellow "  [ ] MySQL Shell"
    brew install mysql-shell &> /dev/null
    print_result $? "MySQL Shell"
fi

# MySQL Workbench
if brew list --cask | grep -q "mysqlworkbench"; then
    print_success "MySQL Workbench (already installed)"
else
    print_in_yellow "  [ ] MySQL Workbench"
    brew install --cask mysqlworkbench &> /dev/null
    print_result $? "MySQL Workbench"
fi

# SQLite Studio
if brew list --cask | grep -q "sqlitestudio"; then
    print_success "SQLite Studio (already installed)"
else
    print_in_yellow "  [ ] SQLite Studio"
    brew install --cask sqlitestudio &> /dev/null
    print_result $? "SQLite Studio"
fi

# DBeaver
if brew list --cask | grep -q "dbeaver-community"; then
    print_success "DBeaver (already installed)"
else
    print_in_yellow "  [ ] DBeaver"
    brew install --cask dbeaver-community &> /dev/null
    print_result $? "DBeaver"
fi

# PostgreSQL Client
if brew list | grep -q "libpq"; then
    print_success "PostgreSQL Client (already installed)"
else
    print_in_yellow "  [ ] PostgreSQL Client"
    brew install libpq &> /dev/null
    print_result $? "PostgreSQL Client"
fi

# Vector Databases and AI Tools
print_in_purple "\n   Vector Databases and AI Tools\n\n"

# Milvus (via Docker)
print_in_yellow "  [ ] Milvus (optional)"
print_warning "Milvus is best installed via Docker. Please run 'docker pull milvusdb/milvus:latest' manually if needed."

# Weaviate CLI
if command -v weaviate &> /dev/null; then
    print_success "Weaviate CLI (already installed)"
else
    print_in_yellow "  [ ] Weaviate CLI (optional)"
    # Try to install with Homebrew
    if brew tap weaviate/tap &> /dev/null && brew install weaviate/tap/weaviate-cli &> /dev/null; then
        print_success "Weaviate CLI"
    else
        print_warning "Weaviate CLI (optional - skipped, install manually with 'pip install weaviate-client')"
    fi
fi

# Qdrant CLI
if command -v qdrant &> /dev/null; then
    print_success "Qdrant CLI (already installed)"
else
    print_in_yellow "  [ ] Qdrant CLI (optional)"
    # Try to install with Homebrew
    if brew tap qdrant/qdrant &> /dev/null && brew install qdrant/qdrant/qdrant-cli &> /dev/null; then
        print_success "Qdrant CLI"
    else
        print_warning "Qdrant CLI (optional - skipped, install manually with Docker: 'docker pull qdrant/qdrant')"
    fi
fi

# Python AI Libraries
print_in_purple "\n   Python AI Libraries\n\n"

# Check if pip3 is available
if command -v pip3 &> /dev/null; then
    # Chroma
    if pip3 list 2>/dev/null | grep -q "chromadb"; then
        print_success "Chroma (already installed)"
    else
        print_in_yellow "  [ ] Chroma (optional)"
        pip3 install chromadb 2>/dev/null
        if [ $? -eq 0 ]; then
            print_success "Chroma"
        else
            print_warning "Chroma (optional - skipped)"
        fi
    fi

    # Pinecone CLI
    if pip3 list 2>/dev/null | grep -q "pinecone-client"; then
        print_success "Pinecone Client (already installed)"
    else
        print_in_yellow "  [ ] Pinecone Client (optional)"
        pip3 install pinecone-client 2>/dev/null
        if [ $? -eq 0 ]; then
            print_success "Pinecone Client"
        else
            print_warning "Pinecone Client (optional - skipped)"
        fi
    fi

    # LanceDB
    if pip3 list 2>/dev/null | grep -q "lancedb"; then
        print_success "LanceDB (already installed)"
    else
        print_in_yellow "  [ ] LanceDB (optional)"
        pip3 install lancedb 2>/dev/null
        if [ $? -eq 0 ]; then
            print_success "LanceDB"
        else
            print_warning "LanceDB (optional - skipped)"
        fi
    fi

    # FAISS
    if pip3 list 2>/dev/null | grep -q "faiss-cpu"; then
        print_success "FAISS (already installed)"
    else
        print_in_yellow "  [ ] FAISS (optional)"
        pip3 install faiss-cpu 2>/dev/null
        if [ $? -eq 0 ]; then
            print_success "FAISS"
        else
            print_warning "FAISS (optional - skipped)"
        fi
    fi

    # Annoy
    if pip3 list 2>/dev/null | grep -q "annoy"; then
        print_success "Annoy (already installed)"
    else
        print_in_yellow "  [ ] Annoy (optional)"
        pip3 install annoy 2>/dev/null
        if [ $? -eq 0 ]; then
            print_success "Annoy"
        else
            print_warning "Annoy (optional - skipped)"
        fi
    fi

    # HNSW
    if pip3 list 2>/dev/null | grep -q "hnswlib"; then
        print_success "HNSW (already installed)"
    else
        print_in_yellow "  [ ] HNSW (optional)"
        pip3 install hnswlib 2>/dev/null
        if [ $? -eq 0 ]; then
            print_success "HNSW"
        else
            print_warning "HNSW (optional - skipped)"
        fi
    fi

    # Sentence Transformers
    if pip3 list 2>/dev/null | grep -q "sentence-transformers"; then
        print_success "Sentence Transformers (already installed)"
    else
        print_in_yellow "  [ ] Sentence Transformers (optional)"
        pip3 install sentence-transformers 2>/dev/null
        if [ $? -eq 0 ]; then
            print_success "Sentence Transformers"
        else
            print_warning "Sentence Transformers (optional - skipped)"
        fi
    fi

    # pgvector (PostgreSQL extension for vector similarity search)
    if pip3 list 2>/dev/null | grep -q "pgvector"; then
        print_success "pgvector Python Client (already installed)"
    else
        print_in_yellow "  [ ] pgvector Python Client (optional)"
        pip3 install pgvector 2>/dev/null
        if [ $? -eq 0 ]; then
            print_success "pgvector Python Client"
        else
            print_warning "pgvector Python Client (optional - skipped)"
        fi
    fi
else
    print_warning "pip3 not found. Skipping Python AI libraries installation."
fi

# Redis Stack (for Redis as a vector database)
if brew list | grep -q "redis-stack"; then
    print_success "Redis Stack (already installed)"
else
    print_in_yellow "  [ ] Redis Stack"
    brew tap redis-stack/redis-stack &> /dev/null
    brew install redis-stack &> /dev/null
    print_result $? "Redis Stack"
fi

# Neo4j (for graph vector search)
if brew list | grep -q "neo4j"; then
    print_success "Neo4j (already installed)"
else
    print_in_yellow "  [ ] Neo4j"
    brew install neo4j &> /dev/null
    print_result $? "Neo4j"
fi

print_in_green "\n  Database tools setup complete!\n"
