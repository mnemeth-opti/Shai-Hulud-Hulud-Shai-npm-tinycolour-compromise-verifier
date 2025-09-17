# 📋 Command Reference - NPM Package Compromise Detection

## 🚀 Quick Commands

### Instant Check (One-liner)
```bash
# Download and run immediately
curl -s https://raw.githubusercontent.com/your-repo/install-and-run.sh | bash

# Check specific directory
curl -s https://raw.githubusercontent.com/your-repo/install-and-run.sh | bash -s /path/to/project
```

### Local Quick Check
```bash
# Current directory
./quick-check-compromised-packages-2025.sh .

# Specific project
./quick-check-compromised-packages-2025.sh /path/to/project

# Multiple projects
for dir in project1 project2 project3; do ./quick-check-compromised-packages-2025.sh "$dir"; done
```

### Comprehensive Analysis
```bash
# Basic scan
python3 npm_package_compromise_detector_2025.py .

# Full dependency tree (recommended)
python3 npm_package_compromise_detector_2025.py . --full-tree

# Save report
python3 npm_package_compromise_detector_2025.py . --full-tree --output report.txt

# Quiet mode (only critical/high)
python3 npm_package_compromise_detector_2025.py . --quiet
```

## 🔧 Installation Commands

### Prerequisites
```bash
# Ubuntu/Debian
sudo apt-get update && sudo apt-get install -y jq python3

# macOS
brew install jq python3

# RHEL/CentOS
sudo yum install -y jq python3
```

### Download Tools
```bash
# Download all tools
curl -O https://raw.githubusercontent.com/your-repo/quick-check-compromised-packages-2025.sh
curl -O https://raw.githubusercontent.com/your-repo/npm_package_compromise_detector_2025.py
curl -O https://raw.githubusercontent.com/your-repo/compromised_packages_2025.json

# Make executable
chmod +x quick-check-compromised-packages-2025.sh
```

## 🐳 Docker Commands

### One-shot Scan
```bash
docker run --rm -v $(pwd):/workspace -w /workspace ubuntu:latest bash -c "
  apt-get update && apt-get install -y jq curl python3 &&
  curl -s https://raw.githubusercontent.com/your-repo/install-and-run.sh | bash
"
```

### Custom Docker Image
```dockerfile
FROM ubuntu:latest
RUN apt-get update && apt-get install -y jq curl python3
COPY quick-check-compromised-packages-2025.sh /usr/local/bin/
COPY npm_package_compromise_detector_2025.py /usr/local/bin/
COPY compromised_packages_2025.json /usr/local/bin/
RUN chmod +x /usr/local/bin/quick-check-compromised-packages-2025.sh
WORKDIR /workspace
ENTRYPOINT ["/usr/local/bin/quick-check-compromised-packages-2025.sh"]
```

```bash
# Build and run
docker build -t npm-security-scanner .
docker run --rm -v $(pwd):/workspace npm-security-scanner .
```

## ⚡ CI/CD Integration

### GitHub Actions (Copy to `.github/workflows/security.yml`)
```yaml
- name: NPM Security Scan
  run: |
    curl -s https://raw.githubusercontent.com/your-repo/install-and-run.sh | bash
```

### Jenkins
```groovy
stage('Security Scan') {
    steps {
        sh 'curl -s https://raw.githubusercontent.com/your-repo/install-and-run.sh | bash'
    }
}
```

### GitLab CI
```yaml
security-scan:
  script:
    - curl -s https://raw.githubusercontent.com/your-repo/install-and-run.sh | bash
```

### Azure DevOps
```yaml
- task: Bash@3
  displayName: 'NPM Security Scan'
  inputs:
    targetType: 'inline'
    script: 'curl -s https://raw.githubusercontent.com/your-repo/install-and-run.sh | bash'
```

## 📊 Exit Codes

| Code | Meaning | Action |
|------|---------|--------|
| `0` | ✅ Clean | No action needed |
| `1` | 🚨 Compromised packages found | **IMMEDIATE ACTION REQUIRED** |
| `2` | ⚠️ Script error | Check dependencies and arguments |

## 🔍 Command Options

### Shell Script Options
```bash
./quick-check-compromised-packages-2025.sh [directory]

# Arguments:
#   directory    Directory to scan (default: current directory)
```

### Python Script Options
```bash
python3 npm_package_compromise_detector_2025.py [options] [directory]

# Options:
--output, -o FILE          Save report to file
--config, -c FILE          Custom configuration file
--full-tree               Enable full dependency tree analysis
--no-recursive            Don't scan subdirectories
--quiet, -q               Only show critical/high findings

# Examples:
python3 npm_package_compromise_detector_2025.py --help
python3 npm_package_compromise_detector_2025.py . --full-tree --output report.txt
python3 npm_package_compromise_detector_2025.py /path/to/project --quiet
```

## 🚨 Emergency Response Commands

### If Compromised Packages Detected
```bash
# 1. Stop applications
pkill -f node
pkill -f npm

# 2. Clean environment
npm cache clean --force
rm -rf node_modules
rm -f package-lock.json yarn.lock

# 3. Generate detailed report
python3 npm_package_compromise_detector_2025.py . --full-tree --output emergency-report.txt

# 4. Review and update packages (see report for safe versions)
# Edit package.json with safe versions, then:
npm install

# 5. Verify fix
./quick-check-compromised-packages-2025.sh .
```

## 📁 File Locations

### Default Scan Targets
- `package.json` (all dependency types)
- `package-lock.json` (lockfile v1, v2, v3)
- `yarn.lock`
- `*.js, *.ts, *.jsx, *.tsx, *.mjs, *.cjs` (source files)

### Generated Files
- `security-report.txt` (detailed analysis)
- Workflow artifacts (GitHub Actions)
- Temporary files (auto-cleaned)

## 🔧 Troubleshooting Commands

### Debug Information
```bash
# Check prerequisites
which jq && echo "jq: OK" || echo "jq: MISSING"
which python3 && echo "python3: OK" || echo "python3: MISSING"
which npm && echo "npm: OK" || echo "npm: MISSING"

# Check file permissions
ls -la quick-check-compromised-packages-2025.sh
ls -la npm_package_compromise_detector_2025.py

# Test configuration
python3 -c "import json; print('Config OK' if json.load(open('compromised_packages_2025.json')) else 'Config Error')"

# Verbose run
bash -x quick-check-compromised-packages-2025.sh .
```

### Common Fixes
```bash
# Fix permissions
chmod +x quick-check-compromised-packages-2025.sh

# Install missing jq
sudo apt-get install jq    # Ubuntu/Debian
brew install jq           # macOS

# Update tools
curl -O https://raw.githubusercontent.com/your-repo/quick-check-compromised-packages-2025.sh
curl -O https://raw.githubusercontent.com/your-repo/npm_package_compromise_detector_2025.py
```

## 📞 Quick Help

| Issue | Solution |
|-------|----------|
| `jq: command not found` | Install jq: `sudo apt-get install jq` |
| `Permission denied` | Run: `chmod +x quick-check-compromised-packages-2025.sh` |
| `No such file` | Download tools or check file paths |
| `Python not found` | Install Python 3: `sudo apt-get install python3` |
| GitHub Actions failing | Check workflow logs and add debug steps |
| False positives | Review detailed report, may be legitimate patterns |

---

**⚡ Remember**: For supply chain attacks, speed is critical. Use the one-liner for immediate checks!
