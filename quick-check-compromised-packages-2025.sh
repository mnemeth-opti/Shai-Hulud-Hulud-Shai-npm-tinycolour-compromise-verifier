#!/usr/bin/env bash
set -euo pipefail

# Quick NPM Package Compromise Checker - 2025 Extended Edition
# Checks for specific compromised packages and versions
# Author: DevSecOps Security Team
# Date: September 2025

# Color codes for output
RED='\033[0;31m'
YELLOW='\033[1;33m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Compromised packages with specific versions
compromised_packages_json='[
  {"name":"@ctrl/tinycolor","versions":["4.1.1","4.1.2"]},
  {"name":"angulartics2","versions":["14.1.2"]},
  {"name":"@ctrl/deluge","versions":["7.2.2"]},
  {"name":"@ctrl/golang-template","versions":["1.4.3"]},
  {"name":"@ctrl/magnet-link","versions":["4.0.4"]},
  {"name":"@ctrl/ngx-codemirror","versions":["7.0.2"]},
  {"name":"@ctrl/ngx-csv","versions":["6.0.2"]},
  {"name":"@ctrl/ngx-emoji-mart","versions":["9.2.2"]},
  {"name":"@ctrl/ngx-rightclick","versions":["4.0.2"]},
  {"name":"@ctrl/qbittorrent","versions":["9.7.2"]},
  {"name":"@ctrl/react-adsense","versions":["2.0.2"]},
  {"name":"@ctrl/shared-torrent","versions":["6.3.2"]},
  {"name":"@ctrl/torrent-file","versions":["4.1.2"]},
  {"name":"@ctrl/transmission","versions":["7.3.1"]},
  {"name":"@ctrl/ts-base32","versions":["4.0.2"]},
  {"name":"encounter-playground","versions":["0.0.5"]},
  {"name":"json-rules-engine-simplified","versions":["0.2.4","0.2.1"]},
  {"name":"koa2-swagger-ui","versions":["5.11.2","5.11.1"]},
  {"name":"@nativescript-community/gesturehandler","versions":["2.0.35"]},
  {"name":"@nativescript-community/sentry","versions":["4.6.43"]},
  {"name":"@nativescript-community/text","versions":["1.6.13"]},
  {"name":"@nativescript-community/ui-collectionview","versions":["6.0.6"]},
  {"name":"@nativescript-community/ui-drawer","versions":["0.1.30"]},
  {"name":"@nativescript-community/ui-image","versions":["4.5.6"]},
  {"name":"@nativescript-community/ui-material-bottomsheet","versions":["7.2.72"]},
  {"name":"@nativescript-community/ui-material-core","versions":["7.2.76"]},
  {"name":"@nativescript-community/ui-material-core-tabs","versions":["7.2.76"]},
  {"name":"ngx-color","versions":["10.0.2"]},
  {"name":"ngx-toastr","versions":["19.0.2"]},
  {"name":"ngx-trend","versions":["8.0.1"]},
  {"name":"react-complaint-image","versions":["0.0.35"]},
  {"name":"react-jsonschema-form-conditionals","versions":["0.3.21"]},
  {"name":"react-jsonschema-form-extras","versions":["1.0.4"]},
  {"name":"rxnt-authentication","versions":["0.0.6"]},
  {"name":"rxnt-healthchecks-nestjs","versions":["1.0.5"]},
  {"name":"rxnt-kue","versions":["1.0.7"]},
  {"name":"swc-plugin-component-annotate","versions":["1.9.2"]},
  {"name":"ts-gaussian","versions":["3.0.6"]}
]'

# Potentially compromised packages (any version)
potentially_compromised='[
  "@ahmedhfarag/ngx-perfect-scrollbar",
  "@ahmedhfarag/ngx-virtual-scroller",
  "@art-ws/common",
  "@art-ws/config-eslint",
  "@art-ws/config-ts",
  "@art-ws/db-context",
  "@art-ws/di",
  "@art-ws/di-node",
  "@art-ws/eslint",
  "@art-ws/fastify-http-server",
  "@art-ws/http-server",
  "@art-ws/openapi",
  "@art-ws/package-base",
  "@art-ws/prettier",
  "@art-ws/slf",
  "@art-ws/ssl-info",
  "@art-ws/web-app",
  "@crowdstrike/commitlint",
  "@crowdstrike/falcon-shoelace",
  "@crowdstrike/foundry-js",
  "@crowdstrike/glide-core",
  "@crowdstrike/logscale-dashboard",
  "@crowdstrike/logscale-file-editor",
  "@crowdstrike/logscale-parser-edit",
  "@crowdstrike/logscale-search",
  "@crowdstrike/tailwind-toucan-base",
  "@hestjs/core",
  "@hestjs/cqrs",
  "@hestjs/demo",
  "@hestjs/eslint-config",
  "@hestjs/logger",
  "@hestjs/scalar",
  "@hestjs/validation",
  "@nativescript-community/arraybuffers",
  "@nativescript-community/perms",
  "@nativescript-community/sqlite",
  "@nativescript-community/typeorm",
  "@nativescript-community/ui-document-picker"
]'

