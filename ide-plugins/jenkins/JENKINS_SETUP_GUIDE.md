# 🔧 Jenkins Setup Guide for NPM Security Scanner

## Overview

This guide provides comprehensive instructions for integrating the NPM Security Scanner with Jenkins CI/CD pipelines. The integration supports multiple pipeline types and includes Phoenix Security platform integration.

## 📋 Prerequisites

### Jenkins Requirements
- **Jenkins Version**: 2.400+ (LTS recommended)
- **Required Plugins**:
  - Pipeline Plugin (workflow-aggregator)
  - Credentials Plugin (credentials)
  - Git Plugin (git)
  - Pipeline: Stage View Plugin (pipeline-stage-view)
  - Blue Ocean (optional, for enhanced UI)

### System Requirements
- **Python 3.x** installed on Jenkins agents
- **pip3** for Python package management
- **Git** for source code management
- **curl** for webhook notifications (optional)

### Install Jenkins Plugins
1. Go to **Manage Jenkins** → **Manage Plugins** → **Available**
2. Search and install the required plugins
3. Restart Jenkins if prompted

## 🏗️ Pipeline Types Available

### 1. **Declarative Pipeline** (Recommended)
- **File**: `Jenkinsfile`
- **Features**: Full-featured with parameters, security gates, Phoenix integration
- **Best for**: Production environments, comprehensive scanning

### 2. **Simplified Declarative Pipeline**
- **File**: `Jenkinsfile.declarative`
- **Features**: Essential scanning with minimal configuration
- **Best for**: Quick setup, basic security scanning

### 3. **Scripted Pipeline** (Advanced)
- **File**: `Jenkinsfile.scripted`
- **Features**: Maximum flexibility, custom logic, advanced reporting
- **Best for**: Complex requirements, custom integrations

## 🔐 Credentials Configuration

### Step 1: Access Jenkins Credentials
1. Navigate to **Manage Jenkins** → **Manage Credentials**
2. Select **System** → **Global credentials (unrestricted)**
3. Click **Add Credentials**

### Step 2: Configure Required Credentials

#### Phoenix Security API Credentials

**1. Phoenix Client ID**
```
Kind: Secret text
ID: phoenix-client-id
Secret: [Your Phoenix Client ID]
Description: Phoenix Security API Client ID
```

**2. Phoenix Client Secret**
```
Kind: Secret text
ID: phoenix-client-secret
Secret: [Your Phoenix Client Secret]
Description: Phoenix Security API Client Secret
```

**3. Phoenix API URL**
```
Kind: Secret text
ID: phoenix-api-url
Secret: https://your-phoenix-domain.com/api
Description: Phoenix Security API Base URL
```

#### Optional Credentials

**4. GitHub Token**
```
Kind: Secret text
ID: github-token
Secret: [Your GitHub Personal Access Token]
Description: GitHub API token for higher rate limits
```

**5. Slack Webhook URL**
```
Kind: Secret text
ID: slack-webhook-url
Secret: [Your Slack Webhook URL]
Description: Slack notifications webhook
```

## 🚀 Creating Jenkins Jobs

### Method 1: Pipeline Job (Recommended)

1. **Create New Job**
   - Go to Jenkins Dashboard → **New Item**
   - Enter name: `npm-security-scan`
   - Select **Pipeline** → **OK**

2. **Configure Pipeline**
   - **Definition**: Pipeline script from SCM
   - **SCM**: Git
   - **Repository URL**: `https://github.com/your-org/your-repo.git`
   - **Script Path**: `ide-plugins/jenkins/Jenkinsfile`

3. **Build Triggers** (Optional)
   - **Poll SCM**: `H/15 * * * *` (every 15 minutes)
   - **GitHub hook trigger**: Enable if using GitHub webhooks

4. **Save Configuration**

### Method 2: Multibranch Pipeline

1. **Create Multibranch Pipeline**
   - New Item → **Multibranch Pipeline**
   - Name: `npm-security-multibranch`

2. **Branch Sources**
   - Add **Git** source
   - Repository URL: Your repository
   - Credentials: If required

