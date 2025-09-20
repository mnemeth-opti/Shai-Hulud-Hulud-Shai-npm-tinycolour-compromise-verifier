# GitHub Actions Setup Guide for NPM Security Scanner

This guide will help you set up automated NPM security scanning using GitHub Actions with your Shai Halud compromise detection tools.

## 🚀 Quick Setup

### 1. Copy the Workflow File

The workflow file has been created at `.github/workflows/npm-security-scan.yml`. This file contains multiple scanning jobs that will run automatically.

### 2. Configure Repository Secrets (Optional - for Phoenix Integration)

If you want to enable Phoenix Security integration, add these secrets to your repository:

1. Go to your GitHub repository
2. Navigate to **Settings** → **Secrets and variables** → **Actions**
3. Add the following repository secrets:

```
PHOENIX_CLIENT_ID=your_phoenix_client_id_here
PHOENIX_CLIENT_SECRET=your_phoenix_client_secret_here
PHOENIX_API_URL=https://api.demo.appsecphx.io
```

**Optional Slack Integration:**
```
SLACK_WEBHOOK_URL=https://hooks.slack.com/services/YOUR/SLACK/WEBHOOK
```

### 3. Enable GitHub Actions

1. Go to your repository's **Actions** tab
2. If actions are disabled, click **"I understand my workflows, go ahead and enable them"**
3. The workflow will now run automatically on pushes, PRs, and daily schedules

## 📋 Workflow Features

### Automatic Triggers

- **Push Events**: Runs on pushes to `main`, `master`, `develop` branches
- **Pull Requests**: Scans PRs before merging
- **Scheduled Scans**: Daily at 2 AM UTC
- **Manual Trigger**: Run on-demand with custom options

### Scan Types

#### 1. Quick Security Check (Default)
- Uses `quick-check-compromised-packages-2025.sh`
- Fast bash-based scanning
- Perfect for PR checks and quick validation

#### 2. Enhanced Security Analysis
- Uses `enhanced_npm_compromise_detector_phoenix.py`
- Comprehensive Python-based analysis
- Optional Phoenix Security integration
- Detailed reporting with debug information

#### 3. Light Scan
- GitHub API-based scanning (no cloning)
- Only downloads NPM files
- Perfect for external repository monitoring

#### 4. Phoenix Integration
- Pushes findings to Phoenix Security platform
- Creates assets and vulnerability findings
- Automated security management

### Security Gate

- **Fails the workflow** if critical vulnerabilities are detected
- **Blocks PRs** with security issues
- **Creates GitHub issues** for scheduled scans with problems
- **Sends notifications** via Slack (if configured)

## 🔧 Manual Workflow Execution

### Run a Quick Scan
```yaml
# Go to Actions tab → NPM Security Compromise Detection → Run workflow
Scan Type: quick
Target Path: . (default)
Enable Phoenix: false
```

### Run Enhanced Analysis with Phoenix
```yaml
Scan Type: phoenix-integration
Target Path: ./frontend (or specific path)
Enable Phoenix: true
```

### Run Light Scan
```yaml
Scan Type: light-scan
Target Path: . 
Enable Phoenix: false
```

## 📊 Understanding Results

### Workflow Artifacts

Each workflow run produces artifacts containing:

- **Security reports** (`.txt` files)
- **Debug information** (if Phoenix enabled)
- **Organized results** in timestamped folders
- **Raw scan data** (JSON files)

### Security Summary

The workflow creates a summary in the GitHub Actions interface showing:
- Scan configuration
- Number of packages scanned
- Critical/High/Info findings
- Phoenix integration status

### Pull Request Comments

When security issues are found in PRs, the workflow automatically:
- ❌ **Fails the PR check**
- 💬 **Adds a comment** alerting about security issues
- 📎 **Links to detailed results** in workflow artifacts

## 🔐 Security Best Practices

### Repository Secrets Management

```bash
# Set secrets using GitHub CLI
gh secret set PHOENIX_CLIENT_ID --body "your_client_id"
gh secret set PHOENIX_CLIENT_SECRET --body "your_client_secret" 
gh secret set PHOENIX_API_URL --body "https://api.demo.appsecphx.io"
```

### Branch Protection Rules

Add branch protection rules to enforce security scanning:

