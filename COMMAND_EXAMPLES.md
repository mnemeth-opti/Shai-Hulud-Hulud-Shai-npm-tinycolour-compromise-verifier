# 💻 Command Examples & Quick Reference

This document provides ready-to-use commands for all NPM security scanning scenarios.

## 🚀 Quick Start Commands

### **Basic Local Scanning**
```bash
# Scan current directory
python3 enhanced_npm_compromise_detector_phoenix.py .

# Scan with output file
python3 enhanced_npm_compromise_detector_phoenix.py . --output security-report.txt

# Scan specific directory
python3 enhanced_npm_compromise_detector_phoenix.py /path/to/project --output project-scan.txt
```

### **Organized Output**
```bash
# Create timestamped results folder
python3 enhanced_npm_compromise_detector_phoenix.py . --organize-folders --output organized-scan.txt

# Results will be in: result/YYYYMMDD/organized-scan.txt
```

## 🔗 Phoenix Integration Commands

### **Basic Phoenix Integration**
```bash
# Enable Phoenix Security API
python3 enhanced_npm_compromise_detector_phoenix.py . --enable-phoenix --output phoenix-scan.txt

# Phoenix with debug mode
python3 enhanced_npm_compromise_detector_phoenix.py . --enable-phoenix --debug --output phoenix-debug-scan.txt

# Phoenix with organized folders
python3 enhanced_npm_compromise_detector_phoenix.py . \
  --enable-phoenix \
  --organize-folders \
  --debug \
  --output phoenix-organized-scan.txt
```

### **Phoenix Configuration Setup**
```bash
# Create configuration file template
python3 enhanced_npm_compromise_detector_phoenix.py --create-config

# Use embedded credentials (for local development)
python3 enhanced_npm_compromise_detector_phoenix.py . --use-embedded-credentials --output embedded-scan.txt
```

## 🌳 Full Tree Analysis Commands

### **Local Full Tree**
```bash
# Full dependency tree analysis
python3 enhanced_npm_compromise_detector_phoenix.py . --full-tree --output full-tree-report.txt

# Full tree with Phoenix integration
python3 enhanced_npm_compromise_detector_phoenix.py . \
  --full-tree \
  --enable-phoenix \
  --organize-folders \
  --output phoenix-full-tree.txt

# Full tree with debug mode
python3 enhanced_npm_compromise_detector_phoenix.py . \
  --full-tree \
  --enable-phoenix \
  --debug \
  --organize-folders \
  --output debug-full-tree.txt
```

### **Remote Repository Full Tree**
```bash
# Create repo list and run full tree analysis
cat > repos.txt << EOF
https://github.com/facebook/react
https://github.com/vuejs/vue
EOF

python3 enhanced_npm_compromise_detector_phoenix.py \
  --repo-list repos.txt \
  --full-tree \
  --organize-folders \
  --output remote-full-tree.txt
```

## 🪶 Light Scan Commands

### **Single Repository Light Scan**
```bash
# Light scan single repository
echo "https://github.com/facebook/react" > single-repo.txt
python3 enhanced_npm_compromise_detector_phoenix.py \
  --light-scan \
  --repo-list single-repo.txt \
  --output react-light-scan.txt

# Light scan with Phoenix
python3 enhanced_npm_compromise_detector_phoenix.py \
  --light-scan \
  --repo-list single-repo.txt \
  --enable-phoenix \
  --organize-folders \
  --output react-phoenix-light.txt
```

### **Multiple Repository Light Scan**
```bash
# Create comprehensive repository list
cat > external-repos.txt << EOF
https://github.com/facebook/react
https://github.com/vuejs/vue
https://github.com/angular/angular
https://github.com/microsoft/TypeScript
https://github.com/nodejs/node
https://github.com/expressjs/express
https://github.com/lodash/lodash
EOF

# Light scan all repositories
python3 enhanced_npm_compromise_detector_phoenix.py \
  --light-scan \
  --repo-list external-repos.txt \
  --organize-folders \
  --output multi-repo-light-scan.txt

# Light scan with Phoenix integration
python3 enhanced_npm_compromise_detector_phoenix.py \
  --light-scan \
  --repo-list external-repos.txt \
  --enable-phoenix \
  --debug \
  --organize-folders \
  --output multi-repo-phoenix-light.txt
```

## 📁 Local Folder Scanning Commands

### **Single Folder**
```bash
# Scan specific folder
python3 enhanced_npm_compromise_detector_phoenix.py /path/to/project --output project-scan.txt

# Multiple specific folders
python3 enhanced_npm_compromise_detector_phoenix.py \
  --folders /path/to/project1 /path/to/project2 \
  --output multi-folder-scan.txt
```

