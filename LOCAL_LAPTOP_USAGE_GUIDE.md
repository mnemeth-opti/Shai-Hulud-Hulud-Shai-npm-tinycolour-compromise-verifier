# Local Laptop Usage Guide - NPM Compromise Scanner

## 🖥️ Overview

This guide shows how to run the NPM compromise scanner locally on your laptop with embedded Phoenix credentials and scan multiple folders from a list.

## 🚀 Quick Start for Local Laptop Usage

### Option 1: Embedded Credentials (Recommended for Personal Use)

```bash
# 1. Edit the script with your Phoenix credentials embedded
# Open enhanced_npm_compromise_detector_phoenix.py and add your credentials

# 2. Scan local folders from a list
python3 enhanced_npm_compromise_detector_phoenix.py --folder-list my_projects.txt --enable-phoenix

# 3. Or scan specific folders directly
python3 enhanced_npm_compromise_detector_phoenix.py --folders /path/to/project1 /path/to/project2 --enable-phoenix
```

### Option 2: Vanilla Script (No Phoenix Integration)

```bash
# Use the original script without Phoenix integration
python3 npm_package_compromise_detector_2025.py /path/to/project

# Or use the quick shell script
./quick-check-compromised-packages-2025.sh /path/to/project
```

## 📁 Folder List Scanning

### Create a Project List File

Create a text file with your local project folders:

```bash
# Create projects list
cat > my_projects.txt << EOF
# My Local Projects - Comments start with #
/Users/yourname/Documents/GitHub/frontend-app
/Users/yourname/Documents/GitHub/backend-api
/Users/yourname/Documents/GitHub/mobile-app
/Users/yourname/projects/legacy-system
/Users/yourname/work/client-project
EOF
```

### Scan All Projects

```bash
# Scan all projects with Phoenix integration
python3 enhanced_npm_compromise_detector_phoenix.py --folder-list my_projects.txt --enable-phoenix

# Scan all projects without Phoenix (vanilla)
python3 enhanced_npm_compromise_detector_phoenix.py --folder-list my_projects.txt

# Generate detailed report
python3 enhanced_npm_compromise_detector_phoenix.py \
  --folder-list my_projects.txt \
  --enable-phoenix \
  --output "laptop_security_scan_$(date +%Y%m%d).txt"
```

## 🔐 Embedded Credentials Setup

### Method 1: Edit Script Directly (Personal Laptop)

Open `enhanced_npm_compromise_detector_phoenix.py` and find the credentials section:

```python
# Around line 70-80, add your credentials:
class EnhancedNPMCompromiseDetectorPhoenix:
    def __init__(self, config_file: str = None, phoenix_config_file: str = None):
        # ... existing code ...
        
        # 🔐 EMBEDDED CREDENTIALS FOR LOCAL LAPTOP USE
        # Replace with your actual Phoenix Security credentials
        self.embedded_credentials = {
            'client_id': 'your_actual_phoenix_client_id_here',
            'client_secret': 'your_actual_phoenix_client_secret_here', 
            'api_base_url': 'https://your-phoenix-domain.com/api',
            'assessment_name': 'NPM Compromise Detection - Local Laptop',
            'import_type': 'new'
        }
        self.use_embedded_credentials = True  # Set to False to use .config file
```

### Method 2: Environment Variables

```bash
# Set credentials as environment variables
export PHOENIX_CLIENT_ID="your_actual_client_id"
export PHOENIX_CLIENT_SECRET="your_actual_client_secret"
export PHOENIX_API_URL="https://your-phoenix-domain.com/api"

# Run with environment variables
python3 enhanced_npm_compromise_detector_phoenix.py --folders /path/to/project --enable-phoenix
```

## 📊 Local Scanning Workflows

### Daily Development Workflow

