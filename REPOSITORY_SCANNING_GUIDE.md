# 🔍 Repository Scanning & Full Tree Analysis Guide

This comprehensive guide covers all methods for scanning repositories and performing deep dependency analysis with the NPM Security Scanner.

## 📋 Table of Contents

1. [Repository Scanning Methods](#repository-scanning-methods)
2. [Full Tree Analysis](#full-tree-analysis)
3. [Command Reference](#command-reference)
4. [Practical Examples](#practical-examples)
5. [Advanced Scenarios](#advanced-scenarios)
6. [Troubleshooting](#troubleshooting)

---

## 🚀 Repository Scanning Methods

### 1. **Local Repository Scanning**

Scan repositories that are already cloned locally on your machine.

#### **Single Repository**
```bash
# Scan current directory
python3 enhanced_npm_compromise_detector_phoenix.py .

# Scan specific local repository
python3 enhanced_npm_compromise_detector_phoenix.py /path/to/your/repo

# Scan with organized output
python3 enhanced_npm_compromise_detector_phoenix.py /path/to/repo --organize-folders --output repo-scan.txt
```

#### **Multiple Local Folders**
```bash
# Create a list of local folders
cat > local_folders.txt << EOF
/Users/username/projects/frontend-app
/Users/username/projects/backend-api
/Users/username/projects/mobile-app
EOF

# Scan all folders in the list
python3 enhanced_npm_compromise_detector_phoenix.py --folder-list local_folders.txt --output multi-folder-scan.txt
```

### 2. **Remote Repository Scanning (Light Scan)**

Scan remote GitHub repositories without fully cloning them - downloads only NPM files.

#### **Single Remote Repository**
```bash
# Light scan a single GitHub repository
python3 enhanced_npm_compromise_detector_phoenix.py \
  --light-scan \
  --repo-list <(echo "https://github.com/facebook/react") \
  --output react-light-scan.txt
```

#### **Multiple Remote Repositories**
```bash
# Create repository list file
cat > github_repos.txt << EOF
https://github.com/facebook/react
https://github.com/vuejs/vue
https://github.com/angular/angular
https://github.com/microsoft/TypeScript
https://github.com/nodejs/node
EOF

# Light scan all repositories
python3 enhanced_npm_compromise_detector_phoenix.py \
  --light-scan \
  --repo-list github_repos.txt \
  --organize-folders \
  --output multi-repo-light-scan.txt
```

### 3. **Full Repository Cloning & Analysis**

Clone and perform comprehensive analysis on remote repositories.

#### **Single Repository with Full Clone**
```bash
# Clone and scan (traditional method)
git clone https://github.com/facebook/react.git
python3 enhanced_npm_compromise_detector_phoenix.py react/ --output react-full-scan.txt

# Or use repo-list for automatic cloning
echo "https://github.com/facebook/react" > single_repo.txt
python3 enhanced_npm_compromise_detector_phoenix.py \
  --repo-list single_repo.txt \
  --organize-folders \
  --output react-cloned-scan.txt
```

#### **Batch Repository Cloning**
```bash
# Create comprehensive repository list
cat > enterprise_repos.txt << EOF
https://github.com/your-org/frontend-app
https://github.com/your-org/backend-services
https://github.com/your-org/mobile-client
https://github.com/your-org/shared-libraries
https://github.com/your-org/deployment-scripts
EOF

# Clone and scan all repositories
python3 enhanced_npm_compromise_detector_phoenix.py \
  --repo-list enterprise_repos.txt \
  --organize-folders \
  --enable-phoenix \
  --output enterprise-security-scan.txt
```

---

## 🌳 Full Tree Analysis

Full tree analysis provides comprehensive dependency scanning, including nested dependencies and lock files.

### **What is Full Tree Analysis?**

Full tree analysis:
- ✅ Scans `package.json` files
- ✅ Analyzes `package-lock.json` for exact versions
- ✅ Processes `yarn.lock` files
- ✅ Examines nested `node_modules` directories
- ✅ Traces dependency chains
- ✅ Identifies transitive dependencies

### **Full Tree Commands**

#### **Local Full Tree Analysis**
```bash
# Full tree analysis of current directory
python3 enhanced_npm_compromise_detector_phoenix.py . \
  --full-tree \
  --output full-tree-analysis.txt

# Full tree with organized output
python3 enhanced_npm_compromise_detector_phoenix.py . \
  --full-tree \
  --organize-folders \
  --output comprehensive-tree-scan.txt

# Full tree with Phoenix integration
python3 enhanced_npm_compromise_detector_phoenix.py . \
  --full-tree \
  --enable-phoenix \
  --debug \
  --output phoenix-full-tree.txt
```

#### **Remote Repository Full Tree**
```bash
# Full tree analysis of remote repositories
cat > full_tree_repos.txt << EOF
https://github.com/facebook/create-react-app
https://github.com/vercel/next.js
https://github.com/nuxt/nuxt.js
EOF

python3 enhanced_npm_compromise_detector_phoenix.py \
  --repo-list full_tree_repos.txt \
  --full-tree \
  --organize-folders \
  --output remote-full-tree-scan.txt
```

#### **Enterprise Full Tree Scanning**
```bash
# Comprehensive enterprise scanning
python3 enhanced_npm_compromise_detector_phoenix.py \
  --repo-list enterprise_repos.txt \
  --full-tree \
  --enable-phoenix \
  --organize-folders \
  --debug \
  --output enterprise-full-tree-analysis.txt
```

---

## 📖 Command Reference

### **Core Commands**

| Command | Description | Example |
|---------|-------------|---------|
| `python3 enhanced_npm_compromise_detector_phoenix.py .` | Basic scan of current directory | `python3 enhanced_npm_compromise_detector_phoenix.py .` |
| `--repo-list FILE` | Scan repositories from list file | `--repo-list repos.txt` |
| `--folder-list FILE` | Scan local folders from list file | `--folder-list folders.txt` |
| `--folders FOLDER1 FOLDER2` | Scan specific folders directly | `--folders ./app ./api` |
| `--light-scan` | Light scan (NPM files only) | `--light-scan --repo-list repos.txt` |
| `--full-tree` | Full dependency tree analysis | `--full-tree` |

### **Output & Organization**

| Command | Description | Example |
|---------|-------------|---------|
| `--output FILE` | Specify output report file | `--output security-report.txt` |
| `--organize-folders` | Create timestamped result folders | `--organize-folders` |
| `--quiet` | Suppress verbose output | `--quiet` |

### **Phoenix Integration**

| Command | Description | Example |
|---------|-------------|---------|
| `--enable-phoenix` | Enable Phoenix Security API | `--enable-phoenix` |
| `--debug` | Enable debug mode (save API payloads) | `--debug` |
| `--use-embedded-credentials` | Use credentials embedded in script | `--use-embedded-credentials` |

### **Advanced Options**

| Command | Description | Example |
|---------|-------------|---------|
| `--create-config` | Create configuration file template | `--create-config` |
| `--help` | Show help message | `--help` |

---

## 🎯 Practical Examples

### **Example 1: Quick Local Project Scan**

```bash
# Navigate to your project
cd /path/to/your/project

# Quick security scan
python3 enhanced_npm_compromise_detector_phoenix.py . --output quick-scan.txt

# View results
cat quick-scan.txt
```

### **Example 2: Comprehensive Local Analysis**

```bash
# Full analysis with all features
python3 enhanced_npm_compromise_detector_phoenix.py . \
  --full-tree \
  --organize-folders \
  --enable-phoenix \
  --debug \
  --output comprehensive-local-analysis.txt

# Results will be in: result/YYYYMMDD/comprehensive-local-analysis.txt
# Debug files will be in: debug/
```

### **Example 3: Multi-Repository Enterprise Scan**

```bash
# Step 1: Create repository list
cat > company_repos.txt << EOF
https://github.com/company/web-frontend
https://github.com/company/mobile-app
https://github.com/company/api-gateway
https://github.com/company/microservice-auth
https://github.com/company/shared-components
EOF

# Step 2: Run comprehensive scan
python3 enhanced_npm_compromise_detector_phoenix.py \
  --repo-list company_repos.txt \
  --full-tree \
  --enable-phoenix \
  --organize-folders \
  --debug \
  --output company-security-audit.txt

# Step 3: Review results
ls -la result/$(date +%Y%m%d)/
ls -la debug/
```

### **Example 4: Light Scan for Quick Assessment**

```bash
# Step 1: Create list of external dependencies or repos to assess
cat > external_assessment.txt << EOF
https://github.com/lodash/lodash
https://github.com/expressjs/express
https://github.com/facebook/react
https://github.com/vuejs/vue
https://github.com/angular/angular
EOF

# Step 2: Quick light scan assessment
python3 enhanced_npm_compromise_detector_phoenix.py \
  --light-scan \
  --repo-list external_assessment.txt \
  --organize-folders \
  --output external-dependency-assessment.txt

# Step 3: Review findings
cat result/$(date +%Y%m%d)/external-dependency-assessment.txt
```

### **Example 5: Local Development Workflow**

```bash
# Step 1: Create list of your active projects
cat > my_projects.txt << EOF
/Users/developer/projects/frontend-dashboard
/Users/developer/projects/backend-api
/Users/developer/projects/mobile-client
/Users/developer/projects/shared-utils
EOF

# Step 2: Regular security check
python3 enhanced_npm_compromise_detector_phoenix.py \
  --folder-list my_projects.txt \
  --organize-folders \
  --output weekly-security-check.txt

# Step 3: Phoenix integration for tracking
python3 enhanced_npm_compromise_detector_phoenix.py \
  --folder-list my_projects.txt \
  --enable-phoenix \
  --organize-folders \
  --output weekly-phoenix-sync.txt
```

### **Example 6: CI/CD Integration Commands**

```bash
# For Jenkins/GitHub Actions
python3 enhanced_npm_compromise_detector_phoenix.py . \
  --full-tree \
  --enable-phoenix \
  --organize-folders \
  --debug \
  --output "ci-security-scan-${BUILD_NUMBER:-$(date +%Y%m%d_%H%M%S)}.txt"

# For local CI testing
python3 enhanced_npm_compromise_detector_phoenix.py . \
  --full-tree \
  --organize-folders \
  --output "local-ci-test-$(date +%Y%m%d_%H%M%S).txt"
```

---

## 🔧 Advanced Scenarios

### **Scenario 1: Organization-Wide Security Audit**

```bash
#!/bin/bash
# comprehensive-org-audit.sh

# Step 1: Define all organizational repositories
cat > org_audit_repos.txt << EOF
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

# Step 2: Run comprehensive audit
echo "🔍 Starting organization-wide security audit..."
python3 enhanced_npm_compromise_detector_phoenix.py \
  --repo-list org_audit_repos.txt \
  --full-tree \
  --enable-phoenix \
  --organize-folders \
  --debug \
  --output "org-security-audit-$(date +%Y%m%d).txt"

# Step 3: Generate summary
echo "📊 Audit completed. Results available in:"
echo "   Report: result/$(date +%Y%m%d)/org-security-audit-$(date +%Y%m%d).txt"
echo "   Debug: debug/"
echo "   Phoenix: Check your Phoenix Security dashboard"
```

### **Scenario 2: Dependency Supply Chain Analysis**

```bash
#!/bin/bash
# supply-chain-analysis.sh

# Analyze specific high-risk packages across your ecosystem
cat > supply_chain_focus.txt << EOF
https://github.com/your-org/app-using-lodash
https://github.com/your-org/app-using-express
https://github.com/your-org/app-using-react
https://github.com/your-org/app-using-angular
EOF

echo "🔗 Analyzing supply chain dependencies..."
python3 enhanced_npm_compromise_detector_phoenix.py \
  --repo-list supply_chain_focus.txt \
  --full-tree \
  --enable-phoenix \
  --organize-folders \
  --debug \
  --output "supply-chain-analysis-$(date +%Y%m%d).txt"

# Additional local projects analysis
python3 enhanced_npm_compromise_detector_phoenix.py \
  --folder-list my_projects.txt \
  --full-tree \
  --organize-folders \
  --output "local-supply-chain-$(date +%Y%m%d).txt"
```

### **Scenario 3: Continuous Monitoring Setup**

```bash
#!/bin/bash
# continuous-monitoring.sh

# Daily monitoring script
TIMESTAMP=$(date +%Y%m%d_%H%M%S)

# Monitor production repositories
cat > production_monitoring.txt << EOF
https://github.com/company/production-frontend
https://github.com/company/production-api
https://github.com/company/production-mobile
EOF

echo "📅 Daily security monitoring - $TIMESTAMP"
python3 enhanced_npm_compromise_detector_phoenix.py \
  --light-scan \
  --repo-list production_monitoring.txt \
  --enable-phoenix \
  --organize-folders \
  --output "daily-monitoring-$TIMESTAMP.txt"

# Check if critical vulnerabilities found
if grep -q "CRITICAL" "result/$(date +%Y%m%d)/daily-monitoring-$TIMESTAMP.txt"; then
    echo "🚨 CRITICAL vulnerabilities found! Check the report immediately."
    # Send alert (customize as needed)
    # curl -X POST -H 'Content-type: application/json' --data '{"text":"🚨 Critical NPM vulnerabilities detected in production!"}' $SLACK_WEBHOOK_URL
fi
```

### **Scenario 4: Development Team Workflow**

```bash
#!/bin/bash
# team-workflow.sh

# Pre-commit hook style scanning
echo "🔍 Pre-commit security scan..."
python3 enhanced_npm_compromise_detector_phoenix.py . \
  --output "pre-commit-scan.txt"

# Check for critical issues
CRITICAL_COUNT=$(grep -c "CRITICAL" pre-commit-scan.txt 2>/dev/null || echo "0")

if [ "$CRITICAL_COUNT" -gt 0 ]; then
    echo "❌ Pre-commit check failed: $CRITICAL_COUNT critical vulnerabilities found"
    echo "📄 Review: pre-commit-scan.txt"
    exit 1
else
    echo "✅ Pre-commit security check passed"
    exit 0
fi
```

---

## 🐛 Troubleshooting

### **Common Issues and Solutions**

#### **1. Repository Access Issues**

```bash
# Problem: Can't access private repositories
# Solution: Set up GitHub token
export GITHUB_TOKEN="your_github_token_here"

# Or add to your shell profile
echo 'export GITHUB_TOKEN="your_github_token_here"' >> ~/.bashrc
```

#### **2. Phoenix API Connection Issues**

```bash
# Problem: Phoenix API authentication fails
# Solution: Verify credentials
cat .config

# Test connection manually
curl -u "client_id:client_secret" "https://api.demo.appsecphx.io/v1/auth/access_token"

# Enable debug mode for detailed error info
python3 enhanced_npm_compromise_detector_phoenix.py . --enable-phoenix --debug
```

#### **3. Large Repository Timeouts**

```bash
# Problem: Large repositories timing out
# Solution: Use light scan mode
python3 enhanced_npm_compromise_detector_phoenix.py \
  --light-scan \
  --repo-list large_repos.txt \
  --output light-scan-results.txt

# Or increase timeout (if supported)
# Set environment variable
export SCAN_TIMEOUT=3600  # 1 hour
```

#### **4. Memory Issues with Full Tree**

```bash
# Problem: Out of memory during full tree analysis
# Solution: Process repositories individually
while IFS= read -r repo; do
    echo "Processing: $repo"
    echo "$repo" > temp_single_repo.txt
    python3 enhanced_npm_compromise_detector_phoenix.py \
      --repo-list temp_single_repo.txt \
      --full-tree \
      --output "individual-$(basename $repo)-scan.txt"
done < large_repo_list.txt
```

#### **5. Network Issues**

```bash
# Problem: Network timeouts or connection issues
# Solution: Add retry logic
for i in {1..3}; do
    echo "Attempt $i of 3"
    if python3 enhanced_npm_compromise_detector_phoenix.py \
       --light-scan \
       --repo-list repos.txt \
       --output "attempt-$i-scan.txt"; then
        echo "✅ Scan successful on attempt $i"
        break
    else
        echo "⚠️ Attempt $i failed, retrying..."
        sleep 30
    fi
done
```

### **Debug Commands**

```bash
# Enable maximum debugging
python3 enhanced_npm_compromise_detector_phoenix.py . \
  --debug \
  --enable-phoenix \
  --organize-folders \
  --output debug-scan.txt

# Check debug output
ls -la debug/
cat debug/phoenix_response_*.json
```

### **Performance Optimization**

```bash
# For faster scanning of many repositories
python3 enhanced_npm_compromise_detector_phoenix.py \
  --light-scan \
  --repo-list repos.txt \
  --quiet \
  --output fast-scan.txt

# For detailed analysis with organized output
python3 enhanced_npm_compromise_detector_phoenix.py \
  --repo-list repos.txt \
  --full-tree \
  --organize-folders \
  --output detailed-scan.txt
```

---

## 📚 Additional Resources

### **Repository List Templates**

#### **Frontend Focus**
```bash
cat > frontend_repos.txt << EOF
https://github.com/facebook/react
https://github.com/vuejs/vue
https://github.com/angular/angular
https://github.com/sveltejs/svelte
https://github.com/vercel/next.js
EOF
```

#### **Backend Focus**
```bash
cat > backend_repos.txt << EOF
https://github.com/expressjs/express
https://github.com/koajs/koa
https://github.com/fastify/fastify
https://github.com/nestjs/nest
https://github.com/nodejs/node
EOF
```

#### **Full Stack Focus**
```bash
cat > fullstack_repos.txt << EOF
https://github.com/meteor/meteor
https://github.com/keystonejs/keystone
https://github.com/strapi/strapi
https://github.com/parse-community/parse-server
EOF
```

### **Command Combinations**

```bash
# Quick assessment
python3 enhanced_npm_compromise_detector_phoenix.py . --output quick.txt

# Comprehensive local
python3 enhanced_npm_compromise_detector_phoenix.py . --full-tree --organize-folders --output comprehensive.txt

# Enterprise with Phoenix
python3 enhanced_npm_compromise_detector_phoenix.py --repo-list enterprise.txt --full-tree --enable-phoenix --debug --organize-folders --output enterprise.txt

# Light scan external
python3 enhanced_npm_compromise_detector_phoenix.py --light-scan --repo-list external.txt --organize-folders --output external.txt
```

---

**🎉 You're now equipped with comprehensive knowledge for repository scanning and full tree analysis!**

Use this guide to implement robust security scanning across your entire development ecosystem, from local projects to enterprise-wide repository audits. 🛡️✨
