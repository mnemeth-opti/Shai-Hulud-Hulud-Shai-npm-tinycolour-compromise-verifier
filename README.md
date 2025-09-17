# NPM Package Compromise Detection Tools - 2025 Extended Edition

## ⚡ Quick Start (30 seconds)

**🚨 SECURITY EMERGENCY? Run this immediately:**

```bash
# 1. Make scripts executable
chmod +x *.sh

# 2. Quick security check
./local-security-check.sh .

# 3. If compromised packages found, get detailed report
python3 npm_package_compromise_detector_2025.py . --full-tree --output emergency-report.txt
```

### **🎯 What Each Tool Does**

| Tool | Purpose | Speed | Use Case |
|------|---------|-------|----------|
| `./local-security-check.sh` | **Quick scanner with nice output** | ⚡ Fast | Daily checks, CI/CD |
| `./quick-check-compromised-packages-2025.sh` | **Core detection engine** | ⚡ Fast | Direct usage, automation |
| `python3 npm_package_compromise_detector_2025.py` | **Comprehensive analysis** | 🐌 Thorough | Security audits, reports |

### **📊 Understanding Results**

#### ✅ **Clean Project (Exit Code 0)**
```bash
$ ./local-security-check.sh .
✅ SCAN COMPLETE: No compromised packages detected
```

#### 🚨 **Compromised Project (Exit Code 1)**
```bash
$ ./local-security-check.sh .
🚨 CRITICAL: Compromised packages detected!

IMMEDIATE ACTIONS REQUIRED:
1. Stop all running applications immediately
2. Clear npm cache: npm cache clean --force
3. Remove node_modules: rm -rf node_modules
4. Remove lock files: rm package-lock.json yarn.lock
5. Update to safe versions and reinstall
```

---

## Overview

This repository contains comprehensive security tools to detect compromised NPM packages from the 2025 supply chain attack affecting multiple popular packages including `@ctrl/*`, `@nativescript-community/*`, and many others.

## ⚠️ Critical Security Alert

**IMMEDIATE ACTION REQUIRED** if any of these packages are detected in your project:

### Confirmed Compromised Packages with Specific Versions:
- `@ctrl/tinycolor@4.1.1, 4.1.2`
- `angulartics2@14.1.2`
- `@ctrl/deluge@7.2.2`
- `@ctrl/golang-template@1.4.3`
- `@ctrl/magnet-link@4.0.4`
- `@ctrl/ngx-codemirror@7.0.2`
- `@ctrl/ngx-csv@6.0.2`
- `@ctrl/ngx-emoji-mart@9.2.2`
- `@ctrl/ngx-rightclick@4.0.2`
- `@ctrl/qbittorrent@9.7.2`
- `@ctrl/react-adsense@2.0.2`
- `@ctrl/shared-torrent@6.3.2`
- `@ctrl/torrent-file@4.1.2`
- `@ctrl/transmission@7.3.1`
- `@ctrl/ts-base32@4.0.2`
- `encounter-playground@0.0.5`
- `json-rules-engine-simplified@0.2.4, 0.2.1`
- `koa2-swagger-ui@5.11.2, 5.11.1`
- `@nativescript-community/gesturehandler@2.0.35`
- `@nativescript-community/sentry@4.6.43`
- `@nativescript-community/text@1.6.13`
- `@nativescript-community/ui-collectionview@6.0.6`
- `@nativescript-community/ui-drawer@0.1.30`
- `@nativescript-community/ui-image@4.5.6`
- `@nativescript-community/ui-material-bottomsheet@7.2.72`
- `@nativescript-community/ui-material-core@7.2.76`
- `@nativescript-community/ui-material-core-tabs@7.2.76`
- `ngx-color@10.0.2`
- `ngx-toastr@19.0.2`
- `ngx-trend@8.0.1`
- `react-complaint-image@0.0.35`
- `react-jsonschema-form-conditionals@0.3.21`
- `react-jsonschema-form-extras@1.0.4`
- `rxnt-authentication@0.0.6`
- `rxnt-healthchecks-nestjs@1.0.5`
- `rxnt-kue@1.0.7`
- `swc-plugin-component-annotate@1.9.2`
- `ts-gaussian@3.0.6`

