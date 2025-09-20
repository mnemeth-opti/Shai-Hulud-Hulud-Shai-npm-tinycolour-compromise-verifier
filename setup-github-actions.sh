#!/usr/bin/env bash
# Quick setup script for GitHub Actions integration
# Usage: ./setup-github-actions.sh [--phoenix]

set -euo pipefail

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

ENABLE_PHOENIX=false

# Parse arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        --phoenix)
            ENABLE_PHOENIX=true
            shift
            ;;
        --help|-h)
            echo "Usage: $0 [--phoenix]"
            echo ""
            echo "Options:"
            echo "  --phoenix    Enable Phoenix Security integration setup"
            echo "  --help, -h   Show this help message"
            exit 0
            ;;
        *)
            echo "Unknown option: $1"
            echo "Use --help for usage information"
            exit 1
            ;;
    esac
done

echo -e "${BLUE}🚀 GitHub Actions Setup for NPM Security Scanner${NC}"
echo -e "${BLUE}=================================================${NC}"
echo

# Check if we're in a git repository
if [ ! -d ".git" ]; then
    echo -e "${RED}❌ This script must be run from the root of a Git repository${NC}"
    exit 1
fi

# Create .github/workflows directory if it doesn't exist
echo -e "${BLUE}📁 Creating GitHub Actions directory structure...${NC}"
mkdir -p .github/workflows

# Check if workflows already exist
WORKFLOWS_EXIST=false
if [ -f ".github/workflows/npm-security-scan.yml" ]; then
    echo -e "${YELLOW}⚠️  Main workflow already exists: .github/workflows/npm-security-scan.yml${NC}"
    WORKFLOWS_EXIST=true
fi

if [ -f ".github/workflows/test-security-scan.yml" ]; then
    echo -e "${YELLOW}⚠️  Test workflow already exists: .github/workflows/test-security-scan.yml${NC}"
    WORKFLOWS_EXIST=true
fi

if [ "$WORKFLOWS_EXIST" = "true" ]; then
    echo -e "${YELLOW}Do you want to overwrite existing workflows? (y/N)${NC}"
    read -r response
    if [[ ! "$response" =~ ^[Yy]$ ]]; then
        echo -e "${BLUE}ℹ️  Skipping workflow file creation${NC}"
        SKIP_WORKFLOWS=true
    else
        SKIP_WORKFLOWS=false
    fi
else
    SKIP_WORKFLOWS=false
fi

# Verify required files exist
echo -e "${BLUE}🔍 Checking required files...${NC}"
REQUIRED_FILES=(
    "enhanced_npm_compromise_detector_phoenix.py"
    "quick-check-compromised-packages-2025.sh"
    "enhanced-quick-check-with-phoenix.sh"
    "compromised_packages_2025.json"
)

MISSING_FILES=()
for file in "${REQUIRED_FILES[@]}"; do
    if [ ! -f "$file" ]; then
        MISSING_FILES+=("$file")
    else
        echo -e "${GREEN}✅ Found: $file${NC}"
    fi
done