### **Folder List File**
```bash
# Create folder list
cat > my-projects.txt << EOF
/Users/developer/projects/frontend-app
/Users/developer/projects/backend-api
/Users/developer/projects/mobile-client
/Users/developer/projects/shared-utils
EOF

# Scan all folders in list
python3 enhanced_npm_compromise_detector_phoenix.py \
  --folder-list my-projects.txt \
  --organize-folders \
  --output local-projects-scan.txt

# Folder list with Phoenix
python3 enhanced_npm_compromise_detector_phoenix.py \
  --folder-list my-projects.txt \
  --enable-phoenix \
  --organize-folders \
  --output local-projects-phoenix.txt
```

## 🔄 Repository List Commands

### **Basic Repository List**
```bash
# Create repository list
cat > company-repos.txt << EOF
https://github.com/company/frontend
https://github.com/company/backend
https://github.com/company/mobile
EOF

# Scan repository list (clones repositories)
python3 enhanced_npm_compromise_detector_phoenix.py \
  --repo-list company-repos.txt \
  --organize-folders \
  --output company-scan.txt
```

### **Repository List with Full Tree**
```bash
# Full tree analysis of repository list
python3 enhanced_npm_compromise_detector_phoenix.py \
  --repo-list company-repos.txt \
  --full-tree \
  --organize-folders \
  --output company-full-tree.txt

# With Phoenix integration
python3 enhanced_npm_compromise_detector_phoenix.py \
  --repo-list company-repos.txt \
  --full-tree \
  --enable-phoenix \
  --debug \
  --organize-folders \
  --output company-phoenix-full.txt
```

## 🎯 Specialized Scanning Commands

### **Quick Assessment Commands**
```bash
# Quick scan without detailed output
python3 enhanced_npm_compromise_detector_phoenix.py . --quiet --output quick-scan.txt

# Quick scan multiple projects
python3 enhanced_npm_compromise_detector_phoenix.py \
  --folder-list my-projects.txt \
  --quiet \
  --output quick-multi-scan.txt
```

### **Development Workflow Commands**
```bash
# Pre-commit security check
python3 enhanced_npm_compromise_detector_phoenix.py . --output pre-commit-check.txt

# Post-merge security validation
python3 enhanced_npm_compromise_detector_phoenix.py . \
  --organize-folders \
  --output post-merge-validation.txt

# Release preparation scan
python3 enhanced_npm_compromise_detector_phoenix.py . \
  --full-tree \
  --enable-phoenix \
  --organize-folders \
  --output release-security-check.txt
```

### **CI/CD Integration Commands**
```bash
# Jenkins/GitHub Actions command
python3 enhanced_npm_compromise_detector_phoenix.py . \
  --enable-phoenix \
  --organize-folders \
  --debug \
  --output "ci-security-scan-${BUILD_NUMBER:-$(date +%Y%m%d_%H%M%S)}.txt"

# Fail on critical vulnerabilities (for CI)
python3 enhanced_npm_compromise_detector_phoenix.py . \
  --enable-phoenix \
  --output ci-scan.txt || exit 1
```

## 🏢 Enterprise Commands

### **Organization-Wide Scanning**
```bash
# Create comprehensive org repository list
cat > org-repos.txt << EOF
https://github.com/org/frontend-main
https://github.com/org/frontend-admin
https://github.com/org/backend-api
https://github.com/org/backend-auth
https://github.com/org/mobile-ios
https://github.com/org/mobile-android
https://github.com/org/shared-components
https://github.com/org/deployment-tools
https://github.com/org/monitoring-stack
https://github.com/org/documentation-site
EOF

# Enterprise-grade scanning
python3 enhanced_npm_compromise_detector_phoenix.py \
  --repo-list org-repos.txt \
  --full-tree \
  --enable-phoenix \
  --debug \
  --organize-folders \
  --output "enterprise-security-audit-$(date +%Y%m%d).txt"
```

### **Supply Chain Analysis**
```bash
# Focus on supply chain security
cat > supply-chain-repos.txt << EOF
https://github.com/company/app-using-lodash
https://github.com/company/app-using-express
https://github.com/company/app-using-react
https://github.com/company/service-using-fastify
EOF

python3 enhanced_npm_compromise_detector_phoenix.py \
  --repo-list supply-chain-repos.txt \
  --full-tree \
  --enable-phoenix \
  --organize-folders \
  --output "supply-chain-analysis-$(date +%Y%m%d).txt"
```

