#!/bin/bash

# Build Your Confidence Skill - Installation Script
# This script installs the build-your-confidence skill to your agent's skills directory

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${GREEN}[✓]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[!]${NC} $1"
}

print_error() {
    echo -e "${RED}[✗]${NC} $1"
}

# Detect agent type and set installation directory
detect_agent() {
    if [ -d "$HOME/.opencode/skills" ]; then
        echo "$HOME/.opencode/skills"
    elif [ -d "$HOME/.agents/skills" ]; then
        echo "$HOME/.agents/skills"
    elif [ -d "$HOME/.claude/skills" ]; then
        echo "$HOME/.claude/skills"
    else
        echo ""
    fi
}

# Main installation function
install_skill() {
    echo "=========================================="
    echo "  Build Your Confidence Skill Installer"
    echo "=========================================="
    echo ""
    
    # Get the directory where this script is located
    SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
    
    # Detect installation directory
    INSTALL_DIR=$(detect_agent)
    
    if [ -z "$INSTALL_DIR" ]; then
        print_warning "Could not detect agent skills directory."
        echo "Please enter the path to your skills directory:"
        read -r INSTALL_DIR
        
        if [ ! -d "$INSTALL_DIR" ]; then
            print_error "Directory does not exist: $INSTALL_DIR"
            exit 1
        fi
    fi
    
    print_status "Detected skills directory: $INSTALL_DIR"
    
    # Create skill directory
    SKILL_DIR="$INSTALL_DIR/build-your-confidence"
    
    if [ -d "$SKILL_DIR" ]; then
        print_warning "Skill already exists at $SKILL_DIR"
        echo "Do you want to overwrite it? (y/N): "
        read -r OVERWRITE
        
        if [ "$OVERWRITE" != "y" ] && [ "$OVERWRITE" != "Y" ]; then
            print_status "Installation cancelled."
            exit 0
        fi
        
        rm -rf "$SKILL_DIR"
    fi
    
    # Copy skill files
    print_status "Installing build-your-confidence skill..."
    cp -r "$SCRIPT_DIR" "$SKILL_DIR"
    
    # Remove installation script from the installed copy
    rm -f "$SKILL_DIR/install.sh"
    
    print_status "Skill installed successfully!"
    echo ""
    echo "Installation location: $SKILL_DIR"
    echo ""
    echo "To use this skill, restart your agent and mention:"
    echo "  - 自信, confidence, self-esteem"
    echo "  - 自我怀疑, 自卑, 勇气"
    echo "  - 内心力量, 自我提升, 自我成长"
    echo ""
    echo "For more information, see: $SKILL_DIR/README.md"
}

# Run installation
install_skill
