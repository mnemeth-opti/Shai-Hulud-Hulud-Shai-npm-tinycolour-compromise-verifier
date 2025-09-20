#!/usr/bin/env bash
# Jenkins Setup Script for NPM Security Scanner
# This script helps configure Jenkins jobs and credentials for the NPM security scanning pipeline

set -euo pipefail

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${BLUE}================================================================================================${NC}"
echo -e "${BLUE}NPM SECURITY SCANNER - JENKINS SETUP SCRIPT${NC}"
echo -e "${BLUE}================================================================================================${NC}"
echo

# --- Argument Parsing ---
SETUP_CREDENTIALS=false
PIPELINE_TYPE="declarative"
JOB_NAME="npm-security-scan"

while [[ $# -gt 0 ]]; do
    case "$1" in
        --credentials)
            SETUP_CREDENTIALS=true
            shift
            ;;
        --pipeline-type)
            PIPELINE_TYPE="$2"
            shift 2
            ;;
        --job-name)
            JOB_NAME="$2"
            shift 2
            ;;
        --help|-h)
            echo "Usage: $0 [options]"
            echo "Options:"
            echo "  --credentials         Setup credentials guidance"
            echo "  --pipeline-type TYPE  Pipeline type: declarative, scripted, or simple (default: declarative)"
            echo "  --job-name NAME       Jenkins job name (default: npm-security-scan)"
            echo "  --help               Show this help message"
            exit 0
            ;;
        *)
            echo -e "${RED}Unknown option: $1${NC}"
            exit 1
            ;;
    esac
done

# --- Step 1: Display Jenkins Requirements ---
echo -e "${BLUE}1. Jenkins Requirements${NC}"
echo -e "${BLUE}=======================${NC}"
echo -e "${GREEN}Required Jenkins Plugins:${NC}"
echo "  • Pipeline Plugin (workflow-aggregator)"
echo "  • Credentials Plugin (credentials)"
echo "  • Git Plugin (git)"
echo "  • Pipeline: Stage View Plugin (pipeline-stage-view)"
echo "  • Blue Ocean (optional, for better UI)"
echo
echo -e "${GREEN}Required System Tools on Jenkins Agent:${NC}"
echo "  • Python 3.x"
echo "  • pip3"
echo "  • Git"
echo "  • curl (for notifications)"
echo
echo -e "${YELLOW}💡 Install plugins via: Manage Jenkins → Manage Plugins → Available${NC}"
echo

# --- Step 2: Pipeline Selection ---
echo -e "${BLUE}2. Pipeline Configuration${NC}"
echo -e "${BLUE}=========================${NC}"
echo -e "${GREEN}Selected Pipeline Type: ${PIPELINE_TYPE}${NC}"

case "$PIPELINE_TYPE" in
    "declarative")
        PIPELINE_FILE="Jenkinsfile"
        echo "  • Full-featured declarative pipeline"
        echo "  • Parameter-driven configuration"
        echo "  • Built-in security gates"
        echo "  • Phoenix Security integration"
        ;;
    "scripted")
        PIPELINE_FILE="Jenkinsfile.scripted"
        echo "  • Advanced scripted pipeline"
        echo "  • Maximum flexibility and control"
        echo "  • Custom security logic"
        echo "  • Detailed reporting"
        ;;
    "simple")
        PIPELINE_FILE="Jenkinsfile.declarative"
        echo "  • Simplified declarative pipeline"
        echo "  • Essential security scanning"
        echo "  • Minimal configuration"
        echo "  • Quick setup"
        ;;
    *)
        echo -e "${RED}Invalid pipeline type: $PIPELINE_TYPE${NC}"
        exit 1
        ;;
esac

echo -e "${GREEN}Pipeline file: ide-plugins/jenkins/${PIPELINE_FILE}${NC}"
echo

