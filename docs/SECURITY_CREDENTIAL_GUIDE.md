# 🔐 Security & Credential Management Guide

## ⚠️ **CRITICAL SECURITY WARNING**

**NEVER commit actual API keys, personal access tokens, or credentials to version control!**

This repository contains placeholder credentials and examples only. All real credentials must be replaced with your actual values and kept secure.

## 🛡️ **Credential Security Best Practices**

### **❌ What NOT to Do:**
- ❌ **Never** commit real API keys to Git repositories
- ❌ **Never** share credentials in documentation or guides  
- ❌ **Never** include credentials in screenshots or examples
- ❌ **Never** store credentials in plain text files that get committed
- ❌ **Never** use production credentials in test scripts

### **✅ What TO Do:**
- ✅ **Always** use placeholder values in documentation
- ✅ **Always** use GitHub repository secrets for CI/CD
- ✅ **Always** use environment variables for local development
- ✅ **Always** add `.config` files to `.gitignore`
- ✅ **Always** rotate credentials if accidentally exposed

## 🔧 **Secure Configuration Methods**

### **Method 1: GitHub Repository Secrets (Recommended for CI/CD)**
```yaml
# In GitHub Actions workflow
env:
  PHOENIX_CLIENT_ID: ${{ secrets.PHOENIX_CLIENT_ID }}
  PHOENIX_CLIENT_SECRET: ${{ secrets.PHOENIX_CLIENT_SECRET }}
  PHOENIX_API_URL: ${{ secrets.PHOENIX_API_URL }}
```

**Setup:**
1. Go to GitHub repository → Settings → Secrets and variables → Actions
2. Add secrets:
   - `PHOENIX_CLIENT_ID`: `your-actual-client-id`
   - `PHOENIX_CLIENT_SECRET`: `your-actual-client-secret`
   - `PHOENIX_API_URL`: `https://your-phoenix-domain.com/api`

### **Method 2: Environment Variables (Recommended for Local Development)**
```bash
# In your shell profile (.bashrc, .zshrc, etc.)
export PHOENIX_CLIENT_ID="your-actual-client-id"
export PHOENIX_CLIENT_SECRET="your-actual-client-secret"
export PHOENIX_API_URL="https://your-phoenix-domain.com/api"
```

### **Method 3: Local Configuration File (Use with Caution)**
```ini
# .config (ensure this file is in .gitignore!)
[phoenix]
client_id = your-actual-client-id
client_secret = your-actual-client-secret
api_base_url = https://your-phoenix-domain.com/api
assessment_name = NPM Compromise Detection - Local
import_type = new
```

**⚠️ Important:** Always add `.config` to your `.gitignore` file!

## 📋 **Placeholder Values Used in This Repository**

All documentation and examples in this repository use these **PLACEHOLDER** values:

```
PHOENIX_CLIENT_ID = your-phoenix-client-id-here
PHOENIX_CLIENT_SECRET = your-phoenix-client-secret-here  
PHOENIX_API_URL = https://your-phoenix-domain.com/api
GITHUB_TOKEN = your-github-token-here
```

**These are NOT real credentials and will NOT work!**

## 🔍 **Files That Contain Placeholder Credentials**

The following files contain placeholder credentials that you must replace:

- `.config.example` - Template configuration file
- `.config` - Local configuration (replace before use)
- `test-github-actions-phoenix.sh` - Test script (replace before running)
- Documentation files (for reference only)

## 🚨 **If Credentials Are Accidentally Exposed**

If you accidentally commit real credentials:

1. **Immediately rotate/revoke** the exposed credentials
2. **Remove the credentials** from the repository history:
   ```bash
   git filter-branch --force --index-filter \
   'git rm --cached --ignore-unmatch path/to/file' \
   --prune-empty --tag-name-filter cat -- --all
   ```
3. **Force push** the cleaned repository:
   ```bash
   git push --force --all
   ```
4. **Generate new credentials** from your Phoenix Security platform
5. **Update all systems** using the old credentials

## 🔒 **Credential Types & Security Levels**

### **Phoenix Security API Credentials:**
- **Client ID**: Identifies your application (less sensitive)
- **Client Secret**: Authenticates your application (highly sensitive)
- **API URL**: Your Phoenix instance endpoint (less sensitive)

### **GitHub Tokens:**
- **Personal Access Token**: Provides GitHub API access (highly sensitive)
- **Repository Token**: Automatic GitHub Actions token (managed by GitHub)

## 🎯 **Testing Without Real Credentials**

For testing purposes, you can:

1. **Use the vanilla mode** (no Phoenix integration):
   ```bash
   python3 enhanced_npm_compromise_detector_phoenix.py . --output report.txt
   ```

2. **Use mock/test credentials** in a separate test environment

3. **Use Phoenix demo/sandbox environment** if available

## 📝 **Documentation Guidelines**

When creating documentation:

- ✅ Use `your-credential-here` placeholders
- ✅ Use `https://your-domain.com` for URLs
- ✅ Include security warnings
- ✅ Explain where to get real credentials
- ❌ Never include actual credential values
- ❌ Never include working examples with real data

## 🛠️ **Verification Checklist**

Before committing changes, verify:

- [ ] No real API keys in any files
- [ ] No personal access tokens exposed
- [ ] All examples use placeholder values
- [ ] `.config` files are in `.gitignore`
- [ ] Security warnings are included in documentation
- [ ] Test scripts require credential replacement

## 📞 **Getting Help**

If you need help with credential setup:

1. **Phoenix Security Platform**: Contact your Phoenix administrator
2. **GitHub Secrets**: See [GitHub documentation](https://docs.github.com/en/actions/security-guides/encrypted-secrets)
3. **Environment Variables**: See your operating system documentation

---

**Remember: Security is everyone's responsibility. When in doubt, err on the side of caution!** 🛡️
