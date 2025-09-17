# Vanilla Script Usage Guide - No Phoenix Integration

## 🍦 Overview

This guide covers using the NPM compromise scanner **without** Phoenix Security integration - perfect for local development, CI/CD, and environments where you don't have Phoenix Security access.

## 🎯 When to Use Vanilla Mode

- **No Phoenix Security**: You don't have access to Phoenix Security platform
- **Local Development**: Quick security checks during development
- **CI/CD Pipelines**: Simple pass/fail security gates
- **Offline Environments**: No internet connection required
- **Simple Reporting**: Just need local reports and console output

## 🛠️ Available Vanilla Scripts

### 1. **Enhanced Script (Recommended)**
```bash
# Use enhanced script without Phoenix integration
python3 enhanced_npm_compromise_detector_phoenix.py /path/to/project

# All Phoenix features are simply disabled if no configuration is found
# You get all the enhanced features without needing Phoenix
```

### 2. **Original Vanilla Script**
```bash
# Use the original script (archived in old/ folder)
python3 old/npm_package_compromise_detector_2025_original.py /path/to/project

# Simple, proven, no extra features
```

### 3. **Quick Shell Scripts**
```bash
# Fast shell-based scanning
./quick-check-compromised-packages-2025.sh /path/to/project

# Nice formatted output
./local-security-check.sh /path/to/project
```

## 🚀 Vanilla Usage Examples

### Single Project Scanning

```bash
# Basic scan of current directory
python3 enhanced_npm_compromise_detector_phoenix.py .

# Scan specific project
python3 enhanced_npm_compromise_detector_phoenix.py /Users/yourname/Documents/GitHub/my-project

# Full dependency tree analysis (thorough)
python3 enhanced_npm_compromise_detector_phoenix.py /path/to/project --full-tree

# Quiet mode (only show critical findings)
python3 enhanced_npm_compromise_detector_phoenix.py /path/to/project --quiet

# Save detailed report
python3 enhanced_npm_compromise_detector_phoenix.py /path/to/project --output security-report.txt
```

### Multiple Project Scanning (Local Folders)

```bash
# Scan multiple local folders directly
python3 enhanced_npm_compromise_detector_phoenix.py --folders \
  /Users/yourname/project1 \
  /Users/yourname/project2 \
  /Users/yourname/project3

# Create a folder list file
cat > my_local_projects.txt << EOF
/Users/yourname/Documents/GitHub/frontend-app
/Users/yourname/Documents/GitHub/backend-api
/Users/yourname/work/client-project
EOF

# Scan all folders from list
python3 enhanced_npm_compromise_detector_phoenix.py --folder-list my_local_projects.txt --output batch-scan.txt
```

### Shell Script Usage

```bash
# Quick check with nice output
./local-security-check.sh /path/to/project

# Core detection engine (fastest)
./quick-check-compromised-packages-2025.sh /path/to/project

# Scan multiple projects with shell script
for project in ~/Documents/GitHub/*/; do
    echo "Scanning $project"
    ./local-security-check.sh "$project"
done
```

## 📊 Vanilla Features Available

### ✅ **Full Feature Set (No Phoenix Required)**

- **Complete Compromise Detection**: All 195+ compromised packages
- **Safe Version Recommendations**: Automatic safe version suggestions
- **Full Dependency Tree Analysis**: Deep dependency scanning with `--full-tree`
- **Multiple Output Formats**: Console, file, detailed reports
- **Batch Local Scanning**: Multiple folders from list or direct specification
- **Repository URL Detection**: Automatic Git repository URL detection (for reporting)
- **Fast Performance**: No network calls required for basic scanning
- **Comprehensive Reporting**: Detailed local security reports

### ❌ **Phoenix-Only Features (Not Available)**

- **Centralized Asset Management**: No Phoenix Security dashboard integration
- **Finding Creation**: No centralized vulnerability management
- **Light Scan Mode**: No GitHub API-based repository scanning
- **Remote Repository Processing**: No automatic repository cloning

## 🔧 Configuration for Vanilla Mode

### No Configuration Required

The vanilla mode works out of the box with no configuration:

```bash
# Just run it - no setup needed
python3 enhanced_npm_compromise_detector_phoenix.py /path/to/project
```

### Optional: Custom Compromise Database

```bash
# Use custom package database
python3 enhanced_npm_compromise_detector_phoenix.py /path/to/project --config custom_packages.json
```

### Custom Package Database Format
```json
{
  "compromised_packages": {
    "package-name": {
      "compromised_versions": ["1.0.0", "1.0.1"],
      "safe_version": "0.9.9"
    }
  },
  "potentially_compromised_packages": [
    "suspicious-package-name"
  ]
}
```

## 🔄 Daily Development Workflows

### Developer Daily Check

```bash
#!/bin/bash
# daily-security-check.sh

echo "🔍 Daily Security Check - No Phoenix"
echo "=================================="

# Check current project
python3 enhanced_npm_compromise_detector_phoenix.py . --quiet

if [ $? -eq 0 ]; then
    echo "✅ Current project is clean"
else
    echo "🚨 Security issues found in current project!"
    python3 enhanced_npm_compromise_detector_phoenix.py . --output daily-issues.txt
    echo "📄 Details saved to daily-issues.txt"
fi
```

### Pre-Commit Hook

```bash
#!/bin/bash
# .git/hooks/pre-commit

echo "🔍 Pre-commit security check..."
python3 enhanced_npm_compromise_detector_phoenix.py . --quiet

if [ $? -ne 0 ]; then
    echo "🚨 Commit blocked: Compromised packages detected!"
    echo "Run: python3 enhanced_npm_compromise_detector_phoenix.py . --output security-issues.txt"
    echo "Fix the issues before committing."
    exit 1
fi

echo "✅ Security check passed"
```