### Potentially Compromised Packages (any version):
- `@ahmedhfarag/ngx-perfect-scrollbar`
- `@ahmedhfarag/ngx-virtual-scroller`
- `@art-ws/*` (all packages)
- `@crowdstrike/*` (all packages)
- `@hestjs/*` (all packages)
- `@nativescript-community/arraybuffers`
- `@nativescript-community/perms`
- `@nativescript-community/sqlite`
- `@nativescript-community/typeorm`
- `@nativescript-community/ui-document-picker`

## 🚨 Emergency Response (If Compromised Packages Found)

**If the scan detects compromised packages, follow these steps immediately:**

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

## 🛠️ Detection Tools

### 1. **Local Security Check (Recommended)**

```bash
# Best option: Clean output with both shell and Python analysis
./local-security-check.sh .                    # Check current directory
./local-security-check.sh /path/to/project     # Check specific project
```

**Features:**
- ⚡ Fast execution with comprehensive coverage
- 🎨 Clean, readable output format
- 🔄 Runs both shell and Python scanners
- 📊 Clear summary with next steps

### 2. **Quick Shell Script (Direct Core Scanner)**

```bash
# Direct access to core detection engine
./quick-check-compromised-packages-2025.sh .                    # Check current directory
./quick-check-compromised-packages-2025.sh /path/to/project     # Check specific project
```

**Features:**
- ⚡ Fastest scanning of package.json and lock files
- 🎨 Color-coded output for easy identification
- 🗂️ NPM cache checking
- 📊 Summary report with actionable recommendations

### 3. **Comprehensive Python Scanner (Detailed Analysis)**

```bash
# No additional requirements needed - uses standard library
# Basic scan
python3 npm_package_compromise_detector_2025.py .

# Full dependency tree analysis (recommended for security audits)
python3 npm_package_compromise_detector_2025.py . --full-tree

# Save detailed report with timestamp
python3 npm_package_compromise_detector_2025.py . --full-tree \
  --output "security-report-$(date +%Y%m%d-%H%M).txt"

# Quiet mode (only critical/high severity findings)
python3 npm_package_compromise_detector_2025.py . --quiet

# Custom configuration file
python3 npm_package_compromise_detector_2025.py . --config custom-packages.json
```

**Advanced Features:**
- 🌳 Full dependency tree traversal (requires npm install first)
- 📋 Detailed package analysis and reporting
- 🔍 Source code scanning for malicious patterns
- 📊 Comprehensive statistics and safe version recommendations
- 🧬 Crypto-related keyword detection
- 🌐 Malicious URL detection

### 4. **Common Workflows**

```bash
# Daily development check
./local-security-check.sh .

# Pre-deployment security audit
python3 npm_package_compromise_detector_2025.py . --full-tree --output pre-deploy-security.txt

# Multiple projects scan
for project in ~/projects/*/; do
    echo "Scanning $project"
    ./local-security-check.sh "$project"
done

# CI/CD integration
./local-security-check.sh . || exit 1  # Fail build if compromised
```

## 📁 Repository Structure

```
├── local-security-check.sh                    # ⭐ Recommended: Clean runner script
├── quick-check-compromised-packages-2025.sh   # Fast shell script checker  
├── npm_package_compromise_detector_2025.py    # Comprehensive Python scanner
├── compromised_packages_2025.json             # Package compromise database
├── install-and-run.sh                         # One-liner installation script
├── test_sample/                                # Test data for validation
│   ├── package.json                           # Sample with compromised packages
│   └── suspicious_code.js                     # Sample with malicious patterns
├── test_deep_dependencies/                     # Deep dependency tree testing
│   ├── package.json                           # Complex dependency structure
│   └── package-lock.json                      # Lock file with nested compromised packages
├── .github/workflows/                          # GitHub Actions integration
│   └── npm-security-scan.yml                  # CI/CD workflow template
├── QUICK_START.md                              # Comprehensive usage guide
├── COMMAND_REFERENCE.md                        # Quick reference card
├── requirements.txt                            # Python dependencies (optional)
└── README.md                                  # This documentation
```

## 🚨 Immediate Response Actions