# Check if jq is available
if ! command -v jq >/dev/null 2>&1; then
  echo -e "${RED}Error: 'jq' is required but not installed.${NC}"
  echo "Please install jq: sudo apt-get install jq (Ubuntu/Debian) or brew install jq (macOS)"
  exit 1
fi

# Function to print header
print_header() {
    echo -e "${BLUE}================================================================================================${NC}"
    echo -e "${BLUE}NPM PACKAGE COMPROMISE CHECKER - 2025 EXTENDED EDITION${NC}"
    echo -e "${BLUE}================================================================================================${NC}"
    echo -e "${BLUE}Scanning for compromised packages including @ctrl, @nativescript-community, and other affected packages${NC}"
    echo -e "${BLUE}Date: $(date)${NC}"
    echo -e "${BLUE}================================================================================================${NC}"
    echo
}

# Function to check npm cache
check_npm_cache() {
    echo -e "${BLUE}🗂️  Checking npm cache for compromised packages...${NC}"
    
    if ! command -v npm >/dev/null 2>&1; then
        echo -e "${YELLOW}⚠️  npm not found, skipping cache check${NC}"
        return
    fi
    
    local found_in_cache=false
    local cache_output
    
    # Get npm cache list
    cache_output="$(npm cache ls 2>/dev/null || true)"
    
    if [ -z "$cache_output" ]; then
        echo -e "${GREEN}✅ npm cache is empty or not accessible${NC}"
        return
    fi
    
    # Check compromised packages with specific versions
    echo "$compromised_packages_json" | jq -r '.[] | "\(.name)\t\(.versions[])"' | \
    while IFS=$'\t' read -r name version; do
        if [ -n "$name" ] && [ -n "$version" ]; then
            package_pattern="${name}-${version}"
            if echo "$cache_output" | grep -q "$package_pattern"; then
                echo -e "${RED}🚨 CRITICAL: Compromised package found in cache: ${name}@${version}${NC}"
                found_in_cache=true
            fi
        fi
    done
    
    # Check potentially compromised packages
    echo "$potentially_compromised" | jq -r '.[]' | \
    while read -r name; do
        if [ -n "$name" ]; then
            # For scoped packages, escape the @ symbol for grep
            escaped_name=$(echo "$name" | sed 's/@/\\@/g')
            if echo "$cache_output" | grep -q "$escaped_name"; then
                echo -e "${YELLOW}⚠️  HIGH: Potentially compromised package found in cache: ${name}${NC}"
                found_in_cache=true
            fi
        fi
    done
    
    if [ "$found_in_cache" = false ]; then
        echo -e "${GREEN}✅ No compromised packages found in npm cache${NC}"
    else
        echo -e "${RED}❌ Compromised packages detected in npm cache!${NC}"
        echo -e "${YELLOW}💡 Recommendation: Run 'npm cache clean --force' to clear the cache${NC}"
    fi
    echo
}