3. **Build Configuration**
   - Script Path: `ide-plugins/jenkins/Jenkinsfile`

4. **Scan Multibranch Pipeline Triggers**
   - **Periodically if not otherwise run**: 1 day

## 🎛️ Pipeline Parameters

### Standard Parameters

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `SCAN_TYPE` | Choice | `enhanced` | Type of security scan |
| `TARGET_PATH` | String | `.` | Directory or file to scan |
| `REPO_LIST_FILE` | String | `` | Repository list file path |
| `ENABLE_PHOENIX` | Boolean | `false` | Enable Phoenix integration |
| `DEBUG_MODE` | Boolean | `false` | Enable debug mode |
| `ORGANIZE_FOLDERS` | Boolean | `true` | Organize results in folders |

### Scan Type Options

- **`quick`**: Fast security check
- **`enhanced`**: Comprehensive analysis
- **`light-scan`**: External repository scanning
- **`phoenix-integration`**: Full Phoenix integration

## 🔧 Pipeline Configuration Examples

### Basic Security Scan
```groovy
pipeline {
    agent any
    stages {
        stage('Security Scan') {
            steps {
                sh 'python3 enhanced_npm_compromise_detector_phoenix.py .'
            }
        }
    }
}
```

### Phoenix-Enabled Scan
```groovy
pipeline {
    agent any
    environment {
        PHOENIX_CLIENT_ID = credentials('phoenix-client-id')
        PHOENIX_CLIENT_SECRET = credentials('phoenix-client-secret')
        PHOENIX_API_URL = credentials('phoenix-api-url')
    }
    stages {
        stage('Security Scan') {
            steps {
                sh '''
                    cat > .config << EOF
[phoenix]
client_id = ${PHOENIX_CLIENT_ID}
client_secret = ${PHOENIX_CLIENT_SECRET}
api_base_url = ${PHOENIX_API_URL}
assessment_name = Jenkins Build ${BUILD_NUMBER}
import_type = new
EOF
                    python3 enhanced_npm_compromise_detector_phoenix.py . --enable-phoenix
                '''
            }
        }
    }
}
```

## 📊 Build Results and Artifacts

### Expected Artifacts
- **Security Reports**: `*security-report*.txt`
- **Debug Files**: `debug/phoenix_*.json` (if debug enabled)
- **Organized Results**: `result/YYYYMMDD/` folders
- **Build Summary**: `build-summary.md`

### Build Status Interpretation

| Status | Description | Action Required |
|--------|-------------|-----------------|
| **SUCCESS** | No critical vulnerabilities | None |
| **UNSTABLE** | Non-critical issues found | Review findings |
| **FAILURE** | Critical vulnerabilities or pipeline error | Immediate attention |

## 🔔 Notifications Setup

### Slack Integration

1. **Create Slack Webhook**
   - Go to Slack → Apps → Incoming Webhooks
   - Create webhook for your channel
   - Copy webhook URL

2. **Configure in Jenkins**
   - Add webhook URL as credential: `slack-webhook-url`
   - Pipeline will automatically use it if available

### Email Notifications

Add to pipeline post-build actions:
```groovy
post {
    always {
        emailext (
            subject: "NPM Security Scan - Build #${BUILD_NUMBER}",
            body: "Security scan completed. Check artifacts for details.",
            to: "security-team@company.com"
        )
    }
}
```

## 🐛 Troubleshooting

### Common Issues

#### Python/pip Issues
```bash
# Check Python version
python3 --version

# Install packages with full path
/usr/bin/pip3 install requests configparser

# Add to Jenkins PATH
export PATH="/usr/local/bin:$PATH"
```

#### Permission Issues
```bash
# Make scripts executable
chmod +x enhanced_npm_compromise_detector_phoenix.py
chmod +x *.sh

# Check Jenkins user permissions
ls -la enhanced_npm_compromise_detector_phoenix.py
```

#### Phoenix API Connection Issues
1. **Verify credentials** in Jenkins credential store
2. **Check API URL** format (no trailing slash)
3. **Enable debug mode** to see API requests
4. **Test connection** manually:
   ```bash
   curl -u "client_id:client_secret" "https://api.demo.appsecphx.io/v1/auth/access_token"
   ```

