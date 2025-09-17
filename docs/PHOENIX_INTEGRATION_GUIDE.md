# Phoenix Security API Integration Guide

This guide explains how to use the enhanced NPM compromise detector with Phoenix Security API integration.

## Features

### 🔍 Enhanced Detection
- Detects compromised NPM packages with specific version matching
- Identifies safe versions of monitored packages
- Supports package.json, package-lock.json, and yarn.lock files
- Repository URL auto-detection from file paths

### 🔗 Phoenix Security Integration
- **Asset Creation**: Creates BUILD-type assets for each package file
- **Finding Management**: Creates findings for each package with proper risk scoring
- **Repository Linking**: Automatically links assets to their Git repositories
- **Batch Processing**: Process multiple repositories from a list
- **Flexible Import**: Optional Phoenix import with command-line control

### 📊 Risk Scoring
- **Critical (10.0)**: Compromised packages detected
- **High (8.0)**: Potentially compromised packages
- **Info (3.0)**: Safe versions of monitored packages

## Setup

### 1. Install Dependencies
```bash
pip install requests configparser
```

### 2. Create Phoenix API Configuration
```bash
# Create configuration template
python3 enhanced_npm_compromise_detector_phoenix.py --create-config

# Copy and edit the configuration
cp .config.example .config
```

**⚠️  CRITICAL SETUP STEP**: Edit the `.config` file and replace ALL placeholder values:
- Replace `your_phoenix_client_id_here` with your actual Phoenix client ID
- Replace `your_phoenix_client_secret_here` with your actual Phoenix client secret  
- Replace `your-phoenix-domain.com` with your actual Phoenix Security domain

> **🚨 The integration will NOT work with the example placeholder values. You MUST use your real Phoenix Security credentials and domain.**

### 3. Get Phoenix API Credentials
1. Log into Phoenix Security platform
2. Go to **Organisation > API Access**
3. Create new API credentials
4. Copy Client ID and Secret to `.config` file

## Usage Examples

### Basic Scanning (No Phoenix Integration)
```bash
# Scan current directory
python3 enhanced_npm_compromise_detector_phoenix.py

# Scan specific directory
python3 enhanced_npm_compromise_detector_phoenix.py /path/to/project

# Scan single file
python3 enhanced_npm_compromise_detector_phoenix.py package.json
```

### Phoenix Integration
```bash
# Scan and import to Phoenix
python3 enhanced_npm_compromise_detector_phoenix.py --enable-phoenix

# Scan with custom repository URL
python3 enhanced_npm_compromise_detector_phoenix.py --enable-phoenix --repo-url https://github.com/your-org/your-repo

# Only import to Phoenix (no local report)
python3 enhanced_npm_compromise_detector_phoenix.py --phoenix-only
```

### Batch Processing
```bash
# Create repository list file
cat > my_repos.txt << EOF
https://github.com/Security-Phoenix-demo/Shai-Halud-tinycolour-compromise-verifier
EOF

# Process multiple repositories
python3 enhanced_npm_compromise_detector_phoenix.py --repo-list my_repos.txt --enable-phoenix
```

### Advanced Options
```bash
# Full dependency tree analysis + Phoenix import
python3 enhanced_npm_compromise_detector_phoenix.py --full-tree --enable-phoenix --output detailed_report.txt

# Quiet mode (only critical/high findings)
python3 enhanced_npm_compromise_detector_phoenix.py --quiet --enable-phoenix
```

## Configuration File Format

### `.config` File
```ini
[phoenix]
# ⚠️  IMPORTANT: Replace ALL values below with your actual Phoenix Security credentials
# Required credentials - GET FROM YOUR PHOENIX SECURITY PLATFORM
client_id = your_phoenix_client_id_here
client_secret = your_phoenix_client_secret_here
api_base_url = https://your-phoenix-domain.com/api

# Optional settings
assessment_name = NPM Compromise Detection - Shai Halud
import_type = new
```