### CI/CD Integration

```yaml
# .github/workflows/npm-security-vanilla.yml
name: NPM Security Check (Vanilla)

on: [push, pull_request]

jobs:
  security-scan:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      
      - name: NPM Security Scan
        run: |
          python3 enhanced_npm_compromise_detector_phoenix.py . --quiet --output security-report.txt
          
      - name: Upload Security Report
        if: failure()
        uses: actions/upload-artifact@v3
        with:
          name: security-report
          path: security-report.txt
```

## 📋 Understanding Vanilla Output

### Clean Project Output
```
🔍 Enhanced NPM Package Compromise Detector with Phoenix Integration
======================================================================
✅ Loaded compromise data: 195 packages with specific versions
✅ Loaded 0 potentially compromised packages
📁 Target: /Users/yourname/Documents/GitHub/clean-project

✅ No critical or high priority findings detected

SUMMARY:
--------
Files scanned: 2
Packages analyzed: 45
Compromised packages: 0
Safe packages: 45

✅ Your project appears to be secure from known NPM package compromises
```

### Compromised Project Output
```
🔍 Enhanced NPM Package Compromise Detector with Phoenix Integration
======================================================================
✅ Loaded compromise data: 195 packages with specific versions
📁 Target: /Users/yourname/Documents/GitHub/compromised-project

🚨 CRITICAL FINDINGS:
--------------------
1. [CRITICAL] Compromised package detected: @ctrl/tinycolor@4.1.2
   📁 Location: package.json
   package: @ctrl/tinycolor
   version: 4.1.2
   ⚠️ Compromised versions: 4.1.1, 4.1.2
   ✅ Safe version: ^4.1.0

2. [CRITICAL] Compromised package detected: angulartics2@14.1.2
   📁 Location: package-lock.json
   package: angulartics2
   version: 14.1.2
   ⚠️ Compromised versions: 14.1.1, 14.1.2
   ✅ Safe version: ^14.1.0

SUMMARY:
--------
Files scanned: 2
Packages analyzed: 127
Compromised packages: 2
Safe packages: 125

🚨 IMMEDIATE ACTION REQUIRED: 2 compromised packages detected
```

## 🛠️ Vanilla Command Reference

### Basic Commands
```bash
# Current directory
python3 enhanced_npm_compromise_detector_phoenix.py .

# Specific directory
python3 enhanced_npm_compromise_detector_phoenix.py /path/to/project

# Multiple folders
python3 enhanced_npm_compromise_detector_phoenix.py --folders /path/to/project1 /path/to/project2

# Folder list
python3 enhanced_npm_compromise_detector_phoenix.py --folder-list projects.txt
```

### Output Options
```bash
# Quiet mode (critical only)
python3 enhanced_npm_compromise_detector_phoenix.py /path/to/project --quiet

# Save to file
python3 enhanced_npm_compromise_detector_phoenix.py /path/to/project --output report.txt

# Full tree analysis
python3 enhanced_npm_compromise_detector_phoenix.py /path/to/project --full-tree
```

### Configuration Options
```bash
# Custom config
python3 enhanced_npm_compromise_detector_phoenix.py /path/to/project --config custom.json

# Help
python3 enhanced_npm_compromise_detector_phoenix.py --help
```

## 🚨 Emergency Response (Vanilla Mode)

If compromised packages are detected:

### 1. Stop Development
```bash
# Don't continue development until fixed
echo "🛑 Development stopped due to security issues"
```

### 2. Get Detailed Report
```bash
# Generate comprehensive report
python3 enhanced_npm_compromise_detector_phoenix.py . --full-tree --output emergency-report.txt

# Review the report
cat emergency-report.txt
```

### 3. Clean Environment
```bash
# Clear npm cache
npm cache clean --force

# Remove compromised dependencies
rm -rf node_modules
rm -f package-lock.json yarn.lock
```

### 4. Update Package.json
```bash
# Update to safe versions (from the report)
# Edit package.json manually with safe versions

# Reinstall
npm install

# Verify fix
python3 enhanced_npm_compromise_detector_phoenix.py . --quiet
```

## 🔧 Troubleshooting Vanilla Mode

### Common Issues

**"No package.json found"**
```bash
# Ensure you're in the right directory
ls package.json  # Should exist
cd /path/to/your/npm/project
```

**"Permission denied"**
```bash
# Fix file permissions
chmod +r package.json package-lock.json
```

**Slow performance**
```bash
# Use quiet mode for faster scanning
python3 enhanced_npm_compromise_detector_phoenix.py . --quiet

# Skip full tree analysis for basic checks
python3 enhanced_npm_compromise_detector_phoenix.py .
```

## 📈 Performance Tips

### Faster Scanning
```bash
# Quiet mode (fastest)
--quiet

# Skip full tree analysis
# (don't use --full-tree unless needed)

# Batch multiple folders
--folder-list projects.txt
```

### Memory Usage
```bash
# For large projects, scan one at a time
for project in ~/projects/*/; do
    python3 enhanced_npm_compromise_detector_phoenix.py "$project" --quiet
done
```

## 🎯 Best Practices for Vanilla Mode

1. **Daily Checks**: Run quick scans during development
2. **Pre-Commit Hooks**: Prevent compromised packages from being committed
3. **CI/CD Integration**: Automated security gates
4. **Regular Updates**: Keep the compromise database updated
5. **Batch Scanning**: Use folder lists for multiple projects
6. **Report Archiving**: Save reports with timestamps for tracking

This vanilla mode provides all the core security features without requiring any external services or complex setup!
