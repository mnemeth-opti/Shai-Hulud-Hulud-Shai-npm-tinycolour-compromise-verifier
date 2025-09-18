# Organized Folders Guide - GitHub Pulls & Results Structure

## 🗂️ Overview

The enhanced NPM compromise detector now supports organized folder structure for GitHub repository pulls and scan results, making it perfect for systematic security monitoring and audit trails.

## 📁 Folder Structure

When using `--organize-folders`, the tool creates a clean, date-organized structure:

```
project-root/
├── github-pull/
│   └── YYYYMMDD/          # Daily folder (e.g., 20250917)
│       ├── repo1/         # Each repository gets its own folder
│       │   ├── package.json
│       │   └── package-lock.json
│       ├── repo2/
│       │   ├── package.json
│       │   └── yarn.lock
│       └── repo3/
│           └── package.json
└── result/
    └── YYYYMMDD/          # Daily folder (e.g., 20250917)
        ├── security_scan_report.txt
        ├── phoenix_import_log.txt
        └── batch_analysis.txt
```

## 🚀 Usage Commands

### **Basic Organized GitHub Scan**
```bash
# Scan GitHub repositories with organized folders
python3 enhanced_npm_compromise_detector_phoenix.py \
  --repo-list github_repos.txt \
  --light-scan \
  --organize-folders \
  --output security_scan.txt
```

### **Daily Security Monitoring**
```bash
# Daily scan with automatic organization
python3 enhanced_npm_compromise_detector_phoenix.py \
  --repo-list my_github_repos.txt \
  --light-scan \
  --organize-folders \
  --enable-phoenix \
  --output "daily_scan_$(date +%H%M).txt"
```

### **Enterprise Batch Processing**
```bash
# Process multiple organization repositories
export GITHUB_TOKEN=your_github_token_here

python3 enhanced_npm_compromise_detector_phoenix.py \
  --repo-list enterprise_repos.txt \
  --light-scan \
  --organize-folders \
  --use-embedded-credentials \
  --enable-phoenix \
  --output "enterprise_security_audit.txt"
```

## 📋 Create Repository Lists

### **Personal GitHub Repositories**
```bash
cat > personal_repos.txt << EOF
https://github.com/yourusername/frontend-app
https://github.com/yourusername/backend-api
https://github.com/yourusername/mobile-app
https://github.com/yourusername/portfolio-site
EOF
```

### **Organization Repositories**
```bash
# Generate automatically with GitHub API
export GITHUB_TOKEN=your_github_token_here

curl -H "Authorization: token $GITHUB_TOKEN" \
     "https://api.github.com/orgs/your-org/repos?per_page=100&type=all" | \
     jq -r '.[].clone_url' > org_repos.txt
```

### **Mixed Repository List**
```bash
cat > mixed_repos.txt << EOF
# Personal projects
https://github.com/yourusername/personal-project

# Work projects  
https://github.com/company/frontend
https://github.com/company/backend

# Open source contributions
https://github.com/opensource-org/project
EOF
```

## 🎯 Benefits of Organized Folders

### **1. Audit Trail**
- **Daily organization**: Each day gets its own folder
- **Persistent storage**: GitHub pulls are preserved for analysis
- **Historical tracking**: Compare security posture over time

### **2. Efficient Storage**
- **Selective downloads**: Only NPM files, not entire repositories
- **Organized structure**: Easy to find specific repository files
- **No duplicates**: Each repository in its own folder

### **3. Compliance & Reporting**
- **Timestamped results**: All reports organized by date
- **Traceable scans**: Know exactly what was scanned when
- **Archive ready**: Perfect for compliance audits

### **4. Team Collaboration**
- **Shared structure**: Team members can easily navigate results
- **Consistent organization**: Same structure across all scans
- **Easy integration**: Works with existing CI/CD processes

## 📊 Workflow Examples

### **Daily Security Routine**
```bash
#!/bin/bash
# daily_security_scan.sh

echo "🔍 Daily Security Scan - $(date)"
echo "================================"

# Scan personal repositories
python3 enhanced_npm_compromise_detector_phoenix.py \
  --repo-list ~/personal_repos.txt \
  --light-scan \
  --organize-folders \
  --output "personal_scan.txt"

# Scan work repositories
python3 enhanced_npm_compromise_detector_phoenix.py \
  --repo-list ~/work_repos.txt \
  --light-scan \
  --organize-folders \
  --use-embedded-credentials \
  --enable-phoenix \
  --output "work_scan.txt"

echo "✅ Daily scan complete"
echo "📁 Results saved to: result/$(date +%Y%m%d)/"
```