> **🔧 Critical Setup Step**: Before using Phoenix integration, you MUST:
> 1. Replace `your_phoenix_client_id_here` with your actual Phoenix client ID
> 2. Replace `your_phoenix_client_secret_here` with your actual Phoenix client secret
> 3. Replace `your-phoenix-domain.com` with your actual Phoenix Security domain
> 4. Save the file as `.config` (no .example extension)

### Repository List File
```
# Comments start with #
https://github.com/org/repo1
https://github.com/org/repo2
git@github.com:org/repo3.git
```

## Phoenix Asset Structure

### Asset Type: BUILD
Each package file creates a BUILD-type asset with:

**Required Attributes:**
- `repository`: Git repository URL
- `buildFile`: package.json or package-lock.json
- `scannerSource`: Shai Halud NPM Compromise Detector

**Optional Attributes:**
- `origin`: github, gitlab, etc.

**Tags:**
- `shai-halud`: Identifies scans from this tool
- `npm-security`: NPM security scanning
- `compromise-detection`: Compromise detection focus

**Installed Software:**
- All NPM packages listed as installed software with vendor="npm"

## Finding Examples

### Critical Finding (Compromised Package)
```json
{
  "name": "NPM Package Security: @ctrl/tinycolor",
  "description": "Compromised package detected: @ctrl/tinycolor@4.1.2",
  "remedy": "Update @ctrl/tinycolor to safe version 4.1.0 or latest stable version",
  "severity": "10.0",
  "location": "test_demo/package.json (dependencies)",
  "cwes": ["CWE-1104"],
  "details": {
    "package_name": "@ctrl/tinycolor",
    "package_version": "4.1.2",
    "is_safe_version": false,
    "compromised_versions": ["4.1.1", "4.1.2"]
  }
}
```

### Info Finding (Safe Version)
```json
{
  "name": "NPM Package Security: debug",
  "description": "Safe version detected: debug@^4.3.4 (compromised versions: 4.4.2)",
  "remedy": "Package debug@^4.3.4 is using a safe version. Continue monitoring for updates.",
  "severity": "3.0",
  "location": "test_demo/package.json (dependencies)",
  "details": {
    "package_name": "debug",
    "package_version": "^4.3.4",
    "is_safe_version": true,
    "compromised_versions": ["4.4.2"]
  }
}
```

## Repository URL Detection

The tool automatically detects repository URLs from file paths using these methods:

1. **GitHub Pattern**: `/Documents/GitHub/repo-name/` → `https://github.com/org/repo-name`
2. **Git Remote**: Reads `git remote get-url origin` from `.git` directory
3. **Path Structure**: Looks for common patterns like `/projects/`, `/repos/`, etc.

### Manual Override
```bash
# Override auto-detection
python3 enhanced_npm_compromise_detector_phoenix.py --repo-url https://github.com/your-org/your-repo
```

## Troubleshooting

### Authentication Issues
```bash
# Test configuration
python3 enhanced_npm_compromise_detector_phoenix.py --create-config
# Check .config file has correct credentials
```

### Repository Detection Issues
```bash
# Check current directory has .git
ls -la .git/

# Manual override
python3 enhanced_npm_compromise_detector_phoenix.py --repo-url https://github.com/your-org/your-repo
```

### Import Failures
- Check Phoenix API credentials in `.config`
- Verify API base URL is correct for your environment
- Check network connectivity to Phoenix API
- Review Phoenix platform for import status

## API Endpoints Used

- **Authentication**: `GET /v1/auth/access_token`
- **Asset Import**: `POST /v1/import/assets`

## Command Line Reference