### **Compliance Scanning**
```bash
# Compliance-focused scanning with full documentation
python3 enhanced_npm_compromise_detector_phoenix.py . \
  --full-tree \
  --enable-phoenix \
  --debug \
  --organize-folders \
  --output "compliance-scan-$(date +%Y%m%d_%H%M%S).txt"

# Multi-environment compliance
for env in dev staging prod; do
    echo "Scanning $env environment..."
    python3 enhanced_npm_compromise_detector_phoenix.py "environments/$env" \
      --full-tree \
      --enable-phoenix \
      --organize-folders \
      --output "$env-compliance-$(date +%Y%m%d).txt"
done
```

## 🔧 Troubleshooting Commands

### **Diagnostic Commands**
```bash
# Debug mode with maximum verbosity
python3 enhanced_npm_compromise_detector_phoenix.py . \
  --debug \
  --enable-phoenix \
  --output diagnostic-scan.txt

# Test Phoenix connection
python3 enhanced_npm_compromise_detector_phoenix.py --create-config
python3 enhanced_npm_compromise_detector_phoenix.py . \
  --enable-phoenix \
  --debug \
  --output phoenix-test.txt
```

### **Recovery Commands**
```bash
# Fallback to local scan if Phoenix fails
python3 enhanced_npm_compromise_detector_phoenix.py . \
  --output fallback-scan.txt || \
python3 enhanced_npm_compromise_detector_phoenix.py . \
  --enable-phoenix \
  --output phoenix-fallback.txt

# Light scan if full scan times out
timeout 1800 python3 enhanced_npm_compromise_detector_phoenix.py . \
  --full-tree \
  --output full-scan.txt || \
python3 enhanced_npm_compromise_detector_phoenix.py . \
  --light-scan \
  --output light-fallback.txt
```

## 📊 Monitoring & Automation Commands

### **Daily Monitoring**
```bash
#!/bin/bash
# daily-monitor.sh
TIMESTAMP=$(date +%Y%m%d_%H%M%S)

# Monitor production repositories
cat > production-monitor.txt << EOF
https://github.com/company/prod-frontend
https://github.com/company/prod-api
https://github.com/company/prod-mobile
EOF

python3 enhanced_npm_compromise_detector_phoenix.py \
  --light-scan \
  --repo-list production-monitor.txt \
  --enable-phoenix \
  --organize-folders \
  --output "daily-monitor-$TIMESTAMP.txt"

# Check for critical vulnerabilities
if grep -q "CRITICAL" "result/$(date +%Y%m%d)/daily-monitor-$TIMESTAMP.txt"; then
    echo "🚨 CRITICAL vulnerabilities found in production!"
    # Send alert notification here
fi
```

### **Weekly Full Audit**
```bash
#!/bin/bash
# weekly-audit.sh
WEEK=$(date +%Y%U)

python3 enhanced_npm_compromise_detector_phoenix.py \
  --repo-list org-repos.txt \
  --full-tree \
  --enable-phoenix \
  --debug \
  --organize-folders \
  --output "weekly-audit-week-$WEEK.txt"

echo "📊 Weekly audit completed for week $WEEK"
```

### **Continuous Integration**
```bash
#!/bin/bash
# ci-security-check.sh

# For pull requests - quick scan
if [ "$CI_EVENT" == "pull_request" ]; then
    python3 enhanced_npm_compromise_detector_phoenix.py . \
      --output "pr-security-check-$PR_NUMBER.txt"
fi

# For main branch - full scan with Phoenix
if [ "$CI_BRANCH" == "main" ]; then
    python3 enhanced_npm_compromise_detector_phoenix.py . \
      --full-tree \
      --enable-phoenix \
      --organize-folders \
      --output "main-branch-scan-$BUILD_NUMBER.txt"
fi

# For releases - comprehensive audit
if [[ "$CI_TAG" =~ ^v[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
    python3 enhanced_npm_compromise_detector_phoenix.py . \
      --full-tree \
      --enable-phoenix \
      --debug \
      --organize-folders \
      --output "release-audit-$CI_TAG.txt"
fi
```

## 🎨 Custom Workflow Commands

### **Development Team Workflow**
```bash
# Team daily standup security check
python3 enhanced_npm_compromise_detector_phoenix.py \
  --folder-list team-projects.txt \
  --quiet \
  --output "team-daily-$(date +%Y%m%d).txt"

# Sprint security review
python3 enhanced_npm_compromise_detector_phoenix.py \
  --folder-list sprint-projects.txt \
  --full-tree \
  --enable-phoenix \
  --organize-folders \
  --output "sprint-review-$(date +%Y%m%d).txt"
```

