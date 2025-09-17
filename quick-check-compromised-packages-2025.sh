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

# Compromised packages with specific versions - Updated with extended list
compromised_packages_json='[
  {"name":"@ahmedhfarag/ngx-perfect-scrollbar","versions":["20.0.20"]},
  {"name":"@ahmedhfarag/ngx-virtual-scroller","versions":["4.0.4"]},
  {"name":"@art-ws/common","versions":["2.0.28"]},
  {"name":"@art-ws/config-eslint","versions":["2.0.4","2.0.5"]},
  {"name":"@art-ws/config-ts","versions":["2.0.7","2.0.8"]},
  {"name":"@art-ws/db-context","versions":["2.0.24"]},
  {"name":"@art-ws/di-node","versions":["2.0.13"]},
  {"name":"@art-ws/di","versions":["2.0.28","2.0.32"]},
  {"name":"@art-ws/eslint","versions":["1.0.5","1.0.6"]},
  {"name":"@art-ws/fastify-http-server","versions":["2.0.24","2.0.27"]},
  {"name":"@art-ws/http-server","versions":["2.0.21","2.0.25"]},
  {"name":"@art-ws/openapi","versions":["0.1.12","0.1.9"]},
  {"name":"@art-ws/package-base","versions":["1.0.5","1.0.6"]},
  {"name":"@art-ws/prettier","versions":["1.0.5","1.0.6"]},
  {"name":"@art-ws/slf","versions":["2.0.15","2.0.22"]},
  {"name":"@art-ws/ssl-info","versions":["1.0.10","1.0.9"]},
  {"name":"@art-ws/web-app","versions":["1.0.3","1.0.4"]},
  {"name":"@crowdstrike/commitlint","versions":["8.1.1","8.1.2"]},
  {"name":"@crowdstrike/falcon-shoelace","versions":["0.4.1","0.4.2"]},
  {"name":"@crowdstrike/foundry-js","versions":["0.19.1","0.19.2"]},
  {"name":"@crowdstrike/glide-core","versions":["0.34.2","0.34.3"]},
  {"name":"@crowdstrike/logscale-dashboard","versions":["1.205.1","1.205.2"]},
  {"name":"@crowdstrike/logscale-file-editor","versions":["1.205.1","1.205.2"]},
  {"name":"@crowdstrike/logscale-parser-edit","versions":["1.205.1","1.205.2"]},
  {"name":"@crowdstrike/logscale-search","versions":["1.205.1","1.205.2"]},
  {"name":"@crowdstrike/tailwind-toucan-base","versions":["5.0.1","5.0.2"]},
  {"name":"@ctrl/deluge","versions":["7.2.1","7.2.2"]},
  {"name":"@ctrl/golang-template","versions":["1.4.2","1.4.3"]},
  {"name":"@ctrl/magnet-link","versions":["4.0.3","4.0.4"]},
  {"name":"@ctrl/ngx-codemirror","versions":["7.0.1","7.0.2"]},
  {"name":"@ctrl/ngx-csv","versions":["6.0.1","6.0.2"]},
  {"name":"@ctrl/ngx-emoji-mart","versions":["9.2.1","9.2.2"]},
  {"name":"@ctrl/ngx-rightclick","versions":["4.0.1","4.0.2"]},
  {"name":"@ctrl/qbittorrent","versions":["9.7.1","9.7.2"]},
  {"name":"@ctrl/react-adsense","versions":["2.0.1","2.0.2"]},
  {"name":"@ctrl/shared-torrent","versions":["6.3.1","6.3.2"]},
  {"name":"@ctrl/tinycolor","versions":["4.1.1","4.1.2"]},
  {"name":"@ctrl/torrent-file","versions":["4.1.1","4.1.2"]},
  {"name":"@ctrl/transmission","versions":["7.3.1"]},
  {"name":"@ctrl/ts-base32","versions":["4.0.1","4.0.2"]},
  {"name":"@hestjs/core","versions":["0.2.1"]},
  {"name":"@hestjs/cqrs","versions":["0.1.6"]},
  {"name":"@hestjs/demo","versions":["0.1.2"]},
  {"name":"@hestjs/eslint-config","versions":["0.1.2"]},
  {"name":"@hestjs/logger","versions":["0.1.6"]},
  {"name":"@hestjs/scalar","versions":["0.1.7"]},
  {"name":"@hestjs/validation","versions":["0.1.6"]},
  {"name":"@nativescript-community/arraybuffers","versions":["1.1.6","1.1.7","1.1.8"]},
  {"name":"@nativescript-community/gesturehandler","versions":["2.0.35"]},
  {"name":"@nativescript-community/perms","versions":["3.0.5","3.0.6","3.0.7","3.0.8"]},
  {"name":"@nativescript-community/sentry","versions":["4.6.43"]},
  {"name":"@nativescript-community/sqlite","versions":["3.5.2","3.5.3","3.5.4","3.5.5"]},
  {"name":"@nativescript-community/text","versions":["1.6.9","1.6.10","1.6.11","1.6.12","1.6.13"]},
  {"name":"@nativescript-community/typeorm","versions":["0.2.30","0.2.31","0.2.32","0.2.33"]},
  {"name":"@nativescript-community/ui-collectionview","versions":["6.0.6"]},
  {"name":"@nativescript-community/ui-document-picker","versions":["1.1.27","1.1.28"]},
  {"name":"@nativescript-community/ui-drawer","versions":["0.1.30"]},
  {"name":"@nativescript-community/ui-image","versions":["4.5.6"]},
  {"name":"@nativescript-community/ui-label","versions":["1.3.35","1.3.36","1.3.37"]},
  {"name":"@nativescript-community/ui-material-bottom-navigation","versions":["7.2.72","7.2.73","7.2.74","7.2.75"]},
  {"name":"@nativescript-community/ui-material-bottomsheet","versions":["7.2.72"]},
  {"name":"@nativescript-community/ui-material-core","versions":["7.2.72","7.2.73","7.2.74","7.2.75","7.2.76"]},
  {"name":"@nativescript-community/ui-material-core-tabs","versions":["7.2.72","7.2.73","7.2.74","7.2.75","7.2.76"]},
  {"name":"@nativescript-community/ui-material-ripple","versions":["7.2.72","7.2.73","7.2.74","7.2.75"]},
  {"name":"@nativescript-community/ui-material-tabs","versions":["7.2.72","7.2.73","7.2.74","7.2.75"]},
  {"name":"@nativescript-community/ui-pager","versions":["14.1.36","14.1.37","14.1.38"]},
  {"name":"@nativescript-community/ui-pulltorefresh","versions":["2.5.4","2.5.5","2.5.6","2.5.7"]},
  {"name":"@nexe/config-manager","versions":["0.1.1"]},
  {"name":"@nexe/eslint-config","versions":["0.1.1"]},
  {"name":"@nexe/logger","versions":["0.1.3"]},
  {"name":"@nstudio/angular","versions":["20.0.4","20.0.5","20.0.6"]},
  {"name":"@nstudio/focus","versions":["20.0.4","20.0.5","20.0.6"]},
  {"name":"@nstudio/nativescript-checkbox","versions":["2.0.6","2.0.7","2.0.8","2.0.9"]},
  {"name":"@nstudio/nativescript-loading-indicator","versions":["5.0.1","5.0.2","5.0.3","5.0.4"]},
  {"name":"@nstudio/ui-collectionview","versions":["5.1.11","5.1.12","5.1.13","5.1.14"]},
  {"name":"@nstudio/web-angular","versions":["20.0.4"]},
  {"name":"@nstudio/web","versions":["20.0.4"]},
  {"name":"@nstudio/xplat-utils","versions":["20.0.5","20.0.6","20.0.7"]},
  {"name":"@nstudio/xplat","versions":["20.0.5","20.0.6","20.0.7"]},
  {"name":"@operato/board","versions":["9.0.36","9.0.37","9.0.38","9.0.39","9.0.40","9.0.41","9.0.42","9.0.43","9.0.44","9.0.45","9.0.46"]},
  {"name":"@operato/data-grist","versions":["9.0.29","9.0.35","9.0.36","9.0.37"]},
  {"name":"@operato/graphql","versions":["9.0.22","9.0.35","9.0.36","9.0.37","9.0.38","9.0.39","9.0.40","9.0.41","9.0.42","9.0.43","9.0.44","9.0.45","9.0.46"]},
  {"name":"@operato/headroom","versions":["9.0.2","9.0.35","9.0.36","9.0.37"]},
  {"name":"@operato/help","versions":["9.0.35","9.0.36","9.0.37","9.0.38","9.0.39","9.0.40","9.0.41","9.0.42","9.0.43","9.0.44","9.0.45","9.0.46"]},
  {"name":"@operato/i18n","versions":["9.0.35","9.0.36","9.0.37"]},
  {"name":"@operato/input","versions":["9.0.27","9.0.35","9.0.36","9.0.37","9.0.38","9.0.39","9.0.40","9.0.41","9.0.42","9.0.43","9.0.44","9.0.45","9.0.46","9.0.47","9.0.48"]},
  {"name":"@operato/layout","versions":["9.0.35","9.0.36","9.0.37"]},
  {"name":"@operato/popup","versions":["9.0.22","9.0.35","9.0.36","9.0.37","9.0.38","9.0.39","9.0.40","9.0.41","9.0.42","9.0.43","9.0.44","9.0.45","9.0.46","9.0.49"]},
  {"name":"@operato/pull-to-refresh","versions":["9.0.36","9.0.37","9.0.38","9.0.39","9.0.40","9.0.41","9.0.42"]},
  {"name":"@operato/shell","versions":["9.0.22","9.0.35","9.0.36","9.0.37","9.0.38","9.0.39"]},
  {"name":"@operato/styles","versions":["9.0.2","9.0.35","9.0.36","9.0.37"]},
  {"name":"@operato/utils","versions":["9.0.22","9.0.35","9.0.36","9.0.37","9.0.38","9.0.39","9.0.40","9.0.41","9.0.42","9.0.43","9.0.44","9.0.45","9.0.46","9.0.49"]},
  {"name":"@teselagen/bio-parsers","versions":["0.4.30"]},
  {"name":"@teselagen/bounce-loader","versions":["0.3.16","0.3.17"]},
  {"name":"@teselagen/file-utils","versions":["0.3.22"]},
  {"name":"@teselagen/liquibase-tools","versions":["0.4.1"]},
  {"name":"@teselagen/ove","versions":["0.7.40"]},
  {"name":"@teselagen/range-utils","versions":["0.3.14","0.3.15"]},
  {"name":"@teselagen/react-list","versions":["0.8.19","0.8.20"]},
  {"name":"@teselagen/react-table","versions":["6.10.19","6.10.20","6.10.22"]},
  {"name":"@teselagen/sequence-utils","versions":["0.3.34"]},
  {"name":"@teselagen/ui","versions":["0.9.10"]},
  {"name":"@thangved/callback-window","versions":["1.1.4"]},
  {"name":"@things-factory/attachment-base","versions":["9.0.43","9.0.44","9.0.45","9.0.46","9.0.47","9.0.48","9.0.49","9.0.50"]},
  {"name":"@things-factory/auth-base","versions":["9.0.43","9.0.44","9.0.45"]},
  {"name":"@things-factory/email-base","versions":["9.0.42","9.0.43","9.0.44","9.0.45","9.0.46","9.0.47","9.0.48","9.0.49","9.0.50","9.0.51","9.0.52","9.0.53","9.0.54"]},
  {"name":"@things-factory/env","versions":["9.0.42","9.0.43","9.0.44","9.0.45"]},
  {"name":"@things-factory/integration-base","versions":["9.0.43","9.0.44","9.0.45"]},
  {"name":"@things-factory/integration-marketplace","versions":["9.0.43","9.0.44","9.0.45"]},
  {"name":"@things-factory/shell","versions":["9.0.43","9.0.44","9.0.45"]},
  {"name":"@tnf-dev/api","versions":["1.0.8"]},
  {"name":"@tnf-dev/core","versions":["1.0.8"]},
  {"name":"@tnf-dev/js","versions":["1.0.8"]},
  {"name":"@tnf-dev/mui","versions":["1.0.8"]},
  {"name":"@tnf-dev/react","versions":["1.0.8"]},
  {"name":"@ui-ux-gang/devextreme-angular-rpk","versions":["24.1.7"]},
  {"name":"@yoobic/design-system","versions":["6.5.17"]},
  {"name":"@yoobic/jpeg-camera-es6","versions":["1.0.13"]},
  {"name":"@yoobic/yobi","versions":["8.7.53"]},
  {"name":"airchief","versions":["0.3.1"]},
  {"name":"airpilot","versions":["0.8.8"]},
  {"name":"angulartics2","versions":["14.1.1","14.1.2"]},
  {"name":"browser-webdriver-downloader","versions":["3.0.8"]},
  {"name":"capacitor-notificationhandler","versions":["0.0.2","0.0.3"]},
  {"name":"capacitor-plugin-healthapp","versions":["0.0.2","0.0.3"]},
  {"name":"capacitor-plugin-ihealth","versions":["1.1.8","1.1.9"]},
  {"name":"capacitor-plugin-vonage","versions":["1.0.2","1.0.3"]},
  {"name":"capacitorandroidpermissions","versions":["0.0.4","0.0.5"]},
  {"name":"config-cordova","versions":["0.8.5"]},
  {"name":"cordova-plugin-voxeet2","versions":["1.0.24"]},
  {"name":"cordova-voxeet","versions":["1.0.32"]},
  {"name":"create-hest-app","versions":["0.1.9"]},
  {"name":"db-evo","versions":["1.1.4","1.1.5"]},
  {"name":"devextreme-angular-rpk","versions":["21.2.8"]},
  {"name":"ember-browser-services","versions":["5.0.2","5.0.3"]},
  {"name":"ember-headless-form-yup","versions":["1.0.1"]},
  {"name":"ember-headless-form","versions":["1.1.2","1.1.3"]},
  {"name":"ember-headless-table","versions":["2.1.5","2.1.6"]},
  {"name":"ember-url-hash-polyfill","versions":["1.0.12","1.0.13"]},
  {"name":"ember-velcro","versions":["2.2.1","2.2.2"]},
  {"name":"encounter-playground","versions":["0.0.2","0.0.3","0.0.4","0.0.5"]},
  {"name":"eslint-config-crowdstrike-node","versions":["4.0.3","4.0.4"]},
  {"name":"eslint-config-crowdstrike","versions":["11.0.2","11.0.3"]},
  {"name":"eslint-config-teselagen","versions":["6.1.7","6.1.8"]},
  {"name":"globalize-rpk","versions":["1.7.4"]},
  {"name":"graphql-sequelize-teselagen","versions":["5.3.8","5.3.9"]},
  {"name":"html-to-base64-image","versions":["1.0.2"]},
  {"name":"json-rules-engine-simplified","versions":["0.2.1","0.2.4"]},
  {"name":"jumpgate","versions":["0.0.2"]},
  {"name":"koa2-swagger-ui","versions":["5.11.1","5.11.2"]},
  {"name":"mcfly-semantic-release","versions":["1.3.1"]},
  {"name":"mcp-knowledge-base","versions":["0.0.2"]},
  {"name":"mcp-knowledge-graph","versions":["1.2.1"]},
  {"name":"mobioffice-cli","versions":["1.0.3"]},
  {"name":"monorepo-next","versions":["13.0.1","13.0.2"]},
  {"name":"mstate-angular","versions":["0.4.4"]},
  {"name":"mstate-cli","versions":["0.4.7"]},
  {"name":"mstate-dev-react","versions":["1.1.1"]},
  {"name":"mstate-react","versions":["1.6.5"]},
  {"name":"ng2-file-upload","versions":["7.0.2","7.0.3","8.0.1","8.0.2","8.0.3","9.0.1"]},
  {"name":"ngx-bootstrap","versions":["18.1.4","19.0.3","19.0.4","20.0.3","20.0.4","20.0.5"]},
  {"name":"ngx-color","versions":["10.0.1","10.0.2"]},
  {"name":"ngx-toastr","versions":["19.0.1","19.0.2"]},
  {"name":"ngx-trend","versions":["8.0.1"]},
  {"name":"ngx-ws","versions":["1.1.5","1.1.6"]},
  {"name":"oradm-to-gql","versions":["35.0.14","35.0.15"]},
  {"name":"oradm-to-sqlz","versions":["1.1.2"]},
  {"name":"ove-auto-annotate","versions":["0.0.9","0.0.10"]},
  {"name":"pm2-gelf-json","versions":["1.0.4","1.0.5"]},
  {"name":"printjs-rpk","versions":["1.6.1"]},
  {"name":"react-complaint-image","versions":["0.0.32","0.0.35"]},
  {"name":"react-jsonschema-form-conditionals","versions":["0.3.18","0.3.21"]},
  {"name":"react-jsonschema-form-extras","versions":["1.0.4"]},
  {"name":"react-jsonschema-rxnt-extras","versions":["0.4.9"]},
  {"name":"remark-preset-lint-crowdstrike","versions":["4.0.1","4.0.2"]},
  {"name":"rxnt-authentication","versions":["0.0.3","0.0.4","0.0.5","0.0.6"]},
  {"name":"rxnt-healthchecks-nestjs","versions":["1.0.2","1.0.3","1.0.4","1.0.5"]},
  {"name":"rxnt-kue","versions":["1.0.4","1.0.5","1.0.6","1.0.7"]},
  {"name":"swc-plugin-component-annotate","versions":["1.9.1","1.9.2"]},
  {"name":"tbssnch","versions":["1.0.2"]},
  {"name":"teselagen-interval-tree","versions":["1.1.2"]},
  {"name":"tg-client-query-builder","versions":["2.14.4","2.14.5"]},
  {"name":"tg-redbird","versions":["1.3.1","1.3.2"]},
  {"name":"tg-seq-gen","versions":["1.0.9","1.0.10"]},
  {"name":"thangved-react-grid","versions":["1.0.3"]},
  {"name":"ts-gaussian","versions":["3.0.5","3.0.6"]},
  {"name":"ts-imports","versions":["1.0.1","1.0.2"]},
  {"name":"tvi-cli","versions":["0.1.5"]},
  {"name":"ve-bamreader","versions":["0.2.6","0.2.7"]},
  {"name":"ve-editor","versions":["1.0.1","1.0.2"]},
  {"name":"verror-extra","versions":["6.0.1"]},
  {"name":"voip-callkit","versions":["1.0.2","1.0.3"]},
  {"name":"wdio-web-reporter","versions":["0.1.3"]},
  {"name":"yargs-help-output","versions":["5.0.3"]},
  {"name":"yoo-styles","versions":["6.0.326"]}
]'

