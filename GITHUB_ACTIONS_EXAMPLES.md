# GitHub Actions Examples for NPM Security Scanner

This document provides practical examples of how to use the NPM Security Scanner in different GitHub Actions scenarios.

## 🚀 Quick Start Examples

### 1. Basic Security Check on Pull Requests

```yaml
name: PR Security Check
on:
  pull_request:
    branches: [main]

jobs:
  security-check:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v4
    - name: Quick NPM Security Check
      run: |
        chmod +x quick-check-compromised-packages-2025.sh
        ./quick-check-compromised-packages-2025.sh .
```

### 2. Enhanced Analysis with Phoenix Integration

```yaml
name: Security Analysis with Phoenix
on:
  push:
    branches: [main]

jobs:
  phoenix-scan:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v4
    - uses: actions/setup-python@v4
      with:
        python-version: '3.11'
    
    - name: Install dependencies
      run: pip install requests configparser
    
    - name: Create Phoenix config
      run: |
        cat > .config << EOF
        [phoenix]
        client_id = ${{ secrets.PHOENIX_CLIENT_ID }}
        client_secret = ${{ secrets.PHOENIX_CLIENT_SECRET }}
        api_base_url = ${{ secrets.PHOENIX_API_URL }}
        assessment_name = ${{ github.repository }} Security Scan
        import_type = new
        EOF
    
    - name: Run security analysis
      run: |
        python3 enhanced_npm_compromise_detector_phoenix.py \
          . \
          --enable-phoenix \
          --output security-report.txt \
          --debug
    
    - name: Upload results
      uses: actions/upload-artifact@v4
      with:
        name: security-results
        path: |
          security-report.txt
          debug/
```

## 🏢 Enterprise Scenarios

### 3. Multi-Environment Security Pipeline

```yaml
name: Multi-Environment Security Scan
on:
  push:
    branches: [main, develop]

jobs:
  security-matrix:
    runs-on: ubuntu-latest
    strategy:
      matrix:
        environment: [frontend, backend, mobile, shared]
        scan-type: [quick, enhanced]
    
    steps:
    - uses: actions/checkout@v4
    - uses: actions/setup-python@v4
      with:
        python-version: '3.11'
    
    - name: Install dependencies
      run: |
        sudo apt-get install -y jq
        pip install requests configparser
    
    - name: Quick scan
      if: matrix.scan-type == 'quick'
      run: |
        chmod +x quick-check-compromised-packages-2025.sh
        ./quick-check-compromised-packages-2025.sh ${{ matrix.environment }}
    
    - name: Enhanced scan
      if: matrix.scan-type == 'enhanced'
      run: |
        python3 enhanced_npm_compromise_detector_phoenix.py \
          ${{ matrix.environment }} \
          --output ${{ matrix.environment }}-${{ matrix.scan-type }}-report.txt
    
    - name: Upload results
      uses: actions/upload-artifact@v4
      with:
        name: ${{ matrix.environment }}-${{ matrix.scan-type }}-results
        path: "*.txt"
```

### 4. Scheduled Organization-Wide Monitoring

```yaml
name: Organization Security Monitoring
on:
  schedule:
    - cron: '0 6 * * 1'  # Every Monday at 6 AM

jobs:
  org-wide-scan:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v4
    - uses: actions/setup-python@v4
      with:
        python-version: '3.11'
    
    - name: Install dependencies
      run: pip install requests configparser
    
    - name: Create repository list
      run: |
        cat > org_repos.txt << EOF
        https://github.com/${{ github.repository_owner }}/frontend-app
        https://github.com/${{ github.repository_owner }}/backend-api
        https://github.com/${{ github.repository_owner }}/mobile-app
        https://github.com/${{ github.repository_owner }}/shared-components
        EOF
    
    - name: Light scan all repositories
      env:
        GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
      run: |
        python3 enhanced_npm_compromise_detector_phoenix.py \
          --repo-list org_repos.txt \
          --light-scan \
          --enable-phoenix \
          --output org-security-report.txt \
          --organize-folders
    
    - name: Create security issue if problems found
      if: failure()
      uses: actions/github-script@v7
      with:
        script: |
          github.rest.issues.create({
            owner: context.repo.owner,
            repo: context.repo.repo,
            title: '🚨 Weekly Security Scan: Issues Detected',
            body: 'Critical security vulnerabilities detected in organization repositories. Check workflow artifacts for details.',
            labels: ['security', 'weekly-scan']
          })
```

