# NPM Package Compromise Detection Tools - 2025 Extended Edition

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

## 🛠️ Detection Tools

### 1. Quick Shell Script (Recommended for immediate checking)

```bash
# Make executable and run
chmod +x quick-check-compromised-packages-2025.sh
./quick-check-compromised-packages-2025.sh [directory]

# Examples:
./quick-check-compromised-packages-2025.sh .                    # Check current directory
./quick-check-compromised-packages-2025.sh /path/to/project     # Check specific project
```

**Features:**
- ⚡ Fast scanning of package.json and lock files
- 🎨 Color-coded output for easy identification
- 🗂️ NPM cache checking
- 📊 Summary report with actionable recommendations

### 2. Comprehensive Python Scanner (Detailed analysis)

```bash
# Install requirements (if needed)
pip3 install -r requirements.txt

# Basic scan
python3 npm_package_compromise_detector_2025.py [directory]

# Full dependency tree analysis (recommended)
python3 npm_package_compromise_detector_2025.py --full-tree [directory]

# Save report to file
python3 npm_package_compromise_detector_2025.py --output report.txt [directory]

# Quiet mode (only critical/high findings)
python3 npm_package_compromise_detector_2025.py --quiet [directory]
```

**Advanced Features:**
- 🌳 Full dependency tree traversal
- 📋 Detailed package analysis and reporting
- 🔍 Source code scanning for malicious patterns
- 📊 Comprehensive statistics and safe version recommendations
- 🧬 Crypto-related keyword detection
- 🌐 Malicious URL detection

## 📁 Repository Structure

```
├── npm_package_compromise_detector_2025.py    # Main Python detection script
├── quick-check-compromised-packages-2025.sh   # Fast shell script checker  
├── compromised_packages_2025.json             # Package compromise database
├── test_sample/                                # Test data for validation
│   ├── package.json                           # Sample with compromised packages
│   └── suspicious_code.js                     # Sample with malicious patterns
├── test_report.txt                            # Sample detailed report
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

## 🧪 Testing

Test the tools with the provided sample data:

```bash
# Test shell script
./quick-check-compromised-packages-2025.sh test_sample

# Test Python script  
python3 npm_package_compromise_detector_2025.py test_sample --output test_results.txt
```

Expected results: Both tools should detect 5 compromised packages and additional malicious patterns.

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

---

**Remember**: Time is critical in supply chain attacks. Run these scans immediately and take action if compromised packages are detected.