# Function to check package.json files
check_package_json() {
    local file="$1"
    local temp_file=$(mktemp)
    echo "0" > "$temp_file"
    
    echo -e "${BLUE}📦 Checking: $file${NC}"
    
    if [ ! -f "$file" ]; then
        echo -e "${RED}❌ File not found: $file${NC}"
        rm -f "$temp_file"
        return 1
    fi
    
    if ! jq empty "$file" 2>/dev/null; then
        echo -e "${RED}❌ Invalid JSON in: $file${NC}"
        rm -f "$temp_file"
        return 1
    fi
    
    # Check dependencies sections
    for dep_type in dependencies devDependencies peerDependencies optionalDependencies; do
        if jq -e ".$dep_type" "$file" >/dev/null 2>&1; then
            echo -e "${BLUE}  🔍 Checking $dep_type...${NC}"
            
            # Check compromised packages with specific versions
            echo "$compromised_packages_json" | jq -r '.[] | "\(.name)\t\(.versions[])"' | \
            while IFS=$'\t' read -r name version; do
                if [ -n "$name" ] && [ -n "$version" ]; then
                    # Check if package exists with specific version
                    pkg_version=$(jq -r ".$dep_type[\"$name\"] // empty" "$file" 2>/dev/null)
                    if [ -n "$pkg_version" ]; then
                        # Normalize version (remove ^, ~, etc.)
                        clean_version=$(echo "$pkg_version" | sed 's/^[^0-9]*//')
                        if [ "$clean_version" = "$version" ]; then
                            echo -e "${RED}    🚨 CRITICAL: Compromised package detected: ${name}@${pkg_version} in $dep_type${NC}"
                            echo "$(($(cat "$temp_file") + 1))" > "$temp_file"
                        fi
                    fi
                fi
            done
            
            # Check potentially compromised packages
            echo "$potentially_compromised" | jq -r '.[]' | \
            while read -r name; do
                if [ -n "$name" ]; then
                    pkg_version=$(jq -r ".$dep_type[\"$name\"] // empty" "$file" 2>/dev/null)
                    if [ -n "$pkg_version" ]; then
                        echo -e "${YELLOW}    ⚠️  HIGH: Potentially compromised package detected: ${name}@${pkg_version} in $dep_type${NC}"
                        echo "$(($(cat "$temp_file") + 1))" > "$temp_file"
                    fi
                fi
            done
        fi
    done
    
    local found_issues=$(cat "$temp_file")
    rm -f "$temp_file"
    
    if [ "$found_issues" -eq 0 ]; then
        echo -e "${GREEN}  ✅ No compromised packages found in $file${NC}"
        return 0
    else
        echo -e "${RED}  ❌ Found $found_issues compromised package(s) in $file${NC}"
        return 1  # Return error code if issues found
    fi
    echo
}

# Function to check package-lock.json
check_package_lock() {
    local file="$1"
    local found_issues=0
    
    echo -e "${BLUE}🔒 Checking lock file: $file${NC}"
    
    if [ ! -f "$file" ]; then
        echo -e "${YELLOW}⚠️  Lock file not found: $file${NC}"
        return 0
    fi
    
    if ! jq empty "$file" 2>/dev/null; then
        echo -e "${RED}❌ Invalid JSON in lock file: $file${NC}"
        return 1
    fi
    
    # Check packages section (lockfile v2/v3)
    if jq -e '.packages' "$file" >/dev/null 2>&1; then
        echo -e "${BLUE}  🔍 Checking packages section...${NC}"
        
        # Check compromised packages with specific versions
        echo "$compromised_packages_json" | jq -r '.[] | "\(.name)\t\(.versions[])"' | \
        while IFS=$'\t' read -r name version; do
            if [ -n "$name" ] && [ -n "$version" ]; then
                # Look for the package in node_modules paths
                if jq -r '.packages | to_entries[] | select(.key | contains("node_modules/'"$name"'")) | .value.version' "$file" 2>/dev/null | grep -q "^$version$"; then
                    echo -e "${RED}    🚨 CRITICAL: Compromised package in lock file: ${name}@${version}${NC}"
                    found_issues=$((found_issues + 1))
                fi
            fi
        done
        
        # Check potentially compromised packages
        echo "$potentially_compromised" | jq -r '.[]' | \
        while read -r name; do
            if [ -n "$name" ]; then
                versions=$(jq -r '.packages | to_entries[] | select(.key | contains("node_modules/'"$name"'")) | .value.version' "$file" 2>/dev/null)
                if [ -n "$versions" ]; then
                    echo "$versions" | while read -r ver; do
                        if [ -n "$ver" ]; then
                            echo -e "${YELLOW}    ⚠️  HIGH: Potentially compromised package in lock file: ${name}@${ver}${NC}"
                            found_issues=$((found_issues + 1))
                        fi
                    done
                fi
            fi
        done
    fi
    
    # Check dependencies section (lockfile v1)
    if jq -e '.dependencies' "$file" >/dev/null 2>&1; then
        echo -e "${BLUE}  🔍 Checking dependencies section...${NC}"
        
        # This is more complex for v1 lockfiles - simplified check
        echo "$compromised_packages_json" | jq -r '.[] | "\(.name)\t\(.versions[])"' | \
        while IFS=$'\t' read -r name version; do
            if [ -n "$name" ] && [ -n "$version" ]; then
                if jq -r --arg pkg "$name" '.dependencies[$pkg].version // empty' "$file" 2>/dev/null | grep -q "^$version$"; then
                    echo -e "${RED}    🚨 CRITICAL: Compromised package in lock dependencies: ${name}@${version}${NC}"
                    found_issues=$((found_issues + 1))
                fi
            fi
        done
    fi
    
    if [ "$found_issues" -eq 0 ]; then
        echo -e "${GREEN}  ✅ No compromised packages found in lock file${NC}"
        return 0
    else
        echo -e "${RED}  ❌ Found $found_issues compromised package(s) in lock file${NC}"
        return 1
    fi
    echo
}