# --- Step 3: Credentials Setup ---
if [ "$SETUP_CREDENTIALS" = true ]; then
    echo -e "${BLUE}3. Jenkins Credentials Setup${NC}"
    echo -e "${BLUE}============================${NC}"
    echo -e "${YELLOW}You need to configure these credentials in Jenkins:${NC}"
    echo
    echo -e "${GREEN}Go to: Manage Jenkins → Manage Credentials → System → Global credentials${NC}"
    echo
    echo -e "${YELLOW}Required Credentials:${NC}"
    echo
    
    echo -e "${GREEN}1. Phoenix Client ID${NC}"
    echo "   • Kind: Secret text"
    echo "   • ID: phoenix-client-id"
    echo "   • Secret: [Your Phoenix Client ID]"
    echo
    
    echo -e "${GREEN}2. Phoenix Client Secret${NC}"
    echo "   • Kind: Secret text"
    echo "   • ID: phoenix-client-secret"
    echo "   • Secret: [Your Phoenix Client Secret]"
    echo
    
    echo -e "${GREEN}3. Phoenix API URL${NC}"
    echo "   • Kind: Secret text"
    echo "   • ID: phoenix-api-url"
    echo "   • Secret: [Your Phoenix API URL, e.g., https://api.demo.appsecphx.io]"
    echo
    
    echo -e "${GREEN}4. GitHub Token (Optional)${NC}"
    echo "   • Kind: Secret text"
    echo "   • ID: github-token"
    echo "   • Secret: [Your GitHub Personal Access Token]"
    echo "   • Purpose: Higher rate limits for light scan mode"
    echo
    
    echo -e "${GREEN}5. Slack Webhook URL (Optional)${NC}"
    echo "   • Kind: Secret text"
    echo "   • ID: slack-webhook-url"
    echo "   • Secret: [Your Slack Webhook URL]"
    echo "   • Purpose: Build notifications"
    echo
    
    read -rp "$(echo -e "${YELLOW}Press Enter when credentials are configured...${NC}")"
    echo
fi

# --- Step 4: Job Creation Instructions ---
echo -e "${BLUE}4. Jenkins Job Creation${NC}"
echo -e "${BLUE}=======================${NC}"
echo -e "${GREEN}Creating Jenkins Pipeline Job:${NC}"
echo
echo "1. Go to Jenkins Dashboard → New Item"
echo "2. Enter job name: ${JOB_NAME}"
echo "3. Select 'Pipeline' and click OK"
echo
echo -e "${GREEN}Pipeline Configuration:${NC}"
echo "4. In 'Pipeline' section:"
echo "   • Definition: Pipeline script from SCM"
echo "   • SCM: Git"
echo "   • Repository URL: [Your repository URL]"
echo "   • Script Path: ide-plugins/jenkins/${PIPELINE_FILE}"
echo
echo -e "${GREEN}Optional Settings:${NC}"
echo "5. Build Triggers:"
echo "   • Poll SCM: H/15 * * * * (every 15 minutes)"
echo "   • GitHub hook trigger (if using GitHub)"
echo
echo "6. Pipeline Parameters (if using parameterized builds):"
echo "   • Add parameters matching your pipeline needs"
echo
echo "7. Save the job configuration"
echo

# --- Step 5: Test Run Instructions ---
echo -e "${BLUE}5. Test Run${NC}"
echo -e "${BLUE}==========${NC}"
echo -e "${GREEN}Running Your First Security Scan:${NC}"
echo
echo "1. Go to your Jenkins job: ${JOB_NAME}"
echo "2. Click 'Build Now' (or 'Build with Parameters' if configured)"
echo "3. Monitor the build progress in the console output"
echo "4. Review the archived artifacts after completion"
echo
echo -e "${YELLOW}Expected Artifacts:${NC}"
echo "  • Security scan reports (*.txt)"
echo "  • Debug files (if debug mode enabled)"
echo "  • Organized results in timestamped folders"
echo