```bash
#!/bin/bash
# daily_security_check.sh - Add to your daily routine

echo "🔍 Daily NPM Security Check"
echo "=========================="

# Scan your active projects
python3 enhanced_npm_compromise_detector_phoenix.py \
  --folder-list ~/my_active_projects.txt \
  --enable-phoenix \
  --quiet \
  --output "daily_scan_$(date +%Y%m%d).txt"

echo "✅ Daily scan complete. Check daily_scan_$(date +%Y%m%d).txt for results."
```

### Weekly Comprehensive Scan

```bash
#!/bin/bash
# weekly_comprehensive_scan.sh

echo "🔍 Weekly Comprehensive NPM Security Scan"
echo "========================================"

# Scan all projects with full analysis
python3 enhanced_npm_compromise_detector_phoenix.py \
  --folder-list ~/all_projects.txt \
  --enable-phoenix \
  --full-tree \
  --output "weekly_comprehensive_$(date +%Y%m%d).txt"

echo "📊 Weekly scan complete with full dependency analysis."
```

### Project-Specific Scanning

```bash
# Scan specific project before deployment
python3 enhanced_npm_compromise_detector_phoenix.py \
  /Users/yourname/Documents/GitHub/critical-project \
  --enable-phoenix \
  --full-tree \
  --output "pre_deploy_security_check.txt"

# Quick check during development
./quick-check-compromised-packages-2025.sh /path/to/current/project
```

## 🛠️ Script Modifications for Local Use

### New Command Line Options Added

```bash
# Scan multiple folders directly
--folders /path/to/project1 /path/to/project2 /path/to/project3

# Scan folders from a list file  
--folder-list my_projects.txt

# Use embedded credentials (no .config file needed)
--use-embedded-credentials

# Combine with existing options
--enable-phoenix          # Enable Phoenix integration
--quiet                  # Only show critical findings
--full-tree              # Deep dependency analysis
--output report.txt      # Save detailed report
```

### Example Usage Combinations

```bash
# Local folders with embedded credentials
python3 enhanced_npm_compromise_detector_phoenix.py \
  --folders ~/project1 ~/project2 ~/project3 \
  --use-embedded-credentials \
  --enable-phoenix

# Folder list with quiet output
python3 enhanced_npm_compromise_detector_phoenix.py \
  --folder-list work_projects.txt \
  --quiet \
  --enable-phoenix

# Full analysis of local projects
python3 enhanced_npm_compromise_detector_phoenix.py \
  --folder-list all_projects.txt \
  --full-tree \
  --enable-phoenix \
  --output comprehensive_local_scan.txt
```

## 📂 Folder Structure for Local Use

```
~/Documents/GitHub/Shai-Halud-tinycolour-compromise-verifier/
├── enhanced_npm_compromise_detector_phoenix.py  # Main script with embedded credentials
├── my_projects.txt                              # Your project folders list
├── work_projects.txt                           # Work-related projects
├── personal_projects.txt                      # Personal projects
├── daily_security_check.sh                    # Daily scan script
├── weekly_comprehensive_scan.sh               # Weekly scan script
└── old/                                       # Archived older versions
    ├── npm_package_compromise_detector_2025.py  # Original vanilla script
    ├── enhanced_npm_compromise_detector_v1.py   # Previous version
    └── README_old_versions.md                   # Documentation for old versions
```

## 🔄 Vanilla Script Usage (No Phoenix)

### When to Use Vanilla Scripts

- **No Phoenix Security platform**: You don't have Phoenix Security access
- **Quick local checks**: Fast security checks during development
- **CI/CD integration**: Simple pass/fail security gates
- **Offline scanning**: No internet connection required

### Vanilla Script Options

```bash
# 1. Original comprehensive Python scanner
python3 npm_package_compromise_detector_2025.py /path/to/project
python3 npm_package_compromise_detector_2025.py /path/to/project --full-tree --output report.txt

# 2. Fast shell script scanner
./quick-check-compromised-packages-2025.sh /path/to/project

# 3. Local security check with nice output
./local-security-check.sh /path/to/project

# 4. Enhanced script without Phoenix
python3 enhanced_npm_compromise_detector_phoenix.py /path/to/project
# (Automatically falls back to local-only mode if no Phoenix config)
```

