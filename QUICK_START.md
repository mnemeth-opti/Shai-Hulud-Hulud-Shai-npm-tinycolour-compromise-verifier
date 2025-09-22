# 🚀 Quick Start Guide - NPM Package Compromise Detection (195 Packages)

## 📋 Table of Contents
- [Quick Usage Guide](#-quick-usage-guide)
- [Local Usage](#-local-usage)
- [GitHub Actions Integration](#-github-actions-integration)
- [CI/CD Pipeline Examples](#-cicd-pipeline-examples)
- [Troubleshooting](#-troubleshooting)

## ⚡ Quick Usage Guide

### **🎯 Comprehensive Coverage (195 Packages)**

Our scanner monitors **195 confirmed compromised packages** across **11+ major organizations**:

- **@ctrl** - 15+ packages (TypeScript utilities, torrent tools)
- **@nativescript-community** - 25+ packages (NativeScript components) 
- **@art-ws** - 15+ packages (Web services, configuration)
- **@crowdstrike** - 10+ packages (Security tooling)
- **@operato** - 15+ packages (UI components)
- **@teselagen** - 10+ packages (Bioinformatics tools)
- **@things-factory** - 8+ packages (Factory automation)
- **@nstudio** - 8+ packages (Development tools)
- **Plus 100+ individual packages** from various maintainers

### **🎯 Immediate Usage (30 seconds)**

```bash
# 1. Make scripts executable
chmod +x *.sh

# 2. Quick check current directory
./local-security-check.sh .

# 3. Check specific project
./local-security-check.sh /path/to/your/project

# 4. Comprehensive analysis with detailed report (all libraries shown)
python3 enhanced_npm_compromise_detector_phoenix.py . --full-tree --detail-log --output security-report.txt

# 5. Enterprise batch scan with Phoenix integration and cleanup
python3 enhanced_npm_compromise_detector_phoenix.py --repo-list repos.txt --light-scan --organize-folders --delete-local-files --enable-phoenix
```

### **🔍 What Each Tool Does (195 Package Coverage)**

| Tool | Purpose | Speed | Use Case | Coverage |
|------|---------|-------|----------|----------|
| `./local-security-check.sh` | **Quick scanner with nice output** | ⚡ Fast | Daily checks, CI/CD | 195 packages + organizations |
| `./quick-check-compromised-packages-2025.sh` | **Core detection engine** | ⚡ Fast | Direct usage, automation | 195 packages with specific versions |
| `enhanced_npm_compromise_detector_phoenix.py --detail-log` | **📋 Complete library reporting** | ⚡ Fast | **Audit-ready detailed scans** | 195 packages + all libraries shown |
| `enhanced_npm_compromise_detector_phoenix.py --delete-local-files` | **🗑️ Auto-cleanup scanner** | ⚡ Fast | **CI/CD clean environments** | 195 packages + automatic cleanup |
| `enhanced_npm_compromise_detector_phoenix.py --light-scan` | **🪶 Light Phoenix scanner** | ⚡⚡ Very Fast | **Enterprise batch scanning** | 195 packages + zero storage |
| `python3 npm_package_compromise_detector_2025.py` | **Comprehensive analysis** | 🐌 Thorough | Security audits, reports | 195 packages + source code analysis |

### **📊 Understanding Results**

#### ✅ **Clean Project (Exit Code 0)**
```bash
$ ./local-security-check.sh clean_project
✅ SCAN COMPLETE: No compromised packages detected
   Your project appears to be clean of all 195 monitored compromised packages.
   Scanned organizations: @ctrl, @nativescript-community, @art-ws, @crowdstrike, and 7+ others
```

#### 🚨 **Compromised Project (Exit Code 1)**
```bash
$ ./local-security-check.sh compromised_project
🚨 CRITICAL: Compromised packages detected from 195 package database!

IMMEDIATE ACTIONS REQUIRED:
1. Stop all running applications immediately
2. Clear npm cache: npm cache clean --force
3. Remove node_modules: rm -rf node_modules
4. Remove lock files: rm package-lock.json yarn.lock
5. Update to safe versions and reinstall

📋 For detailed analysis with safe version recommendations:
python3 npm_package_compromise_detector_2025.py . --full-tree --output security-report.txt
```

### **🚨 Emergency Response (If Compromised Packages Found)**

```bash
# 1. Stop applications immediately
pkill -f node

# 2. Clean environment
npm cache clean --force
rm -rf node_modules
rm -f package-lock.json yarn.lock

# 3. Get detailed analysis
python3 npm_package_compromise_detector_2025.py . --full-tree --output emergency-report.txt

# 4. Review emergency-report.txt for safe versions
# 5. Update package.json with safe versions from report
# 6. Reinstall dependencies
npm install

# 7. Verify fix
./local-security-check.sh .
```

### **🔄 Common Workflows**

#### **Daily Development Check**
```bash
# Quick morning security check
./local-security-check.sh .
```

#### **Pre-deployment Security Audit**
```bash
# Comprehensive scan before going live
python3 npm_package_compromise_detector_2025.py . --full-tree --output pre-deploy-security.txt
```

#### **Multiple Projects Scan**
```bash
# Scan all your projects
for project in ~/projects/*/; do
    echo "Scanning $project"
    ./local-security-check.sh "$project"
done
```

#### **CI/CD Integration**
```bash
# In your build script
./local-security-check.sh . || exit 1  # Fail build if compromised
```

## 🆕 Enhanced Features (2025)

### **📋 Detail Log Mode - Complete Library Visibility**

Show ALL libraries without truncation for complete audit trails:

```bash
# Show every single library (no "... and 50 more" truncation)
python3 enhanced_npm_compromise_detector_phoenix.py --folders my_projects --detail-log --output complete-audit.txt

# Enterprise repository scan with complete library details
python3 enhanced_npm_compromise_detector_phoenix.py --repo-list enterprise_repos.txt --detail-log --enable-phoenix

# Before deployment - see every library scanned
python3 enhanced_npm_compromise_detector_phoenix.py . --full-tree --detail-log --output pre-deploy-complete.txt
```

**Perfect for:**
- ✅ **Security Audits**: Complete visibility for compliance
- ✅ **Enterprise Reporting**: No truncated library lists
- ✅ **Vulnerability Management**: See every single dependency
- ✅ **Repository Context**: Each library shows source repo and build file

### **🗑️ Auto-Cleanup Mode - Clean CI/CD Environments**

Automatically delete cloned repositories after scanning:

```bash
# CI/CD pipeline scan with automatic cleanup
python3 enhanced_npm_compromise_detector_phoenix.py --repo-list repos.txt --organize-folders --delete-local-files

# Enterprise batch scan - no leftover files
python3 enhanced_npm_compromise_detector_phoenix.py \
  --repo-list organization_repos.txt \
  --light-scan \
  --organize-folders \
  --delete-local-files \
  --enable-phoenix

# Local development with cleanup
python3 enhanced_npm_compromise_detector_phoenix.py --repo-list test_repos.txt --delete-local-files --output scan-results.txt
```

**Perfect for:**
- ✅ **CI/CD Pipelines**: No disk space accumulation
- ✅ **Automated Scans**: Clean environments after each run
- ✅ **Enterprise Scale**: Scan hundreds of repos without storage issues
- ✅ **Development Workflows**: Keep local machine clean

### **🔄 Ultimate Combined Usage**

Use all enhanced features together:

```bash
# Complete enterprise security audit with all features
python3 enhanced_npm_compromise_detector_phoenix.py \
  --repo-list enterprise_repos.txt \
  --light-scan \
  --organize-folders \
  --delete-local-files \
  --detail-log \
  --enable-phoenix \
  --debug \
  --output "enterprise-security-audit-$(date +%Y%m%d).txt"
```

**This command provides:**
- 🪶 **Light Scan**: 10x faster scanning (NPM files only)
- 🗂️ **Organized Folders**: Clean folder structure by date
- 🗑️ **Auto Cleanup**: No leftover cloned repositories
- 📋 **Complete Details**: Every library shown with repo context
- 🔗 **Phoenix Integration**: Automated vulnerability management
- 🐛 **Debug Mode**: API payloads saved for troubleshooting
- 📊 **Comprehensive Report**: Complete audit trail

## 🖥️ Local Usage

### **Prerequisites Check**
```bash
# Check if you have required tools
which jq && echo "✅ jq OK" || echo "❌ jq missing"
which python3 && echo "✅ python3 OK" || echo "❌ python3 missing"

# Install missing tools
# Ubuntu/Debian:
sudo apt-get update && sudo apt-get install -y jq python3

# macOS:
brew install jq python3

# Windows (WSL):
sudo apt-get update && sudo apt-get install -y jq python3
```

### **1. Setup (One-time)**
```bash
# If you cloned/downloaded the repository
cd your-security-tools-directory

# Make scripts executable
chmod +x *.sh

# Verify tools are ready
ls -la *.sh *.py
```

### **2. Quick Security Check (Recommended)**
```bash
# Best option: Local runner with nice output
./local-security-check.sh .                    # Current directory
./local-security-check.sh /path/to/project     # Specific project

# Alternative: Direct core scanner
./quick-check-compromised-packages-2025.sh .   # Current directory
./quick-check-compromised-packages-2025.sh /path/to/project  # Specific project
```

### **3. Comprehensive Security Analysis**
```bash
# Basic comprehensive scan
python3 npm_package_compromise_detector_2025.py .

# Full dependency tree analysis (RECOMMENDED for security audits)
python3 npm_package_compromise_detector_2025.py . --full-tree

# Save detailed report with timestamp
python3 npm_package_compromise_detector_2025.py . --full-tree \
  --output "security-report-$(date +%Y%m%d-%H%M).txt"

# Quiet mode (only show critical/high severity findings)
python3 npm_package_compromise_detector_2025.py . --quiet

# Custom configuration file
python3 npm_package_compromise_detector_2025.py . --config custom-packages.json
```

### **4. Batch Scanning Multiple Projects**
```bash
# Scan multiple specific projects
for project in project1 project2 project3; do
    echo "🔍 Scanning $project..."
    ./local-security-check.sh "$project"
    echo "---"
done

# Scan all Node.js projects in a directory
find ~/projects -name "package.json" -not -path "*/node_modules/*" | while read package_file; do
    project_dir=$(dirname "$package_file")
    echo "🔍 Scanning $project_dir"
    ./local-security-check.sh "$project_dir"
done

# Scan with detailed reports for each project
for project in ~/projects/*/; do
    if [ -f "$project/package.json" ]; then
        project_name=$(basename "$project")
        echo "📊 Generating report for $project_name"
        python3 npm_package_compromise_detector_2025.py "$project" \
          --output "report-$project_name-$(date +%Y%m%d).txt"
    fi
done
```

### **5. Development Integration**

#### **Pre-commit Hook**
```bash
# Create pre-commit hook
cat > .git/hooks/pre-commit << 'EOF'
#!/bin/bash
echo "🔍 Checking for compromised NPM packages..."
if ! ./path/to/local-security-check.sh .; then
    echo "❌ Commit blocked: Compromised packages detected!"
    exit 1
fi
echo "✅ Security check passed"
EOF

chmod +x .git/hooks/pre-commit
```

#### **Package.json Scripts**
```json
{
  "scripts": {
    "security:check": "./security-tools/local-security-check.sh .",
    "security:audit": "python3 ./security-tools/npm_package_compromise_detector_2025.py . --full-tree",
    "security:report": "python3 ./security-tools/npm_package_compromise_detector_2025.py . --full-tree --output security-report.txt",
    "presecurity": "echo '🔍 Running security scan...'",
    "postsecurity": "echo '✅ Security scan complete'",
    "preinstall": "npm run security:check",
    "postinstall": "npm run security:check"
  }
}
```

#### **Makefile Integration**
```makefile
.PHONY: security security-full security-report

security:
	@echo "🔍 Running quick security check..."
	@./security-tools/local-security-check.sh .

security-full:
	@echo "🔍 Running comprehensive security analysis..."
	@python3 ./security-tools/npm_package_compromise_detector_2025.py . --full-tree

security-report:
	@echo "📊 Generating security report..."
	@python3 ./security-tools/npm_package_compromise_detector_2025.py . --full-tree --output security-report-$(shell date +%Y%m%d).txt
	@echo "Report saved to security-report-$(shell date +%Y%m%d).txt"

install: security
	npm install

build: security
	npm run build
```

## ⚡ GitHub Actions Integration

### **Basic Workflow (Copy to `.github/workflows/security-scan.yml`)**

#### **Option 1: Using Local Tools (Recommended)**
```yaml
name: NPM Package Security Scan - 195 Packages

on:
  push:
    branches: [ main, develop ]
  pull_request:
    branches: [ main ]
  schedule:
    # Run daily at 2 AM UTC
    - cron: '0 2 * * *'
  # Allow manual trigger
  workflow_dispatch:

jobs:
  security-scan:
    name: Scan for 195 Compromised NPM Packages (11+ Organizations)
    runs-on: ubuntu-latest
    
    steps:
    - name: Checkout Repository
      uses: actions/checkout@v4
    
    - name: Setup Node.js
      uses: actions/setup-node@v4
      with:
        node-version: '18'
        cache: 'npm'
    
    - name: Install Prerequisites
      run: sudo apt-get update && sudo apt-get install -y jq python3
    
    - name: Setup Security Tools
      run: |
        chmod +x *.sh
        ls -la *.sh *.py  # Verify tools are present
    
    - name: Quick Security Check
      id: security-scan
      run: |
        echo "Running security scan..."
        set +e  # Don't fail immediately
        ./local-security-check.sh .
        SCAN_EXIT_CODE=$?
        echo "scan_result=$SCAN_EXIT_CODE" >> $GITHUB_OUTPUT
        exit $SCAN_EXIT_CODE
      continue-on-error: true
      
    - name: Comprehensive Security Analysis
      if: steps.security-scan.outputs.scan_result != '0'
      run: |
        echo "Running detailed security analysis..."
        python3 npm_package_compromise_detector_2025.py . --full-tree --output security-report.txt
        
    - name: Upload Security Report
      if: steps.security-scan.outputs.scan_result != '0'
      uses: actions/upload-artifact@v4
      with:
        name: security-report-${{ github.run_number }}
        path: security-report.txt
        retention-days: 30
        
    - name: Comment on PR (Compromised Packages Found)
      if: steps.security-scan.outputs.scan_result != '0' && github.event_name == 'pull_request'
      uses: actions/github-script@v7
      with:
        script: |
          const comment = \`## 🚨 Security Alert: Compromised NPM Packages Detected
          
          **CRITICAL**: This pull request contains or depends on compromised NPM packages from our database of **195 confirmed compromised packages**.
          
          **🎯 Organizations Monitored**: @ctrl, @nativescript-community, @art-ws, @crowdstrike, @operato, @teselagen, @things-factory, and others.
          
          ### Immediate Actions Required:
          1. 🛑 **DO NOT MERGE** this pull request
          2. 🧹 Clear npm cache: \`npm cache clean --force\`
          3. 🗑️ Remove node_modules: \`rm -rf node_modules\`
          4. 📋 Check the detailed security report in the workflow artifacts
          5. 🔄 Update to safe package versions (auto-generated in report)
          6. ✅ Re-run security scan after fixes
          
          **Detailed Report**: Download the \`security-report-\${{ github.run_number }}\` artifact from this workflow run for complete safe version recommendations.
          \`;
          
          github.rest.issues.createComment({
            issue_number: context.issue.number,
            owner: context.repo.owner,
            repo: context.repo.repo,
            body: comment
          });
    
    - name: Fail Workflow if Compromised Packages Found
      if: steps.security-scan.outputs.scan_result != '0'
      run: |
        echo "❌ Workflow failed: Compromised NPM packages detected"
        echo "Check the security report artifact for detailed information"
        exit 1
    
    - name: Success Message
      if: steps.security-scan.outputs.scan_result == '0'
      run: |
        echo "✅ Security scan passed: No compromised packages detected"
        echo "Your NPM dependencies are clean of all 195 monitored compromised packages"
        echo "Scanned organizations: @ctrl, @nativescript-community, @art-ws, @crowdstrike, and 7+ others"
```

#### **Option 2: Download from GitHub Raw (If Published)**
```yaml
name: NPM Package Security Scan

on:
  push:
    branches: [ main ]
  pull_request:
    branches: [ main ]

jobs:
  security-scan:
    runs-on: ubuntu-latest
    steps:
    - name: Checkout code
      uses: actions/checkout@v4
    
    - name: Install Prerequisites
      run: sudo apt-get update && sudo apt-get install -y jq python3
    
    - name: Download Security Tools
      run: |
        # Replace 'your-username/your-repo' with actual repository
        REPO_URL="https://raw.githubusercontent.com/your-username/your-repo/main"
        
        curl -fsSL "$REPO_URL/local-security-check.sh" -o security-check.sh
        curl -fsSL "$REPO_URL/npm_package_compromise_detector_2025.py" -o detector.py
        curl -fsSL "$REPO_URL/compromised_packages_2025.json" -o compromised_packages.json
        
        chmod +x security-check.sh
    
    - name: Run Security Scan
      run: ./security-check.sh .
```

### Advanced Workflow with Matrix Strategy
```yaml
name: Multi-Project Security Scan

on:
  push:
    branches: [ main ]
  schedule:
    - cron: '0 6 * * 1'  # Weekly on Monday

jobs:
  detect-projects:
    runs-on: ubuntu-latest
    outputs:
      projects: ${{ steps.find-projects.outputs.projects }}
    steps:
    - name: Checkout code
      uses: actions/checkout@v4
      
    - name: Find Node.js projects
      id: find-projects
      run: |
        projects=$(find . -name "package.json" -not -path "./node_modules/*" | xargs dirname | jq -R -s -c 'split("\n")[:-1]')
        echo "projects=$projects" >> $GITHUB_OUTPUT

  security-scan:
    needs: detect-projects
    runs-on: ubuntu-latest
    if: needs.detect-projects.outputs.projects != '[]'
    strategy:
      fail-fast: false
      matrix:
        project: ${{ fromJson(needs.detect-projects.outputs.projects) }}
        
    steps:
    - name: Checkout code
      uses: actions/checkout@v4
      
    - name: Setup security tools
      run: |
        sudo apt-get update && sudo apt-get install -y jq
        curl -O https://raw.githubusercontent.com/your-repo/quick-check-compromised-packages-2025.sh
        curl -O https://raw.githubusercontent.com/your-repo/npm_package_compromise_detector_2025.py
        curl -O https://raw.githubusercontent.com/your-repo/compromised_packages_2025.json
        chmod +x quick-check-compromised-packages-2025.sh
        
    - name: Scan project ${{ matrix.project }}
      run: |
        echo "🔍 Scanning project: ${{ matrix.project }}"
        ./quick-check-compromised-packages-2025.sh "${{ matrix.project }}"
        
    - name: Generate detailed report
      if: always()
      run: |
        python3 npm_package_compromise_detector_2025.py "${{ matrix.project }}" \
          --output "security-report-$(basename "${{ matrix.project }}").txt"
          
    - name: Upload project report
      if: always()
      uses: actions/upload-artifact@v4
      with:
        name: security-report-${{ matrix.project }}
        path: security-report-*.txt
```

### Slack/Teams Notification Workflow
```yaml
name: Security Scan with Notifications

on:
  schedule:
    - cron: '0 9 * * 1-5'  # Weekdays at 9 AM

jobs:
  security-scan:
    runs-on: ubuntu-latest
    
    steps:
    - name: Checkout code
      uses: actions/checkout@v4
      
    - name: Setup tools
      run: |
        sudo apt-get update && sudo apt-get install -y jq
        # Download security tools (same as above)
        
    - name: Run security scan
      id: scan
      run: |
        set +e  # Don't exit on error
        ./quick-check-compromised-packages-2025.sh . > scan-output.txt 2>&1
        scan_exit_code=$?
        echo "exit_code=$scan_exit_code" >> $GITHUB_OUTPUT
        echo "scan_output<<EOF" >> $GITHUB_OUTPUT
        cat scan-output.txt >> $GITHUB_OUTPUT
        echo "EOF" >> $GITHUB_OUTPUT
        
    - name: Notify Slack on compromise detection
      if: steps.scan.outputs.exit_code != '0'
      uses: 8398a7/action-slack@v3
      with:
        status: failure
        custom_payload: |
          {
            text: "🚨 CRITICAL: Compromised NPM packages detected in ${{ github.repository }}",
            attachments: [{
              color: "danger",
              fields: [{
                title: "Repository",
                value: "${{ github.repository }}",
                short: true
              }, {
                title: "Branch",
                value: "${{ github.ref_name }}",
                short: true
              }, {
                title: "Scan Results",
                value: "```${{ steps.scan.outputs.scan_output }}```",
                short: false
              }]
            }]
          }
      env:
        SLACK_WEBHOOK_URL: ${{ secrets.SLACK_WEBHOOK_URL }}
```

## 🔄 CI/CD Pipeline Examples

### Jenkins Pipeline
```groovy
pipeline {
    agent any
    
    triggers {
        cron('H 2 * * *')  // Daily at 2 AM
    }
    
    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
        
        stage('Setup Security Tools') {
            steps {
                sh '''
                    apt-get update && apt-get install -y jq
                    curl -O https://raw.githubusercontent.com/your-repo/quick-check-compromised-packages-2025.sh
                    curl -O https://raw.githubusercontent.com/your-repo/npm_package_compromise_detector_2025.py
                    curl -O https://raw.githubusercontent.com/your-repo/compromised_packages_2025.json
                    chmod +x quick-check-compromised-packages-2025.sh
                '''
            }
        }
        
        stage('Security Scan') {
            steps {
                script {
                    def scanResult = sh(
                        script: './quick-check-compromised-packages-2025.sh .',
                        returnStatus: true
                    )
                    
                    if (scanResult != 0) {
                        currentBuild.result = 'FAILURE'
                        error("🚨 Compromised packages detected!")
                    }
                }
            }
        }
        
        stage('Detailed Analysis') {
            when {
                anyOf {
                    expression { currentBuild.result == 'FAILURE' }
                    expression { params.FORCE_DETAILED_SCAN == true }
                }
            }
            steps {
                sh 'python3 npm_package_compromise_detector_2025.py . --full-tree --output security-report.txt'
                archiveArtifacts artifacts: 'security-report.txt', fingerprint: true
            }
        }
    }
    
    post {
        failure {
            emailext (
                subject: "🚨 SECURITY ALERT: Compromised NPM packages in ${env.JOB_NAME}",
                body: "Compromised NPM packages have been detected. Please check the build logs and security report.",
                to: "${env.SECURITY_TEAM_EMAIL}"
            )
        }
    }
}
```

### GitLab CI
```yaml
# .gitlab-ci.yml
stages:
  - security-scan
  - detailed-analysis
  - notify

variables:
  TOOLS_URL: "https://raw.githubusercontent.com/your-repo"

before_script:
  - apt-get update && apt-get install -y jq curl python3
  - curl -O ${TOOLS_URL}/quick-check-compromised-packages-2025.sh
  - curl -O ${TOOLS_URL}/npm_package_compromise_detector_2025.py  
  - curl -O ${TOOLS_URL}/compromised_packages_2025.json
  - chmod +x quick-check-compromised-packages-2025.sh

quick-scan:
  stage: security-scan
  script:
    - ./quick-check-compromised-packages-2025.sh .
  allow_failure: false
  rules:
    - if: $CI_PIPELINE_SOURCE == "schedule"
    - if: $CI_COMMIT_BRANCH == $CI_DEFAULT_BRANCH

detailed-scan:
  stage: detailed-analysis
  script:
    - python3 npm_package_compromise_detector_2025.py . --full-tree --output security-report.txt
  artifacts:
    reports:
      junit: security-report.txt
    paths:
      - security-report.txt
    expire_in: 30 days
  when: on_failure
  
security-notification:
  stage: notify
  script:
    - |
      curl -X POST -H 'Content-type: application/json' \
      --data '{"text":"🚨 CRITICAL: Compromised NPM packages detected in '"$CI_PROJECT_NAME"'"}' \
      $SLACK_WEBHOOK_URL
  when: on_failure
  only:
    variables:
      - $SLACK_WEBHOOK_URL
```

## 📱 Local Development Workflow

### Pre-commit Hook
```bash
# .git/hooks/pre-commit
#!/bin/bash
echo "🔍 Checking for compromised NPM packages..."

# Path to your security tools (adjust as needed)
SCRIPT_DIR="$(dirname "$0")/../../security-tools"

if [ -f "$SCRIPT_DIR/quick-check-compromised-packages-2025.sh" ]; then
    if ! "$SCRIPT_DIR/quick-check-compromised-packages-2025.sh" .; then
        echo "❌ Commit blocked: Compromised packages detected!"
        echo "Run the security scan manually to see details:"
        echo "  $SCRIPT_DIR/quick-check-compromised-packages-2025.sh ."
        exit 1
    fi
    echo "✅ No compromised packages detected"
else
    echo "⚠️  Security tools not found, skipping check"
fi
```

### Package.json Scripts
```json
{
  "scripts": {
    "security:quick": "./security-tools/quick-check-compromised-packages-2025.sh .",
    "security:full": "python3 ./security-tools/npm_package_compromise_detector_2025.py . --full-tree",
    "security:report": "python3 ./security-tools/npm_package_compromise_detector_2025.py . --full-tree --output security-report-$(date +%Y%m%d).txt",
    "preinstall": "npm run security:quick",
    "postinstall": "npm run security:quick"
  }
}
```

## 🔧 Troubleshooting

### Common Issues

**1. `jq` not found**
```bash
# Install jq
sudo apt-get install jq        # Ubuntu/Debian
brew install jq               # macOS  
choco install jq              # Windows
```

**2. Permission denied**
```bash
chmod +x quick-check-compromised-packages-2025.sh
```

**3. Python script not found**
```bash
# Ensure you're in the correct directory
ls -la npm_package_compromise_detector_2025.py
# Or use absolute path
python3 /full/path/to/npm_package_compromise_detector_2025.py .
```

**4. GitHub Actions failing**
```yaml
# Add debug step
- name: Debug environment
  run: |
    pwd
    ls -la
    which jq
    which python3
```

### Exit Codes
- `0`: No compromised packages found
- `1`: Compromised packages detected
- `2`: Script error (missing dependencies, invalid arguments, etc.)

### Performance Tips
- Use shell script for quick checks in CI/CD
- Use Python script with `--full-tree` for comprehensive audits
- Run detailed scans on schedule, not on every commit
- Cache security tools in CI/CD to speed up builds

## 🚀 Ready to Use Examples

### One-liner for quick check
```bash
curl -s https://raw.githubusercontent.com/your-repo/quick-check-compromised-packages-2025.sh | bash -s .
```

### Docker container scan
```bash
docker run --rm -v $(pwd):/workspace -w /workspace ubuntu:latest bash -c "
  apt-get update && apt-get install -y jq curl python3 &&
  curl -O https://raw.githubusercontent.com/your-repo/quick-check-compromised-packages-2025.sh &&
  chmod +x quick-check-compromised-packages-2025.sh &&
  ./quick-check-compromised-packages-2025.sh .
"
```

---

## 📞 Need Help?

- **Quick issues**: Check the exit codes and error messages
- **GitHub Actions**: Review the workflow logs and artifacts
- **False positives**: Review the detailed report to understand findings
- **Custom configuration**: Modify `compromised_packages_2025.json` as needed

## 📚 **Quick Reference Card**

### **🚀 Most Common Commands**
```bash
# Daily quick check
./local-security-check.sh .

# Before deployment
python3 npm_package_compromise_detector_2025.py . --full-tree --output pre-deploy-report.txt

# Check specific project
./local-security-check.sh /path/to/project

# Emergency scan after security alert
python3 npm_package_compromise_detector_2025.py . --full-tree --output emergency-$(date +%Y%m%d).txt
```

### **🎯 Command Comparison (195 Package Coverage)**

| Need | Command | Speed | Output | Coverage |
|------|---------|-------|--------|----------|
| **Quick daily check** | `./local-security-check.sh .` | ⚡ Fast | Clean summary | 195 packages + orgs |
| **CI/CD integration** | `./quick-check-compromised-packages-2025.sh .` | ⚡ Fast | Basic output | 195 specific versions |
| **Security audit** | `python3 npm_package_compromise_detector_2025.py . --full-tree` | 🐌 Thorough | Comprehensive | 195 + source analysis |
| **Detailed report** | `python3 npm_package_compromise_detector_2025.py . --full-tree --output report.txt` | 🐌 Thorough | File + console | Full + safe versions |
| **Only critical issues** | `python3 npm_package_compromise_detector_2025.py . --quiet` | 🚀 Medium | Filtered | 195 critical only |

### **📊 Exit Code Reference**
- `0` = ✅ Clean (no compromised packages)
- `1` = 🚨 Compromised packages detected (IMMEDIATE ACTION REQUIRED)
- `2` = ⚠️ Script error (check dependencies, file paths, permissions)

### **🚨 Emergency Checklist**
If you see compromised packages:
1. ⏹️ **STOP** - Don't ignore this
2. 🔍 **ANALYZE** - Run detailed scan: `python3 npm_package_compromise_detector_2025.py . --full-tree --output emergency.txt`
3. 🧹 **CLEAN** - `npm cache clean --force && rm -rf node_modules`
4. 📋 **REVIEW** - Check `emergency.txt` for safe versions
5. 🔄 **UPDATE** - Modify package.json with safe versions
6. 🔧 **REINSTALL** - `npm install`
7. ✅ **VERIFY** - `./local-security-check.sh .`

### **💡 Pro Tips**
- Run `./local-security-check.sh .` every morning (monitors 195 packages)
- Add to your git pre-commit hooks for automatic protection
- Use `--full-tree` for comprehensive audits across all dependencies
- Save reports with timestamps for tracking trends
- Integrate into CI/CD for automated protection against 11+ organizations
- Monitor the security report for auto-generated safe version recommendations

**Remember**: Speed is critical with supply chain attacks affecting 195+ packages across major organizations. Run these checks immediately and take action if compromised packages are detected!