## 🔄 CI/CD Integration Examples

### 5. Deployment Gate with Security Check

```yaml
name: Deploy with Security Gate
on:
  push:
    branches: [main]

jobs:
  security-gate:
    runs-on: ubuntu-latest
    outputs:
      security-passed: ${{ steps.security-check.outputs.passed }}
    
    steps:
    - uses: actions/checkout@v4
    - name: Security Check
      id: security-check
      run: |
        chmod +x enhanced-quick-check-with-phoenix.sh
        if ./enhanced-quick-check-with-phoenix.sh .; then
          echo "passed=true" >> $GITHUB_OUTPUT
        else
          echo "passed=false" >> $GITHUB_OUTPUT
        fi
    
    - name: Upload security results
      if: always()
      uses: actions/upload-artifact@v4
      with:
        name: security-gate-results
        path: "*.txt"

  deploy:
    needs: security-gate
    runs-on: ubuntu-latest
    if: needs.security-gate.outputs.security-passed == 'true'
    
    steps:
    - name: Deploy application
      run: echo "🚀 Deploying application (security checks passed)"
    
  security-alert:
    needs: security-gate
    runs-on: ubuntu-latest
    if: needs.security-gate.outputs.security-passed == 'false'
    
    steps:
    - name: Block deployment
      run: |
        echo "🚨 Deployment blocked due to security issues"
        exit 1
```

### 6. Phoenix Integration with Custom Assessment Names

```yaml
name: Phoenix Integration - Multiple Assessments
on:
  workflow_dispatch:
    inputs:
      environment:
        description: 'Environment to scan'
        required: true
        type: choice
        options: [dev, staging, prod]

jobs:
  phoenix-assessment:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v4
    - uses: actions/setup-python@v4
      with:
        python-version: '3.11'
    
    - name: Install dependencies
      run: pip install requests configparser
    
    - name: Create environment-specific Phoenix config
      run: |
        cat > .config << EOF
        [phoenix]
        client_id = ${{ secrets.PHOENIX_CLIENT_ID }}
        client_secret = ${{ secrets.PHOENIX_CLIENT_SECRET }}
        api_base_url = ${{ secrets.PHOENIX_API_URL }}
        assessment_name = ${{ github.repository }} - ${{ github.event.inputs.environment }} - $(date +%Y%m%d)
        import_type = new
        EOF
    
    - name: Run environment-specific scan
      run: |
        python3 enhanced_npm_compromise_detector_phoenix.py \
          ./${{ github.event.inputs.environment }} \
          --enable-phoenix \
          --output ${{ github.event.inputs.environment }}-phoenix-report.txt \
          --organize-folders \
          --debug
    
    - name: Comment on commit
      uses: actions/github-script@v7
      with:
        script: |
          github.rest.repos.createCommitComment({
            owner: context.repo.owner,
            repo: context.repo.repo,
            commit_sha: context.sha,
            body: `🛡️ Security scan completed for **${{ github.event.inputs.environment }}** environment. Results imported to Phoenix Security platform.`
          })
```

## 🔍 Advanced Scanning Examples

### 7. Custom Package List Monitoring