### **Security Team Workflow**
```bash
# Monthly security assessment
python3 enhanced_npm_compromise_detector_phoenix.py \
  --repo-list all-org-repos.txt \
  --full-tree \
  --enable-phoenix \
  --debug \
  --organize-folders \
  --output "monthly-security-$(date +%Y%m).txt"

# Incident response scanning
python3 enhanced_npm_compromise_detector_phoenix.py \
  --repo-list affected-repos.txt \
  --full-tree \
  --enable-phoenix \
  --debug \
  --organize-folders \
  --output "incident-response-$(date +%Y%m%d_%H%M%S).txt"
```

### **DevOps Team Workflow**
```bash
# Pre-deployment security gate
python3 enhanced_npm_compromise_detector_phoenix.py . \
  --full-tree \
  --enable-phoenix \
  --output "pre-deploy-gate.txt"

# Check exit code for deployment decision
if [ $? -eq 0 ]; then
    echo "✅ Security gate passed - proceeding with deployment"
else
    echo "❌ Security gate failed - blocking deployment"
    exit 1
fi

# Post-deployment verification
python3 enhanced_npm_compromise_detector_phoenix.py . \
  --enable-phoenix \
  --organize-folders \
  --output "post-deploy-verification-$(date +%Y%m%d_%H%M%S).txt"
```

## 📚 Command Combination Examples

### **Comprehensive Security Pipeline**
```bash
#!/bin/bash
# comprehensive-pipeline.sh

echo "🔒 Starting Comprehensive Security Pipeline"

# Step 1: Quick local assessment
echo "📋 Step 1: Quick Assessment"
python3 enhanced_npm_compromise_detector_phoenix.py . \
  --quiet \
  --output "step1-quick-assessment.txt"

# Step 2: Full tree analysis
echo "🌳 Step 2: Full Tree Analysis"
python3 enhanced_npm_compromise_detector_phoenix.py . \
  --full-tree \
  --organize-folders \
  --output "step2-full-tree.txt"

# Step 3: Phoenix integration
echo "🔗 Step 3: Phoenix Integration"
python3 enhanced_npm_compromise_detector_phoenix.py . \
  --full-tree \
  --enable-phoenix \
  --debug \
  --organize-folders \
  --output "step3-phoenix-integration.txt"

# Step 4: External dependency assessment
echo "🌐 Step 4: External Dependencies"
cat > external-deps.txt << EOF
https://github.com/lodash/lodash
https://github.com/expressjs/express
https://github.com/facebook/react
EOF

python3 enhanced_npm_compromise_detector_phoenix.py \
  --light-scan \
  --repo-list external-deps.txt \
  --organize-folders \
  --output "step4-external-deps.txt"

echo "✅ Comprehensive Security Pipeline Complete!"
```

### **Multi-Environment Scanning**
```bash
#!/bin/bash
# multi-env-scan.sh

environments=("dev" "staging" "prod")

for env in "${environments[@]}"; do
    echo "🔍 Scanning $env environment"
    
    python3 enhanced_npm_compromise_detector_phoenix.py "environments/$env" \
      --full-tree \
      --enable-phoenix \
      --organize-folders \
      --output "$env-security-scan-$(date +%Y%m%d).txt"
    
    echo "✅ $env environment scan complete"
done

echo "🎉 All environments scanned successfully!"
```

---

## 🎯 Quick Command Reference

### **Most Common Commands**
```bash
# Basic scan
python3 enhanced_npm_compromise_detector_phoenix.py .

# With Phoenix
python3 enhanced_npm_compromise_detector_phoenix.py . --enable-phoenix

# Full tree with Phoenix
python3 enhanced_npm_compromise_detector_phoenix.py . --full-tree --enable-phoenix

# Light scan repositories
python3 enhanced_npm_compromise_detector_phoenix.py --light-scan --repo-list repos.txt

# Organized output
python3 enhanced_npm_compromise_detector_phoenix.py . --organize-folders --output report.txt
```

### **Flag Combinations**
```bash
# Maximum features
python3 enhanced_npm_compromise_detector_phoenix.py . \
  --full-tree \
  --enable-phoenix \
  --debug \
  --organize-folders \
  --output comprehensive-scan.txt

# CI/CD optimized
python3 enhanced_npm_compromise_detector_phoenix.py . \
  --enable-phoenix \
  --organize-folders \
  --output "ci-scan-${BUILD_NUMBER}.txt"

# Development workflow
python3 enhanced_npm_compromise_detector_phoenix.py . \
  --organize-folders \
  --output "dev-scan-$(date +%Y%m%d).txt"
```

---

**💻 Copy, paste, and customize these commands for your specific security scanning needs!**

This reference provides battle-tested commands for every NPM security scanning scenario. Adapt the examples to fit your workflow and security requirements. 🛡️✨