### Vanilla Script Features

- ✅ **Full compromise detection**: All 195+ compromised packages
- ✅ **Fast execution**: No network calls required
- ✅ **Comprehensive reporting**: Detailed local reports
- ✅ **Safe version recommendations**: Automatic safe version suggestions
- ✅ **Multiple output formats**: Console, file, JSON
- ❌ **No Phoenix integration**: No centralized asset management
- ❌ **No repository URL detection**: Local paths only

## 🚨 Security Best Practices for Local Use

### Credential Security

```bash
# ✅ Good: Use environment variables for shared machines
export PHOENIX_CLIENT_ID="your_id"
export PHOENIX_CLIENT_SECRET="your_secret"

# ✅ Good: Embedded credentials for personal laptop only
# Edit script directly for personal use

# ❌ Bad: Committing credentials to version control
# Never commit .config files with real credentials
```

### File Permissions

```bash
# Secure your configuration files
chmod 600 .config                    # Only you can read/write
chmod 600 my_projects.txt           # Protect project paths
chmod +x daily_security_check.sh    # Make scripts executable
```

### Regular Updates

```bash
# Keep compromise database updated
git pull origin main                 # Update the tool
# Check for new compromised packages regularly
```

## 📋 Local Project List Examples

### Development Projects
```
# ~/dev_projects.txt
/Users/yourname/Documents/GitHub/react-frontend
/Users/yourname/Documents/GitHub/node-backend
/Users/yourname/Documents/GitHub/express-api
/Users/yourname/Documents/GitHub/vue-dashboard
```

### Work Projects
```
# ~/work_projects.txt
/Users/yourname/work/client-portal
/Users/yourname/work/internal-tools
/Users/yourname/work/legacy-migration
/Users/yourname/work/microservices-api
```

### All Projects
```
# ~/all_projects.txt
# Development Projects
/Users/yourname/Documents/GitHub/react-frontend
/Users/yourname/Documents/GitHub/node-backend

# Work Projects  
/Users/yourname/work/client-portal
/Users/yourname/work/internal-tools

# Personal Projects
/Users/yourname/personal/side-project
/Users/yourname/personal/learning-project
```

## 🔧 Troubleshooting Local Usage

### Common Issues

**Error: "No package.json found"**
```bash
# Solution: Ensure folders contain NPM projects
ls /path/to/project/package.json  # Should exist
```

**Error: "Phoenix authentication failed"**
```bash
# Solution: Check embedded credentials or use vanilla mode
python3 enhanced_npm_compromise_detector_phoenix.py /path/to/project
# (Runs without Phoenix if credentials missing)
```

**Error: "Permission denied"**
```bash
# Solution: Check folder permissions
chmod +r /path/to/project/package.json
```

### Performance Tips

```bash
# For faster local scanning:
--quiet                    # Reduce output
--folder-list projects.txt # Batch multiple projects
# Skip --full-tree for quick checks
```

## 📈 Local Scanning Results

### Understanding Local Reports

```
📊 LOCAL LAPTOP SCAN RESULTS
============================
Folders scanned: 5
Projects with NPM: 4
Compromised packages found: 2
Safe packages identified: 127

🚨 CRITICAL FINDINGS:
- /Users/you/project1: @ctrl/tinycolor@4.1.2 (COMPROMISED)
- /Users/you/project2: angulartics2@14.1.2 (COMPROMISED)

✅ CLEAN PROJECTS:
- /Users/you/project3: No issues found
- /Users/you/project4: No issues found
```

This guide provides everything you need to run the NPM compromise scanner locally on your laptop with embedded credentials and folder list scanning capabilities!