# --- Step 6: Troubleshooting ---
echo -e "${BLUE}6. Troubleshooting${NC}"
echo -e "${BLUE}=================${NC}"
echo -e "${YELLOW}Common Issues and Solutions:${NC}"
echo
echo -e "${GREEN}Python/pip issues:${NC}"
echo "  • Ensure Python 3.x is installed on Jenkins agent"
echo "  • Add pip3 to PATH or use full path: /usr/bin/pip3"
echo
echo -e "${GREEN}Permission issues:${NC}"
echo "  • Ensure Jenkins user has execute permissions on scripts"
echo "  • Check file permissions: chmod +x *.py *.sh"
echo
echo -e "${GREEN}Phoenix API issues:${NC}"
echo "  • Verify credentials are correctly configured"
echo "  • Check Phoenix API URL format (no trailing slash)"
echo "  • Enable debug mode to see API payloads"
echo
echo -e "${GREEN}Git/SCM issues:${NC}"
echo "  • Verify repository URL and credentials"
echo "  • Ensure Jenkins has access to the repository"
echo "  • Check branch configuration"
echo

# --- Step 7: Advanced Configuration ---
echo -e "${BLUE}7. Advanced Configuration${NC}"
echo -e "${BLUE}========================${NC}"
echo -e "${GREEN}Pipeline Customization:${NC}"
echo
echo -e "${YELLOW}Environment Variables:${NC}"
echo "  • Set in Jenkins job configuration → Environment"
echo "  • SLACK_WEBHOOK_URL for notifications"
echo "  • CRITICAL_THRESHOLD for security gate"
echo
echo -e "${YELLOW}Build Parameters:${NC}"
echo "  • SCAN_TYPE: quick, enhanced, light-scan, phoenix-integration"
echo "  • TARGET_PATH: Directory or file to scan"
echo "  • ENABLE_PHOENIX: Enable Phoenix Security integration"
echo "  • DEBUG_MODE: Enable debug mode for troubleshooting"
echo
echo -e "${YELLOW}Post-build Actions:${NC}"
echo "  • Email notifications"
echo "  • Slack/Teams notifications"
echo "  • Artifact publishing"
echo "  • Downstream job triggering"
echo

# --- Step 8: Security Best Practices ---
echo -e "${BLUE}8. Security Best Practices${NC}"
echo -e "${BLUE}==========================${NC}"
echo -e "${GREEN}Jenkins Security:${NC}"
echo "  • Use Jenkins credentials store (never hardcode secrets)"
echo "  • Limit job permissions to necessary users/groups"
echo "  • Enable audit logging"
echo "  • Regularly update Jenkins and plugins"
echo
echo -e "${GREEN}Pipeline Security:${NC}"
echo "  • Validate input parameters"
echo "  • Sanitize file paths and commands"
echo "  • Use secure credential binding"
echo "  • Archive sensitive data securely"
echo

# --- Final Instructions ---
echo -e "${BLUE}================================================================================================${NC}"
echo -e "${BLUE}SETUP COMPLETE${NC}"
echo -e "${BLUE}================================================================================================${NC}"
echo
echo -e "${GREEN}🎉 Jenkins NPM Security Scanner setup is ready!${NC}"
echo
echo -e "${YELLOW}Next Steps:${NC}"
echo "1. Configure Jenkins credentials (if not done already)"
echo "2. Create the pipeline job with the specified configuration"
echo "3. Run a test build to verify everything works"
echo "4. Customize pipeline parameters as needed"
echo "5. Set up notifications and post-build actions"
echo
echo -e "${GREEN}Pipeline Files Available:${NC}"
echo "  • ide-plugins/jenkins/Jenkinsfile (full-featured)"
echo "  • ide-plugins/jenkins/Jenkinsfile.declarative (simplified)"
echo "  • ide-plugins/jenkins/Jenkinsfile.scripted (advanced)"
echo
echo -e "${GREEN}Documentation:${NC}"
echo "  • JENKINS_SETUP_GUIDE.md - Detailed setup instructions"
echo "  • JENKINS_EXAMPLES.md - Example configurations and use cases"
echo
echo -e "${BLUE}Happy scanning! 🛡️${NC}"
echo -e "${BLUE}================================================================================================${NC}"