### **Weekly Comprehensive Audit**
```bash
#!/bin/bash
# weekly_audit.sh

echo "📊 Weekly Security Audit - $(date)"
echo "=================================="

# Comprehensive scan with full reporting
python3 enhanced_npm_compromise_detector_phoenix.py \
  --repo-list ~/all_repos.txt \
  --light-scan \
  --organize-folders \
  --use-embedded-credentials \
  --enable-phoenix \
  --output "weekly_comprehensive_audit.txt"

# Archive previous week's data
LAST_WEEK=$(date -d '7 days ago' +%Y%m%d)
if [ -d "github-pull/$LAST_WEEK" ]; then
    tar -czf "archive/github-pull-$LAST_WEEK.tar.gz" "github-pull/$LAST_WEEK"
    echo "📦 Archived: github-pull-$LAST_WEEK.tar.gz"
fi
```

### **Enterprise Monitoring**
```bash
#!/bin/bash
# enterprise_monitor.sh

# Set up environment
export GITHUB_TOKEN=$ENTERPRISE_GITHUB_TOKEN
TIMESTAMP=$(date +%Y%m%d_%H%M)

# Scan all organization repositories
python3 enhanced_npm_compromise_detector_phoenix.py \
  --repo-list enterprise_repos.txt \
  --light-scan \
  --organize-folders \
  --use-embedded-credentials \
  --enable-phoenix \
  --output "enterprise_scan_$TIMESTAMP.txt"

# Generate summary report
echo "📈 Enterprise Security Summary - $(date)" > "result/$(date +%Y%m%d)/summary.txt"
echo "Repositories scanned: $(wc -l < enterprise_repos.txt)" >> "result/$(date +%Y%m%d)/summary.txt"
echo "Files downloaded: $(find github-pull/$(date +%Y%m%d) -name '*.json' | wc -l)" >> "result/$(date +%Y%m%d)/summary.txt"
```

## 🔧 Advanced Configuration

### **Custom Folder Structure**
If you need custom folder names, you can modify the script variables:
- `self.github_pull_dir` - Controls GitHub pulls folder
- `self.result_dir` - Controls results folder
- `self.timestamp` - Controls date format

### **Integration with CI/CD**
```yaml
# .github/workflows/security-scan.yml
name: Daily Security Scan
on:
  schedule:
    - cron: '0 2 * * *'  # Daily at 2 AM

jobs:
  security-scan:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      
      - name: Run Organized Security Scan
        env:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
          PHOENIX_CLIENT_ID: ${{ secrets.PHOENIX_CLIENT_ID }}
          PHOENIX_CLIENT_SECRET: ${{ secrets.PHOENIX_CLIENT_SECRET }}
        run: |
          python3 enhanced_npm_compromise_detector_phoenix.py \
            --repo-list .github/repo_list.txt \
            --light-scan \
            --organize-folders \
            --enable-phoenix \
            --output "automated_scan.txt"
      
      - name: Archive Results
        uses: actions/upload-artifact@v3
        with:
          name: security-scan-results
          path: result/
```

## 📂 Folder Management

### **Cleanup Old Data**
```bash
# Remove GitHub pulls older than 30 days
find github-pull/ -type d -name "202*" -mtime +30 -exec rm -rf {} \;

# Archive old results
find result/ -type d -name "202*" -mtime +7 -exec tar -czf archive/{}.tar.gz {} \; -exec rm -rf {} \;
```

### **Disk Space Monitoring**
```bash
# Check folder sizes
du -sh github-pull/ result/

# List largest repositories
du -sh github-pull/$(date +%Y%m%d)/* | sort -hr | head -10
```

## 🎉 Getting Started

1. **Enable organized folders**: Add `--organize-folders` to your command
2. **Create repository list**: List your GitHub repositories in a text file
3. **Run organized scan**: Execute the command with light scan mode
4. **Check results**: Find downloaded files in `github-pull/YYYYMMDD/` and reports in `result/YYYYMMDD/`

The organized folder structure makes your security scanning systematic, traceable, and perfect for enterprise environments! 🗂️✨