```yaml
name: Custom Package Monitoring
on:
  schedule:
    - cron: '0 12 * * *'  # Daily at noon

jobs:
  custom-monitoring:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v4
    - uses: actions/setup-python@v4
      with:
        python-version: '3.11'
    
    - name: Install dependencies
      run: pip install requests configparser
    
    - name: Create custom folder list
      run: |
        cat > monitored_folders.txt << EOF
        ./apps/web-frontend
        ./apps/mobile-app
        ./packages/shared-components
        ./services/api-gateway
        ./services/user-service
        EOF
    
    - name: Scan custom folders
      run: |
        python3 enhanced_npm_compromise_detector_phoenix.py \
          --folder-list monitored_folders.txt \
          --enable-phoenix \
          --output custom-monitoring-report.txt \
          --organize-folders
    
    - name: Process results
      run: |
        if grep -q "CRITICAL\|🚨" custom-monitoring-report.txt; then
          echo "CRITICAL_FOUND=true" >> $GITHUB_ENV
        fi
    
    - name: Send Slack alert
      if: env.CRITICAL_FOUND == 'true'
      uses: 8398a7/action-slack@v3
      with:
        status: failure
        text: |
          🚨 Critical NPM vulnerabilities detected in monitored packages!
          Repository: ${{ github.repository }}
          Check the workflow artifacts for detailed results.
      env:
        SLACK_WEBHOOK_URL: ${{ secrets.SLACK_WEBHOOK_URL }}
```

### 8. Light Scan with External Repository Monitoring

```yaml
name: External Repository Monitoring
on:
  workflow_dispatch:
    inputs:
      repos_to_scan:
        description: 'Comma-separated list of repositories to scan'
        required: true
        default: 'facebook/create-react-app,vuejs/vue'

jobs:
  external-scan:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v4
    - uses: actions/setup-python@v4
      with:
        python-version: '3.11'
    
    - name: Install dependencies
      run: pip install requests configparser
    
    - name: Create repository list
      run: |
        IFS=',' read -ra REPOS <<< "${{ github.event.inputs.repos_to_scan }}"
        for repo in "${REPOS[@]}"; do
          echo "https://github.com/$repo" >> external_repos.txt
        done
        
        echo "📋 Repositories to scan:"
        cat external_repos.txt
    
    - name: Light scan external repositories
      env:
        GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
      run: |
        python3 enhanced_npm_compromise_detector_phoenix.py \
          --repo-list external_repos.txt \
          --light-scan \
          --output external-scan-report.txt \
          --organize-folders
    
    - name: Generate summary
      run: |
        echo "## 🔍 External Repository Scan Results" >> $GITHUB_STEP_SUMMARY
        echo "### Scanned Repositories" >> $GITHUB_STEP_SUMMARY
        while read -r repo; do
          echo "- $repo" >> $GITHUB_STEP_SUMMARY
        done < external_repos.txt
        echo "" >> $GITHUB_STEP_SUMMARY
        
        if [ -f "external-scan-report.txt" ]; then
          echo "### Results Preview" >> $GITHUB_STEP_SUMMARY
          echo "\`\`\`" >> $GITHUB_STEP_SUMMARY
          head -20 external-scan-report.txt >> $GITHUB_STEP_SUMMARY
          echo "\`\`\`" >> $GITHUB_STEP_SUMMARY
        fi
```

## 🛠️ Utility Examples

### 9. Debug Mode with Detailed Logging

```yaml
name: Debug Security Scan
on:
  workflow_dispatch:

jobs:
  debug-scan:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v4
    - uses: actions/setup-python@v4
      with:
        python-version: '3.11'
    
    - name: Install dependencies
      run: |
        pip install requests configparser
        sudo apt-get install -y jq tree
    
    - name: Show environment info
      run: |
        echo "🔍 Environment Information:"
        echo "Python version: $(python3 --version)"
        echo "Pip packages:"
        pip list | grep -E "(requests|configparser)"
        echo "Available scripts:"
        ls -la *.py *.sh
        echo "Repository structure:"
        tree -L 2 -a
    
    - name: Run debug scan
      run: |
        python3 enhanced_npm_compromise_detector_phoenix.py \
          test_compromised_packages \
          --debug \
          --organize-folders \
          --output debug-scan-report.txt
    
    - name: Show debug information
      if: always()
      run: |
        echo "📊 Debug Information:"
        echo "===================="
        
        if [ -d "debug" ]; then
          echo "Debug files created:"
          ls -la debug/
          
          echo ""
          echo "Sample debug content:"
          for file in debug/*.json; do
            if [ -f "$file" ]; then
              echo "--- $file ---"
              head -10 "$file"
              echo ""
            fi
          done
        fi
        
        if [ -d "result" ]; then
          echo "Result files:"
          find result/ -type f -name "*.txt" -exec echo "- {}" \;
        fi
    
    - name: Upload debug artifacts
      if: always()
      uses: actions/upload-artifact@v4
      with:
        name: debug-scan-complete
        path: |
          debug/
          result/
          *.txt
          *.json
        retention-days: 14
```