```
usage: enhanced_npm_compromise_detector_phoenix.py [-h] [--repo-list] [--repo-url REPO_URL] 
                                                   [--config CONFIG] [--phoenix-config PHOENIX_CONFIG] 
                                                   [--create-config] [--output OUTPUT] [--quiet] 
                                                   [--enable-phoenix] [--phoenix-only] [--full-tree] 
                                                   [target]

Enhanced NPM Package Compromise Detection Tool with Phoenix API Integration

positional arguments:
  target                Directory to scan, single file, or repository list file

optional arguments:
  -h, --help            show this help message and exit
  --repo-list           Treat target as a file containing list of repository URLs
  --repo-url REPO_URL   Specify repository URL for the target (overrides auto-detection)
  --config CONFIG, -c CONFIG
                        Configuration file with compromised package data
  --phoenix-config PHOENIX_CONFIG
                        Phoenix API configuration file
  --create-config       Create a template Phoenix API configuration file and exit
  --output OUTPUT, -o OUTPUT
                        Output report file
  --quiet, -q           Only show critical and high severity findings
  --enable-phoenix      Enable Phoenix Security API integration
  --phoenix-only        Only import to Phoenix, skip local report
  --full-tree           Enable full dependency tree analysis (slower but comprehensive)
```

## 🪶 Light Scan Mode (NEW!)

Light scan mode downloads only NPM package files from GitHub repositories instead of cloning entire repositories. This is **much faster** and more efficient for large-scale security scanning.

### **Benefits:**
- ⚡ **10x Faster**: Downloads only package.json, package-lock.json, yarn.lock files
- 💾 **Space Efficient**: No local repository cloning required  
- 🌐 **Network Optimized**: Uses GitHub API for selective file access
- 🔄 **Batch Friendly**: Perfect for scanning hundreds of repositories

### **Usage:**
```bash
# Light scan single repository
python3 enhanced_npm_compromise_detector_phoenix.py https://github.com/org/repo --light-scan --enable-phoenix

# Light scan repository list
python3 enhanced_npm_compromise_detector_phoenix.py --repo-list repos.txt --light-scan --enable-phoenix

# Light scan with GitHub token (higher rate limits)
export GITHUB_TOKEN=your_github_token_here
python3 enhanced_npm_compromise_detector_phoenix.py --repo-list repos.txt --light-scan --enable-phoenix
```

### **How Light Scan Works:**
1. 🔍 **GitHub API Search**: Searches for NPM files using GitHub code search API
2. 🔄 **Fallback Method**: If search fails, tries common NPM file locations directly
3. 📥 **Selective Download**: Downloads only found NPM files to temporary directory
4. 🔍 **Security Scan**: Analyzes downloaded files for compromised packages
5. 🧹 **Cleanup**: Automatically removes temporary files after processing

### **GitHub API Rate Limits:**
- **Without Token**: 60 requests/hour per IP
- **With Token**: 5,000 requests/hour per token
- **Recommendation**: Set `GITHUB_TOKEN` environment variable for production use

```bash
# Get GitHub token at: https://github.com/settings/tokens
export GITHUB_TOKEN=ghp_your_token_here
```

### **Light Scan vs Full Scan Comparison:**

| Feature | Light Scan | Full Scan |
|---------|------------|-----------|
| **Speed** | ⚡ Very Fast | 🐌 Slower |
| **Network Usage** | 📱 Minimal | 📡 Heavy |
| **Storage** | 💾 None | 💽 Full repos |
| **NPM Files Found** | ✅ All | ✅ All |
| **Dependency Tree** | ❌ No | ✅ Yes (with --full-tree) |
| **Best For** | Batch scanning | Deep analysis |

## Integration with Existing Scripts

You can integrate this with your existing quick-check script:

```bash
#!/bin/bash
# Enhanced quick check with Phoenix integration

# Run basic check first
./quick-check-compromised-packages-2025.sh "$1"

# If issues found, run detailed analysis with Phoenix
if [ $? -ne 0 ]; then
    echo "Issues detected, running detailed analysis with Phoenix integration..."
    python3 enhanced_npm_compromise_detector_phoenix.py "$1" --enable-phoenix --full-tree
fi

# For batch scanning, use light scan mode
if [ "$2" = "--batch" ]; then
    echo "Running light scan on repository list..."
    python3 enhanced_npm_compromise_detector_phoenix.py --repo-list "$1" --light-scan --enable-phoenix
fi
```
