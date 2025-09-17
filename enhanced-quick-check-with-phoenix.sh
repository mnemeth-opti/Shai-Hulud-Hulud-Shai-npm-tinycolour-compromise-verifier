#!/usr/bin/env bash
set -euo pipefail

# Enhanced Quick NPM Package Compromise Checker with Phoenix Integration
# Combines the quick bash check with the enhanced Python detector and Phoenix API
# Author: DevSecOps Security Team
# Date: September 2025

# Color codes for output
RED='\033[0;31m'
YELLOW='\033[1;33m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Configuration
ENABLE_PHOENIX=${ENABLE_PHOENIX:-false}
ENABLE_LIGHT_SCAN=${ENABLE_LIGHT_SCAN:-false}
REPO_LIST_MODE=${REPO_LIST_MODE:-false}
PHOENIX_CONFIG=${PHOENIX_CONFIG:-.config}
QUICK_CHECK_SCRIPT="./quick-check-compromised-packages-2025.sh"
ENHANCED_DETECTOR="./enhanced_npm_compromise_detector_phoenix.py"

# Function to print header
print_header() {
    echo -e "${BLUE}================================================================================================${NC}"
    echo -e "${BLUE}ENHANCED NPM PACKAGE COMPROMISE CHECKER WITH PHOENIX INTEGRATION${NC}"
    echo -e "${BLUE}================================================================================================${NC}"
    if [ "$ENABLE_LIGHT_SCAN" = true ]; then
        echo -e "${BLUE}🪶 Light scan + Phoenix Security API integration (10x faster!)${NC}"
    else
        echo -e "${BLUE}Quick scan + Detailed analysis + Phoenix Security API integration${NC}"
    fi
    echo -e "${BLUE}Date: $(date)${NC}"
    echo -e "${BLUE}================================================================================================${NC}"
    echo
}

