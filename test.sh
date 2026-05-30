#!/bin/bash

# Test script for build-your-confidence skill
# This script verifies that all required files are present

set -e

# Colors for output
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No Color

print_success() {
    echo -e "${GREEN}✓${NC} $1"
}

print_error() {
    echo -e "${RED}✗${NC} $1"
}

# Get the directory where this script is located
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo "=========================================="
echo "  Build Your Confidence Skill - Test"
echo "=========================================="
echo ""

# Check SKILL.md
if [ -f "$SCRIPT_DIR/SKILL.md" ]; then
    print_success "SKILL.md exists"
else
    print_error "SKILL.md missing"
    exit 1
fi

# Check README.md
if [ -f "$SCRIPT_DIR/README.md" ]; then
    print_success "README.md exists"
else
    print_error "README.md missing"
    exit 1
fi

# Check references directory
if [ -d "$SCRIPT_DIR/references" ]; then
    print_success "references directory exists"
    
    # Count English book files
    EN_BOOK_COUNT=$(ls -1 "$SCRIPT_DIR/references/"*.md 2>/dev/null | grep -c "[0-9]" || echo "0")
    
    if [ "$EN_BOOK_COUNT" -eq 20 ]; then
        print_success "All 20 English book reference files present"
    else
        print_error "Expected 20 English book reference files, found $EN_BOOK_COUNT"
        exit 1
    fi
    
    # Check Chinese directory
    if [ -d "$SCRIPT_DIR/references/chinese" ]; then
        print_success "Chinese references directory exists"
        
        # Count Chinese book files
        CN_BOOK_COUNT=$(ls -1 "$SCRIPT_DIR/references/chinese/"*.md 2>/dev/null | grep -c "[0-9]" || echo "0")
        
        if [ "$CN_BOOK_COUNT" -eq 20 ]; then
            print_success "All 20 Chinese book reference files present"
        else
            print_error "Expected 20 Chinese book reference files, found $CN_BOOK_COUNT"
            exit 1
        fi
    else
        print_error "Chinese references directory missing"
        exit 1
    fi
else
    print_error "references directory missing"
    exit 1
fi

# Check examples directory
if [ -d "$SCRIPT_DIR/examples" ]; then
    print_success "examples directory exists"
else
    print_error "examples directory missing"
    exit 1
fi

# Check install script
if [ -f "$SCRIPT_DIR/install.sh" ]; then
    print_success "install.sh exists"
else
    print_error "install.sh missing"
    exit 1
fi

# Check LICENSE
if [ -f "$SCRIPT_DIR/LICENSE" ]; then
    print_success "LICENSE exists"
else
    print_error "LICENSE missing"
    exit 1
fi

echo ""
echo "=========================================="
echo "  All tests passed!"
echo "=========================================="
echo ""
echo "The build-your-confidence skill is ready to use."
echo ""
echo "English books: 20 files in references/"
echo "Chinese books: 20 files in references/chinese/"
echo ""
echo "To install, run:"
echo "  ./install.sh"
echo ""
echo "For more information, see README.md"