If compromised packages are detected:

### 1. **STOP IMMEDIATELY**
```bash
# Kill all running Node.js processes
pkill -f node
pkill -f npm
```

### 2. **Clean Environment**
```bash
# Clear npm cache
npm cache clean --force

# Remove node_modules and lock files
rm -rf node_modules
rm -f package-lock.json yarn.lock
```

### 3. **Update Package Versions**
Add these safe version overrides to your `package.json`:

```json
{
  "overrides": {
    "@ctrl/tinycolor": "4.0.0",
    "angulartics2": "14.1.1",
    "@ctrl/deluge": "7.2.1",
    "@ctrl/golang-template": "1.4.2",
    "@ctrl/magnet-link": "4.0.3",
    "@ctrl/ngx-codemirror": "7.0.1",
    "@ctrl/ngx-csv": "6.0.1",
    "@ctrl/ngx-emoji-mart": "9.2.1",
    "@ctrl/ngx-rightclick": "4.0.1",
    "@ctrl/qbittorrent": "9.7.1",
    "@ctrl/react-adsense": "2.0.1",
    "@ctrl/shared-torrent": "6.3.1",
    "@ctrl/torrent-file": "4.1.1",
    "@ctrl/transmission": "7.3.0",
    "@ctrl/ts-base32": "4.0.1",
    "encounter-playground": "0.0.4",
    "json-rules-engine-simplified": "0.2.0",
    "koa2-swagger-ui": "5.11.0",
    "@nativescript-community/gesturehandler": "2.0.34",
    "@nativescript-community/sentry": "4.6.42",
    "@nativescript-community/text": "1.6.12",
    "@nativescript-community/ui-collectionview": "6.0.5",
    "@nativescript-community/ui-drawer": "0.1.29",
    "@nativescript-community/ui-image": "4.5.5",
    "@nativescript-community/ui-material-bottomsheet": "7.2.71",
    "@nativescript-community/ui-material-core": "7.2.75",
    "@nativescript-community/ui-material-core-tabs": "7.2.75",
    "ngx-color": "10.0.1",
    "ngx-toastr": "19.0.1",
    "ngx-trend": "8.0.0",
    "react-complaint-image": "0.0.34",
    "react-jsonschema-form-conditionals": "0.3.20",
    "react-jsonschema-form-extras": "1.0.3",
    "rxnt-authentication": "0.0.5",
    "rxnt-healthchecks-nestjs": "1.0.4",
    "rxnt-kue": "1.0.6",
    "swc-plugin-component-annotate": "1.9.1",
    "ts-gaussian": "3.0.5"
  }
}
```

### 4. **Reinstall and Audit**
```bash
# Reinstall dependencies
npm install

# Run security audit
npm audit
npm audit fix

# Verify no compromised packages remain
./quick-check-compromised-packages-2025.sh .
```

### 5. **Security Assessment**
- Review application logs for suspicious network activity
- Check for unauthorized file modifications
- Monitor for unusual CPU/memory usage
- Scan for crypto wallet compromise if browser-based application
- Review recent deployments and rollback if necessary

## 🔧 Configuration

### Custom Package Database
You can modify `compromised_packages_2025.json` to add new compromised packages or update versions:

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

### Python Script Options
```bash
# Custom configuration file
python3 npm_package_compromise_detector_2025.py --config custom_packages.json

# Skip recursive directory scanning
python3 npm_package_compromise_detector_2025.py --no-recursive

# Enable full dependency tree analysis
python3 npm_package_compromise_detector_2025.py --full-tree
```

## 🧪 Testing & Validation

### **Quick Test (30 seconds)**

```bash
# Test with clean project
mkdir clean_test && echo '{"name":"test","version":"1.0.0","dependencies":{"lodash":"^4.17.21"}}' > clean_test/package.json
./local-security-check.sh clean_test
# Expected: ✅ No compromised packages detected

# Test with compromised packages
./local-security-check.sh test_sample
# Expected: 🚨 Multiple compromised packages detected
```

### **Comprehensive Testing**

