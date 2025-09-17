# Local Laptop Usage Demo - Complete Setup Guide

## 🎯 Complete Local Setup for Your Laptop

This demo shows you exactly how to set up and use the NPM compromise scanner on your laptop with embedded Phoenix credentials and folder scanning.

## 🚀 Step 1: Basic Setup

### Option A: Use Without Phoenix (Vanilla Mode)
```bash
# Just run it - works immediately, no setup needed
python3 enhanced_npm_compromise_detector_phoenix.py /path/to/your/project

# Example with your actual project
python3 enhanced_npm_compromise_detector_phoenix.py ~/Documents/GitHub/my-react-app
```

### Option B: Set Up Phoenix Integration (Recommended)
```bash
# 1. Edit the script to add your credentials
# Open enhanced_npm_compromise_detector_phoenix.py and find line ~67:

# Replace these placeholder values with your actual Phoenix credentials:
self.embedded_credentials = {
    'client_id': 'your_actual_phoenix_client_id_here',      # ← Replace this
    'client_secret': 'your_actual_phoenix_client_secret',   # ← Replace this
    'api_base_url': 'https://your-company.phoenix.com/api', # ← Replace this
    'assessment_name': 'NPM Compromise Detection - Local Laptop',
    'import_type': 'new'
}

# 2. Run with embedded credentials
python3 enhanced_npm_compromise_detector_phoenix.py /path/to/project --use-embedded-credentials --enable-phoenix
```

## 🗂️ Step 2: Create Your Project Lists

### Create Your Local Projects List
```bash
# Create a file with all your local projects
cat > ~/my_projects.txt << EOF
# My Development Projects
/Users/yourname/Documents/GitHub/frontend-app
/Users/yourname/Documents/GitHub/backend-api
/Users/yourname/Documents/GitHub/mobile-app

# Work Projects
/Users/yourname/work/client-project
/Users/yourname/work/internal-tools

# Personal Projects
/Users/yourname/personal/side-project
EOF
```

### Scan All Your Projects
```bash
# Scan all projects from list (vanilla mode)
python3 enhanced_npm_compromise_detector_phoenix.py --folder-list ~/my_projects.txt

# Scan with Phoenix integration
python3 enhanced_npm_compromise_detector_phoenix.py \
  --folder-list ~/my_projects.txt \
  --use-embedded-credentials \
  --enable-phoenix \
  --output "laptop_security_scan_$(date +%Y%m%d).txt"
```

## 🎯 Step 3: Daily Usage Workflows

### Quick Daily Check
```bash
#!/bin/bash
# Save as ~/bin/daily-security-check.sh

echo "🔍 Daily Security Check"
echo "====================="

# Check current project
python3 ~/path/to/enhanced_npm_compromise_detector_phoenix.py . --quiet

if [ $? -eq 0 ]; then
    echo "✅ Current project is clean"
else
    echo "🚨 Security issues found!"
    echo "Run full scan: python3 ~/path/to/enhanced_npm_compromise_detector_phoenix.py . --output issues.txt"
fi
```

### Weekly Comprehensive Scan
```bash
#!/bin/bash
# Save as ~/bin/weekly-security-scan.sh

echo "📊 Weekly Comprehensive Security Scan"
echo "===================================="

python3 ~/path/to/enhanced_npm_compromise_detector_phoenix.py \
  --folder-list ~/my_projects.txt \
  --use-embedded-credentials \
  --enable-phoenix \
  --full-tree \
  --output "weekly_scan_$(date +%Y%m%d).txt"

echo "📄 Report saved to weekly_scan_$(date +%Y%m%d).txt"
```

## 📋 Step 4: All Available Options

### Single Project Scanning
```bash
# Basic scan
python3 enhanced_npm_compromise_detector_phoenix.py ~/Documents/GitHub/my-project

# With Phoenix (embedded credentials)
python3 enhanced_npm_compromise_detector_phoenix.py ~/Documents/GitHub/my-project \
  --use-embedded-credentials --enable-phoenix

# Full analysis with report
python3 enhanced_npm_compromise_detector_phoenix.py ~/Documents/GitHub/my-project \
  --full-tree --output detailed-report.txt
```

