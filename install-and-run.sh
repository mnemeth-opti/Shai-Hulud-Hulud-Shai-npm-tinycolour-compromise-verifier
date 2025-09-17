#!/usr/bin/env bash
# One-liner installer and runner for NPM Package Compromise Detection
# Usage: curl -s https://raw.githubusercontent.com/your-repo/install-and-run.sh | bash
# Or: curl -s https://raw.githubusercontent.com/your-repo/install-and-run.sh | bash -s /path/to/project

set -euo pipefail

# Configuration
REPO_BASE_URL="https://raw.githubusercontent.com/your-repo/main"
TARGET_DIR="${1:-.}"
TEMP_DIR=$(mktemp -d)
SCRIPT_NAME="quick-check-compromised-packages-2025.sh"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

cleanup() {
    rm -rf "$TEMP_DIR"
}
trap cleanup EXIT

echo -e "${BLUE}🔍 NPM Package Compromise Detection - Quick Installer${NC}"
echo -e "${BLUE}===================================================${NC}"
echo

# Check prerequisites
echo -e "${BLUE}📋 Checking prerequisites...${NC}"

if ! command -v jq >/dev/null 2>&1; then
    echo -e "${YELLOW}⚠️  Installing jq (JSON processor)...${NC}"
    if command -v apt-get >/dev/null 2>&1; then
        sudo apt-get update -qq && sudo apt-get install -y jq
    elif command -v yum >/dev/null 2>&1; then
        sudo yum install -y jq
    elif command -v brew >/dev/null 2>&1; then
        brew install jq
    else
        echo -e "${RED}❌ Cannot install jq automatically. Please install it manually:${NC}"
        echo -e "${RED}   Ubuntu/Debian: sudo apt-get install jq${NC}"
        echo -e "${RED}   RHEL/CentOS: sudo yum install jq${NC}"
        echo -e "${RED}   macOS: brew install jq${NC}"
        exit 1
    fi
fi

echo -e "${GREEN}✅ Prerequisites satisfied${NC}"
echo

# Download security tools
echo -e "${BLUE}📥 Downloading security tools...${NC}"

cd "$TEMP_DIR"

# Download main script
if ! curl -fsSL "${REPO_BASE_URL}/${SCRIPT_NAME}" -o "$SCRIPT_NAME"; then
    echo -e "${RED}❌ Failed to download security script${NC}"
    echo -e "${RED}   Please check your internet connection and repository URL${NC}"
    exit 1
fi

# Download configuration
if ! curl -fsSL "${REPO_BASE_URL}/compromised_packages_2025.json" -o "compromised_packages_2025.json"; then
    echo -e "${YELLOW}⚠️  Could not download configuration file, using embedded data${NC}"
fi

# Download Python script (optional)
if curl -fsSL "${REPO_BASE_URL}/npm_package_compromise_detector_2025.py" -o "npm_package_compromise_detector_2025.py" 2>/dev/null; then
    echo -e "${GREEN}✅ Downloaded comprehensive analysis tool${NC}"
    PYTHON_AVAILABLE=true
else
    echo -e "${YELLOW}⚠️  Python analysis tool not available, using shell script only${NC}"
    PYTHON_AVAILABLE=false
fi

chmod +x "$SCRIPT_NAME"
echo -e "${GREEN}✅ Security tools downloaded${NC}"
echo

# Run security scan
echo -e "${BLUE}🔍 Running security scan on: ${TARGET_DIR}${NC}"
echo -e "${BLUE}===========================================${NC}"
echo

# Run the quick check
set +e  # Don't exit on scan failure
"./$SCRIPT_NAME" "$(realpath "$TARGET_DIR")"
SCAN_RESULT=$?
set -e

echo
echo -e "${BLUE}===========================================${NC}"

# Interpret results
if [ $SCAN_RESULT -eq 0 ]; then
    echo -e "${GREEN}✅ SCAN COMPLETE: No compromised packages detected${NC}"
    echo -e "${GREEN}   Your project appears to be clean of known compromised packages.${NC}"
    
    if [ "$PYTHON_AVAILABLE" = true ]; then
        echo
        echo -e "${BLUE}💡 For comprehensive analysis, run:${NC}"
        echo -e "${BLUE}   python3 $(realpath "$TEMP_DIR")/npm_package_compromise_detector_2025.py \"$TARGET_DIR\" --full-tree${NC}"
    fi
    
elif [ $SCAN_RESULT -eq 1 ]; then
    echo -e "${RED}🚨 CRITICAL: Compromised packages detected!${NC}"
    echo
    echo -e "${RED}IMMEDIATE ACTIONS REQUIRED:${NC}"
    echo -e "${RED}1. Stop all running applications immediately${NC}"
    echo -e "${RED}2. Clear npm cache: npm cache clean --force${NC}"
    echo -e "${RED}3. Remove node_modules: rm -rf node_modules${NC}"
    echo -e "${RED}4. Remove lock files: rm package-lock.json yarn.lock${NC}"
    echo -e "${RED}5. Update to safe versions and reinstall${NC}"
    echo
    
    if [ "$PYTHON_AVAILABLE" = true ]; then
        echo -e "${YELLOW}📋 For detailed analysis and safe version recommendations:${NC}"
        echo -e "${YELLOW}   python3 $(realpath "$TEMP_DIR")/npm_package_compromise_detector_2025.py \"$TARGET_DIR\" --output security-report.txt${NC}"
        echo
    fi
    
else
    echo -e "${YELLOW}⚠️  Scan completed with warnings (exit code: $SCAN_RESULT)${NC}"
    echo -e "${YELLOW}   Check the output above for details${NC}"
fi

# Provide next steps
echo
echo -e "${BLUE}📚 For more information:${NC}"
echo -e "${BLUE}   • GitHub Repository: [Add your repository URL]${NC}"
echo -e "${BLUE}   • Documentation: README.md${NC}"
echo -e "${BLUE}   • Quick Start Guide: QUICK_START.md${NC}"

# Cleanup message
echo
echo -e "${BLUE}🧹 Security tools will be cleaned up when this script exits${NC}"
echo -e "${BLUE}   To keep them permanently, copy from: $TEMP_DIR${NC}"

# Exit with the same code as the scan
exit $SCAN_RESULT