if [ ${#MISSING_FILES[@]} -gt 0 ]; then
    echo -e "${RED}❌ Missing required files:${NC}"
    for file in "${MISSING_FILES[@]}"; do
        echo -e "${RED}  - $file${NC}"
    done
    echo -e "${YELLOW}💡 Please ensure all security scanner files are present${NC}"
    exit 1
fi

# Make scripts executable
echo -e "${BLUE}🔧 Making scripts executable...${NC}"
chmod +x *.sh
echo -e "${GREEN}✅ Scripts made executable${NC}"

# Setup Phoenix configuration if requested
if [ "$ENABLE_PHOENIX" = "true" ]; then
    echo -e "${BLUE}🔐 Setting up Phoenix Security integration...${NC}"
    
    if [ ! -f ".config.example" ]; then
        echo -e "${YELLOW}⚠️  Creating Phoenix configuration template...${NC}"
        cat > .config.example << 'EOF'
[phoenix]
# Phoenix Security API Configuration
# IMPORTANT: Replace ALL values below with your actual Phoenix Security credentials

# Required credentials - GET FROM YOUR PHOENIX SECURITY PLATFORM
client_id = your_phoenix_client_id_here
client_secret = your_phoenix_client_secret_here
api_base_url = https://your-phoenix-domain.com/api

# Assessment settings
assessment_name = NPM Compromise Detection - GitHub Actions
import_type = new

# SETUP INSTRUCTIONS:
# 1. Replace 'your_phoenix_client_id_here' with your actual client ID from Phoenix Security
# 2. Replace 'your_phoenix_client_secret_here' with your actual client secret from Phoenix Security
# 3. Replace 'your-phoenix-domain.com/api' with your Phoenix Security API endpoint
# 4. Add these as GitHub repository secrets:
#    - PHOENIX_CLIENT_ID
#    - PHOENIX_CLIENT_SECRET  
#    - PHOENIX_API_URL
EOF
    fi
    
    echo -e "${GREEN}✅ Phoenix configuration template created: .config.example${NC}"
    echo -e "${YELLOW}💡 Remember to configure repository secrets for Phoenix integration:${NC}"
    echo -e "${YELLOW}   - PHOENIX_CLIENT_ID${NC}"
    echo -e "${YELLOW}   - PHOENIX_CLIENT_SECRET${NC}"
    echo -e "${YELLOW}   - PHOENIX_API_URL${NC}"
fi

# Create README for GitHub Actions
if [ ! -f "GITHUB_ACTIONS_SETUP.md" ]; then
    echo -e "${BLUE}📚 GitHub Actions setup guide already exists${NC}"
else
    echo -e "${GREEN}✅ GitHub Actions setup guide available: GITHUB_ACTIONS_SETUP.md${NC}"
fi

# Test the setup
echo -e "${BLUE}🧪 Testing setup...${NC}"

# Test quick script
echo -e "${BLUE}Testing quick check script...${NC}"
if ./quick-check-compromised-packages-2025.sh test_compromised_packages >/dev/null 2>&1; then
    echo -e "${GREEN}✅ Quick check script works${NC}"
else
    echo -e "${YELLOW}⚠️  Quick check script test failed (this may be expected if compromised packages are found)${NC}"
fi

# Test Python script
echo -e "${BLUE}Testing Python detector...${NC}"
if python3 enhanced_npm_compromise_detector_phoenix.py test_compromised_packages --quiet >/dev/null 2>&1; then
    echo -e "${GREEN}✅ Python detector works${NC}"
else
    echo -e "${YELLOW}⚠️  Python detector test failed (this may be expected if compromised packages are found)${NC}"
fi

# Check Python dependencies
echo -e "${BLUE}Checking Python dependencies...${NC}"
if python3 -c "import requests, configparser" 2>/dev/null; then
    echo -e "${GREEN}✅ Python dependencies available${NC}"
else
    echo -e "${YELLOW}⚠️  Python dependencies missing. Install with: pip install requests configparser${NC}"
fi

# Generate summary
echo
echo -e "${GREEN}🎉 GitHub Actions setup complete!${NC}"
echo -e "${BLUE}================================${NC}"
echo

echo -e "${BLUE}📋 Next Steps:${NC}"
echo -e "${BLUE}1. Commit and push the workflow files to your repository${NC}"
echo -e "${BLUE}2. Go to your repository's Actions tab to see the workflows${NC}"

if [ "$ENABLE_PHOENIX" = "true" ]; then
    echo -e "${BLUE}3. Configure Phoenix repository secrets (see GITHUB_ACTIONS_SETUP.md)${NC}"
    echo -e "${BLUE}4. Test Phoenix integration with a manual workflow run${NC}"
else
    echo -e "${BLUE}3. Run a test workflow manually to verify everything works${NC}"
fi

echo -e "${BLUE}5. Set up branch protection rules to enforce security checks${NC}"
echo

echo -e "${BLUE}📚 Documentation:${NC}"
echo -e "${BLUE}- Setup Guide: GITHUB_ACTIONS_SETUP.md${NC}"
echo -e "${BLUE}- Examples: GITHUB_ACTIONS_EXAMPLES.md${NC}"
echo

echo -e "${BLUE}🔗 Quick Links:${NC}"
echo -e "${BLUE}- Repository Actions: https://github.com/$(git remote get-url origin | sed 's/.*github.com[:/]\(.*\)\.git/\1/')/actions${NC}"
echo -e "${BLUE}- Repository Settings: https://github.com/$(git remote get-url origin | sed 's/.*github.com[:/]\(.*\)\.git/\1/')/settings${NC}"

echo
echo -e "${GREEN}✅ Ready for automated NPM security scanning with GitHub Actions!${NC}"