### Multiple Project Scanning
```bash
# Scan specific folders directly
python3 enhanced_npm_compromise_detector_phoenix.py \
  --folders ~/project1 ~/project2 ~/project3

# Scan from folder list
python3 enhanced_npm_compromise_detector_phoenix.py \
  --folder-list ~/my_projects.txt

# Batch scan with Phoenix integration
python3 enhanced_npm_compromise_detector_phoenix.py \
  --folder-list ~/my_projects.txt \
  --use-embedded-credentials \
  --enable-phoenix \
  --output "batch_scan_$(date +%Y%m%d).txt"
```

### Environment Variables Alternative
```bash
# Set credentials as environment variables instead of editing script
export PHOENIX_CLIENT_ID="your_actual_client_id"
export PHOENIX_CLIENT_SECRET="your_actual_client_secret"
export PHOENIX_API_URL="https://your-company.phoenix.com/api"

# Run with environment variables
python3 enhanced_npm_compromise_detector_phoenix.py \
  --folder-list ~/my_projects.txt \
  --enable-phoenix
```

## 🔧 Step 5: Integration with Your Workflow

### Git Pre-Commit Hook
```bash
# Add to .git/hooks/pre-commit
#!/bin/bash
echo "🔍 Pre-commit security check..."
python3 ~/path/to/enhanced_npm_compromise_detector_phoenix.py . --quiet

if [ $? -ne 0 ]; then
    echo "🚨 Commit blocked: Compromised packages detected!"
    echo "Fix security issues before committing."
    exit 1
fi
```

### VS Code Task
```json
// Add to .vscode/tasks.json
{
    "version": "2.0.0",
    "tasks": [
        {
            "label": "NPM Security Check",
            "type": "shell",
            "command": "python3",
            "args": [
                "~/path/to/enhanced_npm_compromise_detector_phoenix.py",
                ".",
                "--quiet"
            ],
            "group": "test",
            "presentation": {
                "echo": true,
                "reveal": "always",
                "focus": false,
                "panel": "shared"
            }
        }
    ]
}
```

### Shell Alias
```bash
# Add to ~/.bashrc or ~/.zshrc
alias npm-security-check="python3 ~/path/to/enhanced_npm_compromise_detector_phoenix.py"
alias npm-security-scan="python3 ~/path/to/enhanced_npm_compromise_detector_phoenix.py --folder-list ~/my_projects.txt --use-embedded-credentials --enable-phoenix"

# Usage
npm-security-check .                    # Check current project
npm-security-scan                       # Scan all your projects
```

## 📊 Understanding Results

### Clean Project
```
✅ No critical or high priority findings detected

SUMMARY:
--------
Files scanned: 2
Packages analyzed: 45
Compromised packages: 0
Safe packages: 45
```

### Compromised Project
```
🚨 CRITICAL FINDINGS DETECTED!
  - Compromised package detected: @ctrl/tinycolor@4.1.2
    File: package.json
  - Compromised package detected: angulartics2@14.1.2
    File: package.json

IMMEDIATE ACTIONS:
1. Update @ctrl/tinycolor to version ^4.1.0
2. Update angulartics2 to version ^14.1.0
3. Run: npm install
4. Re-scan: npm-security-check .
```

## 🛠️ Troubleshooting

### Common Issues

**"No package.json found"**
```bash
# Make sure you're in the right directory
ls package.json  # Should exist
cd ~/Documents/GitHub/your-project
```

**"Phoenix authentication failed"**
```bash
# Check your embedded credentials in the script
# Or use vanilla mode:
python3 enhanced_npm_compromise_detector_phoenix.py .
```

**"Folder not found"**
```bash
# Update your project list with correct paths
vim ~/my_projects.txt
```

## 🎉 You're All Set!

Your local laptop is now configured for comprehensive NPM security scanning with these capabilities:

✅ **Embedded Phoenix credentials** for seamless integration  
✅ **Folder list scanning** for batch processing  
✅ **Direct folder specification** for quick scans  
✅ **Daily/weekly automation** with shell scripts  
✅ **Git integration** with pre-commit hooks  
✅ **IDE integration** with VS Code tasks  
✅ **Shell aliases** for quick access  

## 📚 Next Steps

1. **Edit the script** with your Phoenix credentials (line ~67)
2. **Create your project list** (`~/my_projects.txt`)
3. **Set up daily checks** (`daily-security-check.sh`)
4. **Add shell aliases** for convenience
5. **Test everything** with your actual projects

You now have enterprise-grade NPM security scanning running locally on your laptop! 🚀