# Function to check prerequisites
check_prerequisites() {
    local missing_tools=()
    
    # Check for required scripts
    if [ ! -f "$QUICK_CHECK_SCRIPT" ]; then
        missing_tools+=("quick-check-compromised-packages-2025.sh")
    fi
    
    if [ ! -f "$ENHANCED_DETECTOR" ]; then
        missing_tools+=("enhanced_npm_compromise_detector_phoenix.py")
    fi
    
    # Check for Python 3
    if ! command -v python3 >/dev/null 2>&1; then
        missing_tools+=("python3")
    fi
    
    # Check for jq (required by quick check)
    if ! command -v jq >/dev/null 2>&1; then
        missing_tools+=("jq")
    fi
    
    if [ ${#missing_tools[@]} -gt 0 ]; then
        echo -e "${RED}❌ Missing required tools/files:${NC}"
        for tool in "${missing_tools[@]}"; do
            echo -e "${RED}  - $tool${NC}"
        done
        echo
        echo -e "${YELLOW}💡 Please ensure all required files are present and tools are installed${NC}"
        exit 1
    fi
    
    echo -e "${GREEN}✅ All prerequisites checked${NC}"
}

# Function to check Phoenix configuration
check_phoenix_config() {
    if [ "$ENABLE_PHOENIX" = true ]; then
        if [ -f "$PHOENIX_CONFIG" ]; then
            echo -e "${GREEN}✅ Phoenix configuration found: $PHOENIX_CONFIG${NC}"
            
            # Check if configuration has required fields
            if grep -q "client_id.*=.*your_client_id_here" "$PHOENIX_CONFIG" 2>/dev/null; then
                echo -e "${YELLOW}⚠️  Phoenix configuration contains template values${NC}"
                echo -e "${YELLOW}💡 Please update $PHOENIX_CONFIG with your actual credentials${NC}"
            else
                echo -e "${GREEN}✅ Phoenix configuration appears to be customized${NC}"
            fi
        else
            echo -e "${YELLOW}⚠️  Phoenix integration enabled but configuration not found${NC}"
            echo -e "${YELLOW}💡 Run: python3 $ENHANCED_DETECTOR --create-config${NC}"
            echo -e "${YELLOW}💡 Then copy .config.example to $PHOENIX_CONFIG and customize${NC}"
        fi
    else
        echo -e "${BLUE}ℹ️  Phoenix integration disabled${NC}"
    fi
    echo
}

# Function to run quick check
run_quick_check() {
    local target="$1"
    
    echo -e "${BLUE}🚀 PHASE 1: Quick Compromise Check${NC}"
    echo -e "${BLUE}=================================${NC}"
    
    # Run the quick check script
    if bash "$QUICK_CHECK_SCRIPT" "$target"; then
        echo -e "${GREEN}✅ Quick check passed - no obvious compromised packages detected${NC}"
        return 0
    else
        echo -e "${RED}❌ Quick check detected potential issues${NC}"
        return 1
    fi
}

# Function to run enhanced analysis
run_enhanced_analysis() {
    local target="$1"
    local phoenix_args=""
    local analysis_args=""
    
    if [ "$ENABLE_LIGHT_SCAN" = true ]; then
        echo -e "${BLUE}🚀 PHASE 2: Enhanced Light Scan Analysis${NC}"
        echo -e "${BLUE}=========================================${NC}"
        echo -e "${BLUE}🪶 Light scan mode: NPM files only (10x faster)${NC}"
    else
        echo -e "${BLUE}🚀 PHASE 2: Enhanced Analysis${NC}"
        echo -e "${BLUE}==============================${NC}"
    fi
    
    # Build Phoenix arguments
    if [ "$ENABLE_PHOENIX" = true ]; then
        phoenix_args="--enable-phoenix"
        if [ -n "${PHOENIX_CONFIG}" ]; then
            phoenix_args="$phoenix_args --phoenix-config $PHOENIX_CONFIG"
        fi
    fi
    
    # Build analysis arguments
    if [ "$ENABLE_LIGHT_SCAN" = true ]; then
        analysis_args="--light-scan"
        if [ "$REPO_LIST_MODE" = true ]; then
            analysis_args="$analysis_args --repo-list"
        fi
    else
        analysis_args="--full-tree"
    fi
    
    # Run enhanced detector
    local output_file="enhanced_analysis_$(date +%Y%m%d_%H%M%S).txt"
    
    if [ "$ENABLE_LIGHT_SCAN" = true ]; then
        echo -e "${BLUE}🪶 Running light scan analysis...${NC}"
        if [ "$REPO_LIST_MODE" = true ]; then
            echo -e "${BLUE}📋 Processing repository list with GitHub API${NC}"
        fi
    else
        echo -e "${BLUE}📊 Running comprehensive analysis...${NC}"
    fi
    
    if python3 "$ENHANCED_DETECTOR" "$target" $phoenix_args $analysis_args --output "$output_file"; then
        echo -e "${GREEN}✅ Enhanced analysis completed successfully${NC}"
        echo -e "${GREEN}📄 Detailed report saved to: $output_file${NC}"
        return 0
    else
        echo -e "${RED}❌ Enhanced analysis detected security issues${NC}"
        echo -e "${YELLOW}📄 Detailed report saved to: $output_file${NC}"
        return 1
    fi
}

# Function to generate summary
generate_summary() {
    local quick_check_result="$1"
    local enhanced_result="$2"
    
    echo -e "${BLUE}================================================================================================${NC}"
    echo -e "${BLUE}FINAL SUMMARY${NC}"
    echo -e "${BLUE}================================================================================================${NC}"
    
    if [ "$quick_check_result" -eq 0 ] && [ "$enhanced_result" -eq 0 ]; then
        echo -e "${GREEN}🎉 CLEAN: No compromised packages detected in either quick or enhanced analysis${NC}"
        echo -e "${GREEN}✅ Your project appears to be secure from known NPM package compromises${NC}"
        
        if [ "$ENABLE_PHOENIX" = true ]; then
            echo -e "${GREEN}🔗 Results have been imported to Phoenix Security platform${NC}"
        fi
        
        if [ "$ENABLE_LIGHT_SCAN" = true ]; then
            echo -e "${GREEN}🪶 Light scan completed successfully - zero storage footprint${NC}"
        fi
        
        echo
        echo -e "${BLUE}💡 Recommendations:${NC}"
        echo -e "${BLUE}  - Continue regular security monitoring${NC}"
        echo -e "${BLUE}  - Run 'npm audit' for other vulnerabilities${NC}"
        echo -e "${BLUE}  - Keep dependencies updated${NC}"
        if [ "$ENABLE_LIGHT_SCAN" = true ]; then
            echo -e "${BLUE}  - Consider running light scans daily for batch monitoring${NC}"
        fi
        
    elif [ "$quick_check_result" -ne 0 ] || [ "$enhanced_result" -ne 0 ]; then
        echo -e "${RED}🚨 COMPROMISED: Security issues detected${NC}"
        echo -e "${RED}❌ Immediate action required${NC}"
        
        if [ "$ENABLE_PHOENIX" = true ]; then
            echo -e "${YELLOW}🔗 Issues have been reported to Phoenix Security platform${NC}"
        fi
        
        echo
        echo -e "${RED}🚨 IMMEDIATE ACTIONS:${NC}"
        echo -e "${RED}  1. Stop all running applications${NC}"
        echo -e "${RED}  2. Review the detailed analysis report${NC}"
        echo -e "${RED}  3. Update or remove compromised packages${NC}"
        echo -e "${RED}  4. Clear npm cache: npm cache clean --force${NC}"
        echo -e "${RED}  5. Remove node_modules and reinstall${NC}"
        echo -e "${RED}  6. Review application logs for suspicious activity${NC}"
        
    fi
    
    echo -e "${BLUE}================================================================================================${NC}"
}

# Main function
main() {
    local target="${1:-.}"
    local quick_check_result=0
    local enhanced_result=0
    
    print_header
    
    # Parse command line arguments
    while [[ $# -gt 0 ]]; do
        case $1 in
            --enable-phoenix)
                ENABLE_PHOENIX=true
                shift
                ;;
            --phoenix-config)
                PHOENIX_CONFIG="$2"
                shift 2
                ;;
            --light-scan)
                ENABLE_LIGHT_SCAN=true
                shift
                ;;
            --repo-list)
                REPO_LIST_MODE=true
                shift
                ;;
            --help|-h)
                echo "Usage: $0 [target] [options]"
                echo ""
                echo "Arguments:"
                echo "  target                   Directory to scan or repository list file"
                echo ""
                echo "Options:"
                echo "  --enable-phoenix         Enable Phoenix Security API integration"
                echo "  --phoenix-config FILE    Specify Phoenix configuration file (default: .config)"
                echo "  --light-scan             Enable light scan mode (NPM files only, 10x faster)"
                echo "  --repo-list              Treat target as repository list file"
                echo "  --help, -h              Show this help message"
                echo ""
                echo "Environment Variables:"
                echo "  ENABLE_PHOENIX=true     Enable Phoenix integration"
                echo "  ENABLE_LIGHT_SCAN=true  Enable light scan mode"
                echo "  REPO_LIST_MODE=true     Repository list mode"
                echo "  PHOENIX_CONFIG=file     Phoenix configuration file"
                echo "  GITHUB_TOKEN=token      GitHub API token for higher rate limits"
                echo ""
                echo "Examples:"
                echo "  $0                                           # Scan current directory"
                echo "  $0 /path/to/project                          # Scan specific directory"
                echo "  $0 --enable-phoenix                          # Scan with Phoenix integration"
                echo "  $0 --enable-phoenix --light-scan             # Fast scan with Phoenix"
                echo "  $0 repos.txt --repo-list --light-scan        # Batch scan repository list"
                echo "  $0 repos.txt --repo-list --enable-phoenix --light-scan  # Enterprise batch scan"
                echo ""
                echo "🪶 Light Scan Benefits:"
                echo "  - 10x faster than full repository cloning"
                echo "  - Zero storage footprint (no local repos)"
                echo "  - Perfect for batch scanning hundreds of repositories"
                echo "  - Uses GitHub API for selective NPM file access"
                exit 0
                ;;
            -*)
                echo "Unknown option: $1" >&2
                echo "Use --help for usage information"
                exit 1
                ;;
            *)
                target="$1"
                shift
                ;;
        esac
    done
    
    echo -e "${BLUE}📁 Target: $(realpath "$target")${NC}"
    if [ "$ENABLE_PHOENIX" = true ]; then
        echo -e "${BLUE}🔗 Phoenix Integration: Enabled${NC}"
    else
        echo -e "${BLUE}🔗 Phoenix Integration: Disabled${NC}"
    fi
    if [ "$ENABLE_LIGHT_SCAN" = true ]; then
        echo -e "${BLUE}🪶 Light Scan Mode: Enabled (10x faster)${NC}"
        if [ "$REPO_LIST_MODE" = true ]; then
            echo -e "${BLUE}📋 Repository List Mode: Enabled${NC}"
        fi
        if [ -n "${GITHUB_TOKEN:-}" ]; then
            echo -e "${BLUE}🔑 GitHub Token: Available (higher rate limits)${NC}"
        else
            echo -e "${YELLOW}💡 Tip: Set GITHUB_TOKEN for higher GitHub API rate limits${NC}"
        fi
    fi
    echo
    
    # Check prerequisites
    check_prerequisites
    check_phoenix_config
    
    # Phase 1: Quick check (skip for repository list mode)
    if [ "$REPO_LIST_MODE" = true ] || [ "$ENABLE_LIGHT_SCAN" = true ]; then
        echo -e "${BLUE}⏭️  Skipping Phase 1 (quick check) - using enhanced analysis directly${NC}"
        quick_check_result=0
    else
        if run_quick_check "$target"; then
            quick_check_result=0
        else
            quick_check_result=1
        fi
        echo
    fi
    
    # Phase 2: Enhanced analysis (always run for comprehensive results)
    if run_enhanced_analysis "$target"; then
        enhanced_result=0
    else
        enhanced_result=1
    fi
    
    echo
    
    # Generate final summary
    generate_summary $quick_check_result $enhanced_result
    
    # Exit with error code if any issues found
    if [ $quick_check_result -ne 0 ] || [ $enhanced_result -ne 0 ]; then
        exit 1
    else
        exit 0
    fi
}

# Export functions for testing
export -f print_header check_prerequisites check_phoenix_config
export -f run_quick_check run_enhanced_analysis generate_summary

# Run main function with all arguments
main "$@"
