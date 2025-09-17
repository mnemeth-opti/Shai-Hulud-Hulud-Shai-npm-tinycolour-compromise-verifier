#!/usr/bin/env bash
# Local NPM Package Compromise Detection Runner
# Usage: ./local-security-check.sh [directory]

set -euo pipefail

# Configuration
TARGET_DIR="${1:-.}"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${BLUE}🔍 NPM Package Compromise Detection - Local Runner${NC}"
echo -e "${BLUE}================================================${NC}"
echo

# Check prerequisites
echo -e "${BLUE}📋 Checking prerequisites...${NC}"

if ! command -v jq >/dev/null 2>&1; then
    echo -e "${RED}❌ jq is required but not installed.${NC}"
    echo -e "${YELLOW}Install with:${NC}"
    echo -e "${YELLOW}  Ubuntu/Debian: sudo apt-get install jq${NC}"
    echo -e "${YELLOW}  macOS: brew install jq${NC}"
    echo -e "${YELLOW}  RHEL/CentOS: sudo yum install jq${NC}"
    exit 1
fi

echo -e "${GREEN}✅ Prerequisites satisfied${NC}"
echo

# Check for security tools
QUICK_SCRIPT="$SCRIPT_DIR/quick-check-compromised-packages-2025.sh"
PYTHON_SCRIPT="$SCRIPT_DIR/npm_package_compromise_detector_2025.py"

if [ ! -f "$QUICK_SCRIPT" ]; then
    echo -e "${RED}❌ Quick check script not found: $QUICK_SCRIPT${NC}"
    exit 1
fi

if [ ! -x "$QUICK_SCRIPT" ]; then
    echo -e "${YELLOW}⚠️  Making quick check script executable...${NC}"
    chmod +x "$QUICK_SCRIPT"
fi

echo -e "${GREEN}✅ Security tools found${NC}"
echo

# Run security scan
echo -e "${BLUE}🔍 Running security scan on: ${TARGET_DIR}${NC}"
echo -e "${BLUE}===========================================${NC}"
echo

# Run the quick check
set +e  # Don't exit on scan failure
"$QUICK_SCRIPT" "$(realpath "$TARGET_DIR")"
SCAN_RESULT=$?
set -e

echo
echo -e "${BLUE}===========================================${NC}"

# Interpret results
if [ $SCAN_RESULT -eq 0 ]; then
    echo -e "${GREEN}✅ SCAN COMPLETE: No compromised packages detected${NC}"
    echo -e "${GREEN}   Your project appears to be clean of known compromised packages.${NC}"
    
    if [ -f "$PYTHON_SCRIPT" ]; then
        echo
        echo -e "${BLUE}💡 For comprehensive analysis, run:${NC}"
        echo -e "${BLUE}   python3 \"$PYTHON_SCRIPT\" \"$TARGET_DIR\" --full-tree${NC}"
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
    
    if [ -f "$PYTHON_SCRIPT" ]; then
        echo -e "${YELLOW}📋 For detailed analysis and safe version recommendations:${NC}"
        echo -e "${YELLOW}   python3 \"$PYTHON_SCRIPT\" \"$TARGET_DIR\" --output security-report.txt${NC}"
        echo
    fi
    
else
    echo -e "${YELLOW}⚠️  Scan completed with warnings (exit code: $SCAN_RESULT)${NC}"
    echo -e "${YELLOW}   Check the output above for details${NC}"
fi

# Exit with the same code as the scan
exit $SCAN_RESULT
