#!/usr/bin/env bash
# Demo script for NPM Package Compromise Detection Tools - 2025 Extended Edition

set -euo pipefail

# Color codes for output
RED='\033[0;31m'
YELLOW='\033[1;33m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}================================================================================================${NC}"
echo -e "${BLUE}NPM PACKAGE COMPROMISE DETECTION TOOLS - 2025 EXTENDED EDITION DEMO${NC}"
echo -e "${BLUE}================================================================================================${NC}"
echo
echo -e "${BLUE}This demo will show you how to use both the shell script and Python tools${NC}"
echo -e "${BLUE}to detect compromised NPM packages in your projects.${NC}"
echo

# Check if test sample exists
if [ ! -f "test_sample/package.json" ]; then
    echo -e "${RED}❌ Test sample not found. Please ensure test_sample/package.json exists.${NC}"
    exit 1
fi

# Check dependencies
echo -e "${BLUE}🔍 Checking dependencies...${NC}"

if ! command -v jq >/dev/null 2>&1; then
    echo -e "${RED}❌ jq is required for the shell script but not installed.${NC}"
    echo -e "${YELLOW}Install with: sudo apt-get install jq (Ubuntu/Debian) or brew install jq (macOS)${NC}"
    exit 1
else
    echo -e "${GREEN}✅ jq found${NC}"
fi

if ! command -v python3 >/dev/null 2>&1; then
    echo -e "${RED}❌ Python 3 is required but not installed.${NC}"
    exit 1
else
    echo -e "${GREEN}✅ Python 3 found${NC}"
fi

echo

# Demo 1: Quick Shell Script
echo -e "${BLUE}================================================================================================${NC}"
echo -e "${BLUE}DEMO 1: Quick Shell Script Check${NC}"
echo -e "${BLUE}================================================================================================${NC}"
echo -e "${BLUE}Running: ./quick-check-compromised-packages-2025.sh test_sample${NC}"
echo

if [ -x "quick-check-compromised-packages-2025.sh" ]; then
    ./quick-check-compromised-packages-2025.sh test_sample || true
else
    echo -e "${RED}❌ Shell script is not executable. Run: chmod +x quick-check-compromised-packages-2025.sh${NC}"
fi

echo
echo -e "${YELLOW}Press Enter to continue to Python script demo...${NC}"
read -r

# Demo 2: Python Script - Basic
echo -e "${BLUE}================================================================================================${NC}"
echo -e "${BLUE}DEMO 2: Python Script - Basic Scan${NC}"
echo -e "${BLUE}================================================================================================${NC}"
echo -e "${BLUE}Running: python3 npm_package_compromise_detector_2025.py test_sample${NC}"
echo

if [ -f "npm_package_compromise_detector_2025.py" ]; then
    python3 npm_package_compromise_detector_2025.py test_sample || true
else
    echo -e "${RED}❌ Python script not found.${NC}"
fi

echo
echo -e "${YELLOW}Press Enter to continue to detailed analysis...${NC}"
read -r

# Demo 3: Python Script - Quiet Mode
echo -e "${BLUE}================================================================================================${NC}"
echo -e "${BLUE}DEMO 3: Python Script - Quiet Mode (Critical/High Only)${NC}"
echo -e "${BLUE}================================================================================================${NC}"
echo -e "${BLUE}Running: python3 npm_package_compromise_detector_2025.py test_sample --quiet${NC}"
echo

if [ -f "npm_package_compromise_detector_2025.py" ]; then
    python3 npm_package_compromise_detector_2025.py test_sample --quiet || true
else
    echo -e "${RED}❌ Python script not found.${NC}"
fi

echo
echo -e "${YELLOW}Press Enter to see the generated report...${NC}"
read -r

# Demo 4: Show Generated Report
echo -e "${BLUE}================================================================================================${NC}"
echo -e "${BLUE}DEMO 4: Generated Report Contents${NC}"
echo -e "${BLUE}================================================================================================${NC}"

if [ -f "test_report.txt" ]; then
    echo -e "${BLUE}Showing first 50 lines of test_report.txt:${NC}"
    echo
    head -50 test_report.txt
    echo
    echo -e "${BLUE}... (truncated for demo)${NC}"
    echo
    echo -e "${GREEN}✅ Full report saved to: test_report.txt${NC}"
else
    echo -e "${YELLOW}⚠️  No report file found. Run the Python script with --output option to generate one.${NC}"
fi

echo

# Demo 5: Usage Examples
echo -e "${BLUE}================================================================================================${NC}"
echo -e "${BLUE}DEMO 5: Usage Examples for Your Projects${NC}"
echo -e "${BLUE}================================================================================================${NC}"
echo
echo -e "${BLUE}To scan your own projects, use these commands:${NC}"
echo
echo -e "${GREEN}# Quick check with shell script:${NC}"
echo -e "${YELLOW}./quick-check-compromised-packages-2025.sh /path/to/your/project${NC}"
echo
echo -e "${GREEN}# Comprehensive analysis with Python:${NC}"
echo -e "${YELLOW}python3 npm_package_compromise_detector_2025.py /path/to/your/project --output security_report.txt${NC}"
echo
echo -e "${GREEN}# Full dependency tree analysis (recommended):${NC}"
echo -e "${YELLOW}python3 npm_package_compromise_detector_2025.py /path/to/your/project --full-tree${NC}"
echo
echo -e "${GREEN}# Check current directory:${NC}"
echo -e "${YELLOW}./quick-check-compromised-packages-2025.sh .${NC}"
echo -e "${YELLOW}python3 npm_package_compromise_detector_2025.py .${NC}"
echo

# Summary
echo -e "${BLUE}================================================================================================${NC}"
echo -e "${BLUE}DEMO COMPLETE - SUMMARY${NC}"
echo -e "${BLUE}================================================================================================${NC}"
echo
echo -e "${GREEN}✅ Shell script: Fast, immediate results, perfect for CI/CD pipelines${NC}"
echo -e "${GREEN}✅ Python script: Comprehensive analysis, detailed reports, source code scanning${NC}"
echo
echo -e "${RED}🚨 REMEMBER: If compromised packages are found in your real projects:${NC}"
echo -e "${RED}1. Stop all running applications immediately${NC}"
echo -e "${RED}2. Clear npm cache: npm cache clean --force${NC}"
echo -e "${RED}3. Remove node_modules and lock files${NC}"
echo -e "${RED}4. Update to safe versions using the provided overrides${NC}"
echo -e "${RED}5. Reinstall dependencies and run security audit${NC}"
echo
echo -e "${BLUE}For more information, see README.md${NC}"
echo -e "${BLUE}================================================================================================${NC}"