#### Git/SCM Issues
1. **Verify repository URL** and credentials
2. **Check branch configuration**
3. **Ensure Jenkins has repository access**
4. **Test git clone** manually on Jenkins agent

### Debug Mode

Enable debug mode for detailed troubleshooting:
```groovy
sh 'python3 enhanced_npm_compromise_detector_phoenix.py . --debug'
```

This creates debug files with:
- API request payloads
- API responses
- Detailed error messages

## 🔒 Security Best Practices

### Jenkins Security
- ✅ Use Jenkins credential store (never hardcode secrets)
- ✅ Limit job permissions to necessary users/groups
- ✅ Enable audit logging
- ✅ Regularly update Jenkins and plugins
- ✅ Use HTTPS for Jenkins access

### Pipeline Security
- ✅ Validate input parameters
- ✅ Sanitize file paths and commands
- ✅ Use secure credential binding
- ✅ Archive sensitive data securely
- ✅ Implement proper error handling

### Credential Management
- ✅ Rotate credentials regularly
- ✅ Use least privilege principle
- ✅ Monitor credential usage
- ✅ Secure credential storage
- ✅ Audit credential access

## 📈 Advanced Configuration

### Environment Variables

Set in job configuration → **Environment**:
```
SLACK_WEBHOOK_URL = ${SLACK_WEBHOOK_URL}
CRITICAL_THRESHOLD = 0
SCAN_TIMEOUT = 3600
```

### Build Parameters

Add parameterized builds for flexibility:
```groovy
parameters {
    choice(name: 'ENVIRONMENT', choices: ['dev', 'staging', 'prod'])
    string(name: 'BRANCH_NAME', defaultValue: 'main')
    booleanParam(name: 'SKIP_TESTS', defaultValue: false)
}
```

### Post-Build Actions

```groovy
post {
    always {
        archiveArtifacts artifacts: '**/*report*.txt, debug/**'
        publishHTML([
            allowMissing: false,
            alwaysLinkToLastBuild: true,
            keepAll: true,
            reportDir: 'result',
            reportFiles: '**/*.txt',
            reportName: 'Security Scan Report'
        ])
    }
    failure {
        script {
            def buildUrl = "${env.BUILD_URL}"
            slackSend(
                color: 'danger',
                message: "🚨 Security scan failed: ${buildUrl}"
            )
        }
    }
}
```

## 🎯 Integration Examples

### With SonarQube
```groovy
stage('SonarQube Analysis') {
    steps {
        withSonarQubeEnv('SonarQube') {
            sh 'sonar-scanner'
        }
    }
}
```

### With Artifactory
```groovy
stage('Publish Artifacts') {
    steps {
        rtUpload (
            serverId: 'artifactory',
            spec: '''{
                "files": [{
                    "pattern": "**/*report*.txt",
                    "target": "security-reports/"
                }]
            }'''
        )
    }
}
```

### With Kubernetes
```groovy
agent {
    kubernetes {
        yaml """
apiVersion: v1
kind: Pod
spec:
  containers:
  - name: python
    image: python:3.9
    command: ['cat']
    tty: true
        """
    }
}
```

## 📚 Additional Resources

### Documentation Files
- `JENKINS_EXAMPLES.md` - Practical examples and use cases
- `SECURITY_CREDENTIAL_GUIDE.md` - Credential management best practices
- `GITHUB_ACTIONS_SETUP.md` - GitHub Actions comparison

### Setup Scripts
- `jenkins-setup.sh` - Automated setup assistance
- `test-jenkins-integration.sh` - Integration testing

### Support
- Jenkins Documentation: https://www.jenkins.io/doc/
- Pipeline Syntax: https://www.jenkins.io/doc/book/pipeline/syntax/
- Plugin Documentation: https://plugins.jenkins.io/

---

**🎉 You're ready to integrate NPM security scanning with Jenkins!** 

For additional help or advanced configurations, refer to the example files and troubleshooting sections above.