```bash
# Test shell script with sample data
./quick-check-compromised-packages-2025.sh test_sample

# Test Python script with detailed output
python3 npm_package_compromise_detector_2025.py test_sample --output test_results.txt

# Test deep dependency analysis (requires npm install first)
cd test_deep_dependencies && npm install && cd ..
python3 npm_package_compromise_detector_2025.py test_deep_dependencies --full-tree
```

### **Expected Results:**
- **test_sample**: Should detect 5+ compromised packages and malicious patterns
- **test_deep_dependencies**: Should detect compromised packages in nested dependencies
- **clean_test**: Should show clean results with exit code 0

### **Performance Benchmarks:**
- Shell script: ~1-2 seconds for typical projects
- Python basic scan: ~3-5 seconds for typical projects  
- Python full-tree: ~10-30 seconds (requires npm install first)

## 📊 Sample Output

### Shell Script Output:
```
🚨 CRITICAL: Compromised package detected: @ctrl/tinycolor@4.1.2 in dependencies
🚨 CRITICAL: Compromised package detected: angulartics2@14.1.2 in dependencies
❌ Found 5 compromised package(s) in package.json

Status: ❌ COMPROMISED PACKAGES DETECTED
```

### Python Script Output:
```
[CRITICAL] Compromised package detected: @ctrl/tinycolor@4.1.2
[HIGH] Malicious URL detected: npmjs.help  
[MEDIUM] Crypto-related keywords detected: wallet, privatekey, crypto
[MEDIUM] Suspicious code patterns detected: 5 patterns

COMPROMISED PACKAGES FOUND: 5
POTENTIALLY COMPROMISED FOUND: 0
```

## 🔗 References

- **Attack Vector**: Supply chain compromise targeting popular packages
- **Impact**: Potential malicious code injection, data exfiltration, crypto wallet stealing
- **Severity**: CRITICAL
- **Date**: September 2025

## 🤝 Contributing

To add new compromised packages or improve detection:

1. Update `compromised_packages_2025.json` with new package data
2. Test with sample projects
3. Update documentation
4. Submit pull request with detailed description

## ⚖️ License

This security tool is provided as-is for protection against supply chain attacks. Use responsibly and ensure you have proper authorization before scanning systems.

## 🆘 Support

For urgent security incidents or questions:
- Create an issue in this repository
- Include scan results and affected package information
- Mark as urgent for critical security issues

## 📚 Quick Reference

### **🚀 Most Common Commands**
```bash
# Daily quick check
./local-security-check.sh .

# Before deployment
python3 npm_package_compromise_detector_2025.py . --full-tree --output pre-deploy-report.txt

# Emergency scan after security alert
python3 npm_package_compromise_detector_2025.py . --full-tree --output emergency-$(date +%Y%m%d).txt
```

### **📊 Exit Code Reference**
- `0` = ✅ Clean (no compromised packages)
- `1` = 🚨 Compromised packages detected (IMMEDIATE ACTION REQUIRED)
- `2` = ⚠️ Script error (check dependencies, file paths, permissions)

### **🚨 Emergency Checklist**
If you see compromised packages:
1. ⏹️ **STOP** - Don't ignore this
2. 🔍 **ANALYZE** - Run: `python3 npm_package_compromise_detector_2025.py . --full-tree --output emergency.txt`
3. 🧹 **CLEAN** - `npm cache clean --force && rm -rf node_modules`
4. 📋 **REVIEW** - Check `emergency.txt` for safe versions
5. 🔄 **UPDATE** - Modify package.json with safe versions
6. 🔧 **REINSTALL** - `npm install`
7. ✅ **VERIFY** - `./local-security-check.sh .`

### **💡 Pro Tips**
- Run `./local-security-check.sh .` every morning
- Add to your git pre-commit hooks
- Use `--full-tree` for comprehensive audits
- Save reports with timestamps for tracking
- Integrate into CI/CD for automated protection

### **📖 Additional Resources**
- 📘 **[QUICK_START.md](QUICK_START.md)** - Comprehensive usage guide with GitHub Actions
- 📄 **[COMMAND_REFERENCE.md](COMMAND_REFERENCE.md)** - Quick command reference card

---

**Remember**: Time is critical in supply chain attacks. Run these scans immediately and take action if compromised packages are detected.