# Function to generate summary report
generate_summary() {
    local total_files_checked="$1"
    local issues_found="$2"
    
    echo -e "${BLUE}================================================================================================${NC}"
    echo -e "${BLUE}SCAN SUMMARY${NC}"
    echo -e "${BLUE}================================================================================================${NC}"
    echo -e "${BLUE}Files checked: $total_files_checked${NC}"
    echo -e "${BLUE}Date: $(date)${NC}"
    
    if [ "$issues_found" -gt 0 ]; then
        echo -e "${RED}Status: ❌ COMPROMISED PACKAGES DETECTED${NC}"
        echo
        echo -e "${RED}🚨 IMMEDIATE ACTIONS REQUIRED:${NC}"
        echo -e "${RED}1. Stop all running applications immediately${NC}"
        echo -e "${RED}2. Remove or update all compromised packages${NC}"
        echo -e "${RED}3. Clear npm cache: npm cache clean --force${NC}"
        echo -e "${RED}4. Remove node_modules: rm -rf node_modules${NC}"
        echo -e "${RED}5. Remove lock files: rm package-lock.json yarn.lock${NC}"
        echo -e "${RED}6. Update to safe versions and reinstall${NC}"
        echo -e "${RED}7. Review application logs for suspicious activity${NC}"
        echo
        echo -e "${YELLOW}📋 For detailed analysis, run:${NC}"
        echo -e "${YELLOW}python3 npm_package_compromise_detector_2025.py --full-tree${NC}"
    else
        echo -e "${GREEN}Status: ✅ NO COMPROMISED PACKAGES DETECTED${NC}"
        echo -e "${GREEN}Your project appears to be clean of known compromised packages.${NC}"
        echo
        echo -e "${BLUE}💡 Recommendations:${NC}"
        echo -e "${BLUE}1. Run regular security audits: npm audit${NC}"
        echo -e "${BLUE}2. Keep dependencies up to date${NC}"
        echo -e "${BLUE}3. Monitor security advisories${NC}"
        echo -e "${BLUE}4. Consider using npm audit fix for vulnerabilities${NC}"
    fi
    
    echo -e "${BLUE}================================================================================================${NC}"
}

# Main execution
main() {
    local directory="${1:-.}"
    local total_files=0
    local issues_found=0
    
    print_header
    
    # Check if directory exists
    if [ ! -d "$directory" ]; then
        echo -e "${RED}❌ Directory not found: $directory${NC}"
        exit 1
    fi
    
    echo -e "${BLUE}📁 Scanning directory: $(realpath "$directory")${NC}"
    echo
    
    # Check npm cache first
    check_npm_cache
    
    # Find and check package.json files
    echo -e "${BLUE}🔍 Looking for package.json files...${NC}"
    while IFS= read -r -d '' package_file; do
        total_files=$((total_files + 1))
        if ! check_package_json "$package_file"; then
            issues_found=$((issues_found + 1))
        fi
    done < <(find "$directory" -name "package.json" -type f -print0)
    
    # Find and check lock files
    echo -e "${BLUE}🔍 Looking for lock files...${NC}"
    while IFS= read -r -d '' lock_file; do
        total_files=$((total_files + 1))
        if ! check_package_lock "$lock_file"; then
            issues_found=$((issues_found + 1))
        fi
    done < <(find "$directory" \( -name "package-lock.json" -o -name "yarn.lock" \) -type f -print0)
    
    # Count actual files for summary
    total_package_files=$(find "$directory" -name "package.json" -type f | wc -l)
    total_lock_files=$(find "$directory" \( -name "package-lock.json" -o -name "yarn.lock" \) -type f | wc -l)
    total_files=$((total_package_files + total_lock_files))
    
    generate_summary "$total_files" "$issues_found"
    
    # Exit with error code if issues found
    if [ "$issues_found" -gt 0 ]; then
        exit 1
    else
        exit 0
    fi
}

# Export functions for subshells
export -f check_package_json check_package_lock

# Run main function with all arguments
main "$@"
