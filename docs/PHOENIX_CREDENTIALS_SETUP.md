# Phoenix Security Credentials Setup Guide

## 🚨 Critical Setup Requirements

**⚠️  IMPORTANT**: The Phoenix integration requires YOUR actual credentials. All example values are placeholders that MUST be replaced.

## 📋 Step-by-Step Setup

### 1. Create Configuration File
```bash
# Generate the configuration template
python3 enhanced_npm_compromise_detector_phoenix.py --create-config

# Copy the example to create your configuration
cp .config.example .config
```

### 2. Replace Placeholder Values

Open `.config` file and replace ALL placeholder values:

#### ❌ **BEFORE (Example/Placeholder Values)**
```ini
[phoenix]
client_id = your_phoenix_client_id_here
client_secret = your_phoenix_client_secret_here
api_base_url = https://your-phoenix-domain.com/api
```

#### ✅ **AFTER (Your Actual Values)**
```ini
[phoenix]
client_id = abc123def456ghi789  # Your actual Phoenix client ID
client_secret = xyz987uvw654rst321  # Your actual Phoenix client secret
api_base_url = https://mycompany.securityphoenix.cloud/api  # Your actual Phoenix API endpoint
```

### 3. Get Your Phoenix Security Credentials

#### **From Phoenix Security Platform:**
1. **Log into** your Phoenix Security platform
2. **Navigate to** Organization → API Access
3. **Create new API credentials** if needed
4. **Copy** your client_id and client_secret
5. **Note** your API endpoint/domain

#### **Common API Endpoint Formats:**
- **Production**: `https://your-company.securityphoenix.cloud/api`
- **Demo Environment**: `https://your-company.demo.securityphoenix.cloud/api`
- **Enterprise**: `https://api.your-phoenix-domain.com`
- **On-Premise**: `https://phoenix.your-company.com/api`

### 4. Verify Your Configuration

```bash
# Test connection with your credentials
python3 enhanced_npm_compromise_detector_phoenix.py test_sample --enable-phoenix

# Should show:
# ✅ Phoenix API connection successful
# 🔗 Phoenix Integration: Enabled
```

## 🚫 Common Mistakes to Avoid

### ❌ **Don't Leave Placeholder Values**
```ini
# This will NOT work:
client_id = your_phoenix_client_id_here
client_secret = your_phoenix_client_secret_here
api_base_url = https://your-phoenix-domain.com/api
```

### ❌ **Don't Use Example Domains**
```ini
# These are just examples, replace with YOUR domain:
api_base_url = https://api.securityphoenix.cloud  # Generic example
api_base_url = https://your-phoenix-domain.com    # Placeholder example
```

### ❌ **Don't Forget File Extension**
```bash
# Wrong - keeping .example extension
.config.example

# Correct - rename to .config
.config
```

## 🔧 Environment Variables Alternative

Instead of `.config` file, you can use environment variables:

```bash
# Set your actual Phoenix credentials
export PHOENIX_CLIENT_ID="your_actual_client_id_here"
export PHOENIX_CLIENT_SECRET="your_actual_client_secret_here"
export PHOENIX_API_URL="https://your-actual-domain.com/api"

# Run with Phoenix integration
python3 enhanced_npm_compromise_detector_phoenix.py . --enable-phoenix
```

## 🔍 Troubleshooting

### **Error: "Phoenix configuration file .config not found"**
- **Solution**: Rename `.config.example` to `.config`

### **Error: "Authentication failed" or "401 Unauthorized"**
- **Solution**: Replace placeholder client_id and client_secret with your actual values

### **Error: "Connection failed" or "Cannot reach Phoenix API"**
- **Solution**: Replace `your-phoenix-domain.com` with your actual Phoenix domain

### **Error: "Invalid API endpoint"**
- **Solution**: Verify your API URL format (usually ends with `/api`)

## 📞 Getting Help

### **Need Phoenix Credentials?**
1. Contact your Phoenix Security administrator
2. Request API access in Phoenix Security platform
3. Check your organization's Phoenix documentation

### **Don't Have Phoenix Security?**
- The tools work without Phoenix integration
- Simply omit `--enable-phoenix` flag
- All security detection features work locally

## ✅ Verification Checklist

Before running Phoenix integration, verify:

- [ ] `.config` file exists (not `.config.example`)
- [ ] `client_id` is your actual Phoenix client ID (not placeholder)
- [ ] `client_secret` is your actual Phoenix client secret (not placeholder)
- [ ] `api_base_url` is your actual Phoenix domain (not placeholder)
- [ ] API endpoint format is correct (usually ends with `/api`)
- [ ] You can access your Phoenix Security platform in browser
- [ ] Test command runs without authentication errors

---

**Remember**: The integration requires YOUR actual Phoenix Security credentials. Placeholder values are just examples and will not work.