# Potentially compromised packages (any version) - Now all packages have specific compromised versions
potentially_compromised='[]'

# Check if jq is available
if ! command -v jq >/dev/null 2>&1; then
  echo -e "${RED}Error: 'jq' is required but not installed.${NC}"
  echo "Please install jq: sudo apt-get install jq (Ubuntu/Debian) or brew install jq (macOS)"
  exit 1
fi

# Function to print header
print_header() {
    echo -e "${BLUE}================================================================================================${NC}"
    echo -e "${BLUE}NPM PACKAGE COMPROMISE CHECKER - 2025 EXTENDED EDITION - UPDATED${NC}"
    echo -e "${BLUE}================================================================================================${NC}"
    echo -e "${BLUE}Scanning for 200+ compromised packages with specific versions including major organizations${NC}"
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
        echo -e "${YELLOW}📋 For detailed analysis with safe version recommendations:${NC}"
        echo -e "${YELLOW}python3 npm_package_compromise_detector_2025.py . --full-tree --output security-report.txt${NC}"
    else
        echo -e "${GREEN}Status: ✅ NO COMPROMISED PACKAGES DETECTED${NC}"
        echo -e "${GREEN}Your project appears to be clean of known compromised packages.${NC}"
        echo
        echo -e "${BLUE}💡 Recommendations:${NC}"
        echo -e "${BLUE}1. Run regular security audits: npm audit${NC}"
        echo -e "${BLUE}2. Keep dependencies up to date${NC}"
        echo -e "${BLUE}3. Monitor security advisories for the 195 monitored packages${NC}"
        echo -e "${BLUE}4. Consider using npm audit fix for vulnerabilities${NC}"
        echo -e "${BLUE}5. Run comprehensive scans periodically with --full-tree${NC}"
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