1. Go to **Settings** → **Branches**
2. Add rule for `main` branch
3. Enable **"Require status checks to pass before merging"**
4. Select **"Security Gate"** as required check

### Notification Setup

For Slack notifications, create a webhook:
1. Go to your Slack workspace
2. Create a new webhook app
3. Copy the webhook URL
4. Add as `SLACK_WEBHOOK_URL` secret

## 📈 Advanced Configuration

### Custom Scan Paths

Modify the workflow to scan specific directories:

```yaml
# In .github/workflows/npm-security-scan.yml
- name: Run enhanced analysis
  run: |
    python3 enhanced_npm_compromise_detector_phoenix.py \
      ./frontend \  # Custom path
      --enable-phoenix \
      --output "security-report.txt"
```

### Multiple Environment Scanning

```yaml
strategy:
  matrix:
    environment: [frontend, backend, mobile]
    
steps:
- name: Scan ${{ matrix.environment }}
  run: |
    python3 enhanced_npm_compromise_detector_phoenix.py \
      ./${{ matrix.environment }} \
      --output "${{ matrix.environment }}-security-report.txt"
```

### Custom Phoenix Configuration

```yaml
- name: Create custom Phoenix config
  run: |
    cat > .config << EOF
    [phoenix]
    client_id = ${{ secrets.PHOENIX_CLIENT_ID }}
    client_secret = ${{ secrets.PHOENIX_CLIENT_SECRET }}
    api_base_url = ${{ secrets.PHOENIX_API_URL }}
    assessment_name = ${{ github.repository }} - ${{ github.ref_name }}
    import_type = merge
    EOF
```

## 🐛 Troubleshooting

### Common Issues

#### 1. "Scripts not executable" Error
```yaml
# Add this step before running scripts
- name: Make scripts executable
  run: chmod +x *.sh
```

#### 2. "Python dependencies missing" Error
```yaml
# Ensure Python dependencies are installed
- name: Install dependencies
  run: |
    pip install requests configparser
```

#### 3. "Phoenix authentication failed" Error
- Verify secrets are correctly set
- Check Phoenix API URL format
- Ensure credentials have proper permissions

#### 4. "GitHub API rate limit" Error
- The workflow uses `GITHUB_TOKEN` automatically
- For external repos, consider setting a personal access token

### Debug Mode

Enable debug mode for troubleshooting:

```yaml
- name: Run with debug
  run: |
    python3 enhanced_npm_compromise_detector_phoenix.py \
      . \
      --enable-phoenix \
      --debug \
      --output "debug-report.txt"
```

Debug files will be saved to `debug/` folder in artifacts.

## 📚 Example Use Cases

### 1. Enterprise CI/CD Pipeline

```yaml
# Scan on every commit, block deployment if issues found
on:
  push:
    branches: [main]
  pull_request:
    branches: [main]
```

### 2. Scheduled Security Monitoring

```yaml
# Daily scans with automatic issue creation
schedule:
  - cron: '0 6 * * *'  # 6 AM daily
```

### 3. Multi-Repository Scanning

```yaml
# Light scan multiple repositories
- name: Scan external repos
  run: |
    echo "https://github.com/org/repo1" > repos.txt
    echo "https://github.com/org/repo2" >> repos.txt
    python3 enhanced_npm_compromise_detector_phoenix.py \
      --repo-list repos.txt \
      --light-scan
```

### 4. Security Dashboard Integration

```yaml
# Send results to multiple platforms
- name: Upload to Phoenix
  run: python3 enhanced_npm_compromise_detector_phoenix.py --enable-phoenix .

- name: Send to Slack
  uses: 8398a7/action-slack@v3
  with:
    status: ${{ job.status }}
```

## 🎯 Next Steps

1. **Test the workflow** with a manual run
2. **Configure Phoenix integration** if needed
3. **Set up branch protection rules** for security enforcement
4. **Add Slack notifications** for immediate alerts
5. **Customize scan schedules** based on your needs

## 📞 Support

For issues with the GitHub Actions setup:
- Check the **Actions** tab for detailed logs
- Review **workflow artifacts** for scan results
- Ensure all **repository secrets** are correctly configured
- Verify **script permissions** and dependencies

The workflow is designed to be robust and provide clear feedback on any issues encountered during scanning.
