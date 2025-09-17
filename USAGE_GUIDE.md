# 🚀 Usage Guide - NPM Package Compromise Detection

## ❌ **The Error You Encountered**

```bash
curl -s https://github.com/Security-Phoenix-demo/Shai-Halud-tinycolour-compromise-verifier/install-and-run.sh | bash
# bash: line 1: Not: command not found
```

**Problem**: This URL returns HTML (GitHub's web interface) instead of the raw script content.

## ✅ **Working Solutions**

### **Option 1: Use Local Files (Recommended)**

You already have all the tools locally, so use them directly:

```bash
# Quick check (fastest)
./quick-check-compromised-packages-2025.sh .

# Check specific project
./quick-check-compromised-packages-2025.sh /path/to/your/project

# Use the local runner (with better output)
./local-security-check.sh .
./local-security-check.sh /path/to/your/project

# Comprehensive analysis
python3 npm_package_compromise_detector_2025.py . --full-tree
```

### **Option 2: Correct Raw GitHub URL Format**

If you publish this to GitHub, use the raw URL format:

```bash
# Correct format (replace with your actual repository):
curl -s https://raw.githubusercontent.com/Security-Phoenix-demo/Shai-Halud-tinycolour-compromise-verifier/main/local-security-check.sh | bash

# NOT this (returns HTML):
curl -s https://github.com/Security-Phoenix-demo/Shai-Halud-tinycolour-compromise-verifier/local-security-check.sh | bash
```

## 🎯 **Quick Start Commands**

### **For Your Current Setup:**

```bash
# 1. Make sure scripts are executable
chmod +x *.sh

# 2. Quick check current directory
./local-security-check.sh .

# 3. Check a specific project
./local-security-check.sh /path/to/your/project

# 4. Get detailed report
python3 npm_package_compromise_detector_2025.py . --full-tree --output security-report.txt
```

### **Test Results from Your System:**

✅ **Clean Project**: Exit code 0, green success messages
```bash
./local-security-check.sh clean_test
# ✅ SCAN COMPLETE: No compromised packages detected
```

🚨 **Compromised Project**: Exit code 1, red warning messages
```bash
./local-security-check.sh test_sample  
# 🚨 CRITICAL: Compromised packages detected!
# Found 5 compromised packages: @ctrl/tinycolor@4.1.2, angulartics2@14.1.2, etc.
```

## 📋 **GitHub Actions Setup**

If you want to use this in GitHub Actions, create `.github/workflows/security-scan.yml`:

```yaml
name: NPM Security Scan

on:
  push:
    branches: [ main ]
  pull_request:
    branches: [ main ]

jobs:
  security-scan:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v4
    
    - name: Install jq
      run: sudo apt-get update && sudo apt-get install -y jq
    
    - name: Run Security Scan
      run: ./local-security-check.sh .
```

## 🐳 **Docker Usage**

```bash
# Create a simple Dockerfile
cat > Dockerfile << 'EOF'
FROM ubuntu:latest
RUN apt-get update && apt-get install -y jq python3
WORKDIR /workspace
COPY *.sh *.py *.json ./
RUN chmod +x *.sh
ENTRYPOINT ["./local-security-check.sh"]
EOF

# Build and run
docker build -t npm-security-scanner .
docker run --rm -v $(pwd):/workspace npm-security-scanner .
```

## 🔧 **Troubleshooting**

### **Common Issues:**

1. **Permission Denied**
   ```bash
   chmod +x *.sh
   ```

2. **jq Command Not Found**
   ```bash
   # Ubuntu/Debian
   sudo apt-get install jq
   
   # macOS
   brew install jq
   ```

3. **Python Not Found**
   ```bash
   # Ubuntu/Debian
   sudo apt-get install python3
   
   # macOS (usually pre-installed)
   brew install python3
   ```

### **Verify Setup:**
```bash
# Check all prerequisites
which jq && echo "✅ jq OK" || echo "❌ jq missing"
which python3 && echo "✅ python3 OK" || echo "❌ python3 missing"
ls -la *.sh && echo "✅ scripts found" || echo "❌ scripts missing"
```

## 📊 **Understanding Results**

### **Exit Codes:**
- `0` = ✅ Clean (no compromised packages)
- `1` = 🚨 Compromised packages found
- `2` = ⚠️ Script error

### **Output Interpretation:**
- **Green ✅**: Safe, no action needed
- **Red 🚨**: CRITICAL - immediate action required
- **Yellow ⚠️**: Warnings or additional info

## 🚨 **Emergency Response**

If compromised packages are detected:

```bash
# 1. Stop applications
pkill -f node

# 2. Clean environment
npm cache clean --force
rm -rf node_modules
rm -f package-lock.json yarn.lock

# 3. Get detailed report
python3 npm_package_compromise_detector_2025.py . --full-tree --output emergency-report.txt

# 4. Review emergency-report.txt for safe versions
# 5. Update package.json with safe versions
# 6. Reinstall
npm install

# 7. Verify fix
./local-security-check.sh .
```

## 📞 **Quick Help**

| What You Want | Command |
|---------------|---------|
| Quick check current directory | `./local-security-check.sh .` |
| Check specific project | `./local-security-check.sh /path/to/project` |
| Detailed analysis | `python3 npm_package_compromise_detector_2025.py . --full-tree` |
| Save detailed report | `python3 npm_package_compromise_detector_2025.py . --output report.txt` |
| Check multiple projects | `for dir in proj1 proj2; do ./local-security-check.sh "$dir"; done` |

---

**✅ Your tools are working perfectly!** The local runner successfully detected compromised packages in the test sample and confirmed clean packages in the clean test.