### 10. Performance Comparison Test

```yaml
name: Performance Comparison
on:
  workflow_dispatch:

jobs:
  performance-test:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v4
    - uses: actions/setup-python@v4
      with:
        python-version: '3.11'
    
    - name: Install dependencies
      run: |
        pip install requests configparser
        sudo apt-get install -y jq time
    
    - name: Quick script performance
      run: |
        chmod +x quick-check-compromised-packages-2025.sh
        echo "⏱️ Quick Script Performance:"
        time ./quick-check-compromised-packages-2025.sh test_compromised_packages
    
    - name: Enhanced script performance
      run: |
        chmod +x enhanced-quick-check-with-phoenix.sh
        echo "⏱️ Enhanced Script Performance:"
        time ./enhanced-quick-check-with-phoenix.sh test_compromised_packages
    
    - name: Python detector performance
      run: |
        echo "⏱️ Python Detector Performance:"
        time python3 enhanced_npm_compromise_detector_phoenix.py \
          test_compromised_packages \
          --output python-performance-report.txt
    
    - name: Light scan performance
      env:
        GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
      run: |
        echo "https://github.com/Security-Phoenix-demo/Shai-Halud-tinycolour-compromise-verifier" > test_repo.txt
        echo "⏱️ Light Scan Performance:"
        time python3 enhanced_npm_compromise_detector_phoenix.py \
          --repo-list test_repo.txt \
          --light-scan \
          --output light-scan-performance-report.txt
    
    - name: Performance summary
      run: |
        echo "## ⏱️ Performance Test Results" >> $GITHUB_STEP_SUMMARY
        echo "All timing information is captured in the workflow logs above." >> $GITHUB_STEP_SUMMARY
        echo "" >> $GITHUB_STEP_SUMMARY
        echo "### Test Configuration" >> $GITHUB_STEP_SUMMARY
        echo "- **Runner**: ubuntu-latest" >> $GITHUB_STEP_SUMMARY
        echo "- **Python**: $(python3 --version)" >> $GITHUB_STEP_SUMMARY
        echo "- **Test Data**: test_compromised_packages/" >> $GITHUB_STEP_SUMMARY
```

## 🎯 Best Practices

### Repository Setup Checklist

- [ ] Copy workflow files to `.github/workflows/`
- [ ] Configure repository secrets for Phoenix integration
- [ ] Set up branch protection rules requiring security checks
- [ ] Test workflows with manual triggers first
- [ ] Configure notification channels (Slack, email, etc.)

### Security Considerations

- [ ] Use repository secrets for sensitive data
- [ ] Limit workflow permissions to minimum required
- [ ] Regularly rotate API keys and tokens
- [ ] Monitor workflow logs for sensitive data exposure
- [ ] Use dependabot for keeping actions up to date

### Performance Optimization

- [ ] Use light scan mode for external repositories
- [ ] Cache dependencies when possible
- [ ] Use matrix builds for parallel scanning
- [ ] Set appropriate timeouts for network operations
- [ ] Clean up artifacts after appropriate retention period

These examples provide a solid foundation for integrating the NPM Security Scanner into your GitHub Actions workflows. Customize them based on your specific requirements and security policies.
