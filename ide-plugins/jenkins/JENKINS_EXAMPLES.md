# 🚀 Jenkins Pipeline Examples for NPM Security Scanner

This document provides practical examples and use cases for integrating the NPM Security Scanner with Jenkins pipelines.

## 📋 Table of Contents

1. [Basic Examples](#basic-examples)
2. [Phoenix Integration Examples](#phoenix-integration-examples)
3. [Advanced Pipeline Examples](#advanced-pipeline-examples)
4. [Multi-Environment Examples](#multi-environment-examples)
5. [Integration Examples](#integration-examples)
6. [Troubleshooting Examples](#troubleshooting-examples)

---

## 🔰 Basic Examples

### Example 1: Simple Security Scan

```groovy
pipeline {
    agent any
    
    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
        
        stage('Install Dependencies') {
            steps {
                sh 'pip3 install --user requests configparser'
            }
        }
        
        stage('Security Scan') {
            steps {
                sh '''
                    chmod +x enhanced_npm_compromise_detector_phoenix.py
                    python3 enhanced_npm_compromise_detector_phoenix.py . --output security-report.txt
                '''
            }
        }
    }
    
    post {
        always {
            archiveArtifacts artifacts: 'security-report.txt', fingerprint: true
        }
    }
}
```

### Example 2: Parameterized Security Scan

```groovy
pipeline {
    agent any
    
    parameters {
        choice(
            name: 'SCAN_DEPTH',
            choices: ['quick', 'full'],
            description: 'Select scan depth'
        )
        string(
            name: 'TARGET_DIR',
            defaultValue: '.',
            description: 'Directory to scan'
        )
    }
    
    stages {
        stage('Security Analysis') {
            steps {
                script {
                    def scanCommand = "python3 enhanced_npm_compromise_detector_phoenix.py ${params.TARGET_DIR}"
                    
                    if (params.SCAN_DEPTH == 'full') {
                        scanCommand += " --full-tree"
                    }
                    
                    scanCommand += " --output scan-${params.SCAN_DEPTH}-${BUILD_NUMBER}.txt"
                    
                    sh scanCommand
                }
            }
        }
    }
    
    post {
        always {
            archiveArtifacts artifacts: 'scan-*.txt'
        }
    }
}
```

### Example 3: Conditional Security Scan

```groovy
pipeline {
    agent any
    
    stages {
        stage('Check for NPM Files') {
            steps {
                script {
                    def hasPackageJson = fileExists('package.json')
                    def hasPackageLock = fileExists('package-lock.json')
                    
                    if (hasPackageJson || hasPackageLock) {
                        env.RUN_NPM_SCAN = 'true'
                        echo '📦 NPM files detected - security scan will run'
                    } else {
                        env.RUN_NPM_SCAN = 'false'
                        echo '⚠️ No NPM files found - skipping security scan'
                    }
                }
            }
        }
        
        stage('NPM Security Scan') {
            when {
                environment name: 'RUN_NPM_SCAN', value: 'true'
            }
            steps {
                sh 'python3 enhanced_npm_compromise_detector_phoenix.py . --output npm-security-report.txt'
            }
        }
    }
}
```

---

## 🔗 Phoenix Integration Examples

### Example 4: Basic Phoenix Integration

```groovy
pipeline {
    agent any
    
    environment {
        PHOENIX_CLIENT_ID = credentials('phoenix-client-id')
        PHOENIX_CLIENT_SECRET = credentials('phoenix-client-secret')
        PHOENIX_API_URL = credentials('phoenix-api-url')
    }
    
    stages {
        stage('Configure Phoenix') {
            steps {
                sh '''
                    cat > .config << EOF
[phoenix]
client_id = ${PHOENIX_CLIENT_ID}
client_secret = ${PHOENIX_CLIENT_SECRET}
api_base_url = ${PHOENIX_API_URL}
assessment_name = Jenkins Security Scan - ${JOB_NAME} #${BUILD_NUMBER}
import_type = new
EOF
                '''
            }
        }
        
        stage('Security Scan with Phoenix') {
            steps {
                sh '''
                    python3 enhanced_npm_compromise_detector_phoenix.py . \\
                        --enable-phoenix \\
                        --output phoenix-security-report.txt \\
                        --debug
                '''
            }
        }
    }
    
    post {
        always {
            archiveArtifacts artifacts: 'phoenix-security-report.txt, debug/**'
        }
        cleanup {
            sh 'rm -f .config'
        }
    }
}
```

### Example 5: Phoenix Integration with Error Handling

```groovy
pipeline {
    agent any
    
    environment {
        PHOENIX_CLIENT_ID = credentials('phoenix-client-id')
        PHOENIX_CLIENT_SECRET = credentials('phoenix-client-secret')
        PHOENIX_API_URL = credentials('phoenix-api-url')
    }
    
    stages {
        stage('Phoenix Security Scan') {
            steps {
                script {
                    try {
                        sh '''
                            # Configure Phoenix
                            cat > .config << EOF
[phoenix]
client_id = ${PHOENIX_CLIENT_ID}
client_secret = ${PHOENIX_CLIENT_SECRET}
api_base_url = ${PHOENIX_API_URL}
assessment_name = Jenkins Scan - ${BUILD_NUMBER}
import_type = new
EOF
                            
                            # Run scan with Phoenix integration
                            python3 enhanced_npm_compromise_detector_phoenix.py . \\
                                --enable-phoenix \\
                                --output phoenix-report-${BUILD_NUMBER}.txt
                        '''
                        
                        echo '✅ Phoenix integration successful'
                        
                    } catch (Exception e) {
                        echo "⚠️ Phoenix integration failed: ${e.getMessage()}"
                        echo '🔄 Falling back to local scan...'
                        
                        sh '''
                            python3 enhanced_npm_compromise_detector_phoenix.py . \\
                                --output local-report-${BUILD_NUMBER}.txt
                        '''
                        
                        currentBuild.result = 'UNSTABLE'
                    }
                }
            }
        }
    }
}
```

### Example 6: Phoenix Integration with Validation

```groovy
pipeline {
    agent any
    
    stages {
        stage('Validate Phoenix Credentials') {
            steps {
                script {
                    withCredentials([
                        string(credentialsId: 'phoenix-client-id', variable: 'CLIENT_ID'),
                        string(credentialsId: 'phoenix-client-secret', variable: 'CLIENT_SECRET'),
                        string(credentialsId: 'phoenix-api-url', variable: 'API_URL')
                    ]) {
                        if (!CLIENT_ID || !CLIENT_SECRET || !API_URL) {
                            error('Phoenix credentials are not properly configured')
                        }
                        
                        // Test Phoenix API connectivity
                        def response = sh(
                            returnStatus: true,
                            script: """
                                curl -s -f -u "${CLIENT_ID}:${CLIENT_SECRET}" \\
                                "${API_URL}/v1/auth/access_token"
                            """
                        )
                        
                        if (response != 0) {
                            error('Failed to connect to Phoenix API')
                        }
                        
                        echo '✅ Phoenix API connectivity verified'
                    }
                }
            }
        }
        
        stage('Phoenix-Enabled Scan') {
            steps {
                withCredentials([
                    string(credentialsId: 'phoenix-client-id', variable: 'PHOENIX_CLIENT_ID'),
                    string(credentialsId: 'phoenix-client-secret', variable: 'PHOENIX_CLIENT_SECRET'),
                    string(credentialsId: 'phoenix-api-url', variable: 'PHOENIX_API_URL')
                ]) {
                    sh '''
                        cat > .config << EOF
[phoenix]
client_id = ${PHOENIX_CLIENT_ID}
client_secret = ${PHOENIX_CLIENT_SECRET}
api_base_url = ${PHOENIX_API_URL}
assessment_name = Validated Jenkins Scan - ${BUILD_NUMBER}
import_type = new
EOF
                        
                        python3 enhanced_npm_compromise_detector_phoenix.py . \\
                            --enable-phoenix \\
                            --output validated-phoenix-report.txt
                    '''
                }
            }
        }
    }
}
```

---

## 🔧 Advanced Pipeline Examples

### Example 7: Multi-Repository Light Scan

```groovy
pipeline {
    agent any
    
    parameters {
        text(
            name: 'REPO_LIST',
            defaultValue: '''https://github.com/facebook/react
https://github.com/vuejs/vue
https://github.com/angular/angular''',
            description: 'List of repositories to scan (one per line)'
        )
    }
    
    environment {
        GITHUB_TOKEN = credentials('github-token')
    }
    
    stages {
        stage('Prepare Repository List') {
            steps {
                script {
                    writeFile file: 'repo-list.txt', text: params.REPO_LIST
                    
                    def repoCount = params.REPO_LIST.split('\n').size()
                    echo "📋 Prepared ${repoCount} repositories for scanning"
                }
            }
        }
        
        stage('Light Scan External Repositories') {
            steps {
                sh '''
                    python3 enhanced_npm_compromise_detector_phoenix.py \\
                        --light-scan \\
                        --repo-list repo-list.txt \\
                        --output light-scan-external-${BUILD_NUMBER}.txt \\
                        --organize-folders
                '''
            }
        }
        
        stage('Process Results') {
            steps {
                script {
                    def reportFile = "light-scan-external-${BUILD_NUMBER}.txt"
                    
                    if (fileExists(reportFile)) {
                        def reportContent = readFile(reportFile)
                        
                        // Extract metrics
                        def criticalMatches = (reportContent =~ /CRITICAL: (\d+)/)
                        def criticalCount = criticalMatches ? criticalMatches[0][1] as Integer : 0
                        
                        echo "📊 Light scan completed: ${criticalCount} critical findings"
                        
                        if (criticalCount > 0) {
                            currentBuild.description = "⚠️ ${criticalCount} critical vulnerabilities found"
                        } else {
                            currentBuild.description = "✅ No critical vulnerabilities found"
                        }
                    }
                }
            }
        }
    }
    
    post {
        always {
            archiveArtifacts artifacts: 'light-scan-*.txt, result/**, github-pull/**'
        }
    }
}
```

### Example 8: Security Gate with Custom Thresholds

```groovy
pipeline {
    agent any
    
    parameters {
        string(name: 'CRITICAL_THRESHOLD', defaultValue: '0', description: 'Maximum allowed critical vulnerabilities')
        string(name: 'HIGH_THRESHOLD', defaultValue: '5', description: 'Maximum allowed high severity vulnerabilities')
    }
    
    stages {
        stage('Security Scan') {
            steps {
                sh '''
                    python3 enhanced_npm_compromise_detector_phoenix.py . \\
                        --output security-gate-report.txt
                '''
            }
        }
        
        stage('Security Gate') {
            steps {
                script {
                    def reportFile = 'security-gate-report.txt'
                    
                    if (!fileExists(reportFile)) {
                        error('Security report not found')
                    }
                    
                    def reportContent = readFile(reportFile)
                    
                    // Extract vulnerability counts
                    def criticalMatches = (reportContent =~ /CRITICAL: (\d+)/)
                    def highMatches = (reportContent =~ /HIGH: (\d+)/)
                    
                    def criticalCount = criticalMatches ? criticalMatches[0][1] as Integer : 0
                    def highCount = highMatches ? highMatches[0][1] as Integer : 0
                    
                    def criticalThreshold = params.CRITICAL_THRESHOLD as Integer
                    def highThreshold = params.HIGH_THRESHOLD as Integer
                    
                    echo "🔍 Security Gate Analysis:"
                    echo "   Critical: ${criticalCount} (threshold: ${criticalThreshold})"
                    echo "   High: ${highCount} (threshold: ${highThreshold})"
                    
                    def gateStatus = []
                    
                    if (criticalCount > criticalThreshold) {
                        gateStatus << "❌ CRITICAL: ${criticalCount} > ${criticalThreshold}"
                    } else {
                        gateStatus << "✅ Critical vulnerabilities within threshold"
                    }
                    
                    if (highCount > highThreshold) {
                        gateStatus << "⚠️ HIGH: ${highCount} > ${highThreshold}"
                        currentBuild.result = 'UNSTABLE'
                    } else {
                        gateStatus << "✅ High vulnerabilities within threshold"
                    }
                    
                    currentBuild.description = gateStatus.join(' | ')
                    
                    if (criticalCount > criticalThreshold) {
                        error("Security gate failed: Critical vulnerabilities exceed threshold")
                    }
                }
            }
        }
    }
}
```

### Example 9: Parallel Scanning Pipeline

```groovy
pipeline {
    agent any
    
    stages {
        stage('Parallel Security Scans') {
            parallel {
                stage('Current Repository Scan') {
                    steps {
                        sh '''
                            python3 enhanced_npm_compromise_detector_phoenix.py . \\
                                --output current-repo-scan.txt
                        '''
                    }
                }
                
                stage('Dependency Deep Scan') {
                    steps {
                        sh '''
                            python3 enhanced_npm_compromise_detector_phoenix.py . \\
                                --full-tree \\
                                --output deep-dependency-scan.txt
                        '''
                    }
                }
                
                stage('Light Scan External') {
                    when {
                        fileExists('external-repos.txt')
                    }
                    steps {
                        sh '''
                            python3 enhanced_npm_compromise_detector_phoenix.py \\
                                --light-scan \\
                                --repo-list external-repos.txt \\
                                --output external-light-scan.txt
                        '''
                    }
                }
            }
        }
        
        stage('Consolidate Results') {
            steps {
                script {
                    def reportFiles = ['current-repo-scan.txt', 'deep-dependency-scan.txt', 'external-light-scan.txt']
                    def consolidatedReport = "# Consolidated Security Report - Build #${BUILD_NUMBER}\n\n"
                    
                    reportFiles.each { file ->
                        if (fileExists(file)) {
                            consolidatedReport += "## ${file}\n"
                            consolidatedReport += readFile(file) + "\n\n"
                        }
                    }
                    
                    writeFile file: 'consolidated-security-report.txt', text: consolidatedReport
                }
            }
        }
    }
    
    post {
        always {
            archiveArtifacts artifacts: '*-scan.txt, consolidated-security-report.txt'
        }
    }
}
```

---

## 🌐 Multi-Environment Examples

### Example 10: Environment-Specific Scanning

```groovy
pipeline {
    agent any
    
    parameters {
        choice(
            name: 'ENVIRONMENT',
            choices: ['development', 'staging', 'production'],
            description: 'Target environment'
        )
    }
    
    stages {
        stage('Environment-Specific Security Scan') {
            steps {
                script {
                    def scanConfig = [:]
                    
                    switch(params.ENVIRONMENT) {
                        case 'development':
                            scanConfig.phoenixEnabled = false
                            scanConfig.failOnCritical = false
                            scanConfig.assessmentName = 'Dev Environment Scan'
                            break
                        case 'staging':
                            scanConfig.phoenixEnabled = true
                            scanConfig.failOnCritical = false
                            scanConfig.assessmentName = 'Staging Environment Scan'
                            break
                        case 'production':
                            scanConfig.phoenixEnabled = true
                            scanConfig.failOnCritical = true
                            scanConfig.assessmentName = 'Production Environment Scan'
                            break
                    }
                    
                    def scanCommand = "python3 enhanced_npm_compromise_detector_phoenix.py ."
                    
                    if (scanConfig.phoenixEnabled) {
                        withCredentials([
                            string(credentialsId: 'phoenix-client-id', variable: 'PHOENIX_CLIENT_ID'),
                            string(credentialsId: 'phoenix-client-secret', variable: 'PHOENIX_CLIENT_SECRET'),
                            string(credentialsId: 'phoenix-api-url', variable: 'PHOENIX_API_URL')
                        ]) {
                            sh """
                                cat > .config << EOF
[phoenix]
client_id = \${PHOENIX_CLIENT_ID}
client_secret = \${PHOENIX_CLIENT_SECRET}
api_base_url = \${PHOENIX_API_URL}
assessment_name = ${scanConfig.assessmentName} - Build ${BUILD_NUMBER}
import_type = new
EOF
                            """
                            scanCommand += " --enable-phoenix"
                        }
                    }
                    
                    scanCommand += " --output ${params.ENVIRONMENT}-security-report.txt"
                    
                    try {
                        sh scanCommand
                    } catch (Exception e) {
                        if (scanConfig.failOnCritical) {
                            throw e
                        } else {
                            currentBuild.result = 'UNSTABLE'
                            echo "⚠️ Scan completed with issues in ${params.ENVIRONMENT} environment"
                        }
                    }
                }
            }
        }
    }
}
```

### Example 11: Multi-Branch Security Pipeline

```groovy
pipeline {
    agent any
    
    stages {
        stage('Branch-Specific Configuration') {
            steps {
                script {
                    def branchConfig = [:]
                    
                    switch(env.BRANCH_NAME) {
                        case 'main':
                        case 'master':
                            branchConfig.scanType = 'comprehensive'
                            branchConfig.phoenixEnabled = true
                            branchConfig.failOnCritical = true
                            break
                        case 'develop':
                            branchConfig.scanType = 'enhanced'
                            branchConfig.phoenixEnabled = true
                            branchConfig.failOnCritical = false
                            break
                        default:
                            branchConfig.scanType = 'quick'
                            branchConfig.phoenixEnabled = false
                            branchConfig.failOnCritical = false
                    }
                    
                    env.SCAN_TYPE = branchConfig.scanType
                    env.PHOENIX_ENABLED = branchConfig.phoenixEnabled.toString()
                    env.FAIL_ON_CRITICAL = branchConfig.failOnCritical.toString()
                    
                    echo "🌿 Branch: ${env.BRANCH_NAME}"
                    echo "🔍 Scan Type: ${env.SCAN_TYPE}"
                    echo "🔗 Phoenix: ${env.PHOENIX_ENABLED}"
                    echo "🚨 Fail on Critical: ${env.FAIL_ON_CRITICAL}"
                }
            }
        }
        
        stage('Branch-Specific Security Scan') {
            steps {
                script {
                    def scanCommand = "python3 enhanced_npm_compromise_detector_phoenix.py ."
                    
                    if (env.SCAN_TYPE == 'comprehensive') {
                        scanCommand += " --full-tree"
                    }
                    
                    if (env.PHOENIX_ENABLED == 'true') {
                        withCredentials([
                            string(credentialsId: 'phoenix-client-id', variable: 'PHOENIX_CLIENT_ID'),
                            string(credentialsId: 'phoenix-client-secret', variable: 'PHOENIX_CLIENT_SECRET'),
                            string(credentialsId: 'phoenix-api-url', variable: 'PHOENIX_API_URL')
                        ]) {
                            sh '''
                                cat > .config << EOF
[phoenix]
client_id = ${PHOENIX_CLIENT_ID}
client_secret = ${PHOENIX_CLIENT_SECRET}
api_base_url = ${PHOENIX_API_URL}
assessment_name = Branch Scan - ${BRANCH_NAME} - Build ${BUILD_NUMBER}
import_type = new
EOF
                            '''
                            scanCommand += " --enable-phoenix"
                        }
                    }
                    
                    scanCommand += " --output ${env.BRANCH_NAME}-security-report.txt"
                    
                    try {
                        sh scanCommand
                    } catch (Exception e) {
                        if (env.FAIL_ON_CRITICAL == 'true') {
                            throw e
                        } else {
                            currentBuild.result = 'UNSTABLE'
                            echo "⚠️ Security scan completed with warnings on ${env.BRANCH_NAME}"
                        }
                    }
                }
            }
        }
    }
}
```

---

## 🔌 Integration Examples

### Example 12: Integration with SonarQube

```groovy
pipeline {
    agent any
    
    stages {
        stage('Code Quality & Security') {
            parallel {
                stage('SonarQube Analysis') {
                    steps {
                        withSonarQubeEnv('SonarQube') {
                            sh 'sonar-scanner'
                        }
                    }
                }
                
                stage('NPM Security Scan') {
                    steps {
                        sh '''
                            python3 enhanced_npm_compromise_detector_phoenix.py . \\
                                --output npm-security-sonar.txt
                        '''
                    }
                }
            }
        }
        
        stage('Quality Gate') {
            steps {
                script {
                    // Wait for SonarQube quality gate
                    timeout(time: 5, unit: 'MINUTES') {
                        def qg = waitForQualityGate()
                        if (qg.status != 'OK') {
                            echo "⚠️ SonarQube quality gate failed: ${qg.status}"
                            currentBuild.result = 'UNSTABLE'
                        }
                    }
                    
                    // Check NPM security results
                    if (fileExists('npm-security-sonar.txt')) {
                        def reportContent = readFile('npm-security-sonar.txt')
                        def criticalCount = (reportContent =~ /CRITICAL: (\d+)/)
                        
                        if (criticalCount && criticalCount[0][1] as Integer > 0) {
                            echo "⚠️ NPM security scan found critical vulnerabilities"
                            currentBuild.result = 'UNSTABLE'
                        }
                    }
                }
            }
        }
    }
}
```

### Example 13: Integration with Docker

```groovy
pipeline {
    agent any
    
    stages {
        stage('Build Docker Image') {
            steps {
                script {
                    docker.build("myapp:${BUILD_NUMBER}")
                }
            }
        }
        
        stage('Security Scan Docker Context') {
            steps {
                sh '''
                    # Scan the Docker build context
                    python3 enhanced_npm_compromise_detector_phoenix.py . \\
                        --output docker-context-security.txt
                    
                    # If Dockerfile copies package files, scan those too
                    if [ -f "app/package.json" ]; then
                        python3 enhanced_npm_compromise_detector_phoenix.py app/ \\
                            --output docker-app-security.txt
                    fi
                '''
            }
        }
        
        stage('Container Security Scan') {
            steps {
                script {
                    docker.image("myapp:${BUILD_NUMBER}").inside {
                        sh '''
                            # Scan inside the container
                            if [ -f "/app/package.json" ]; then
                                python3 enhanced_npm_compromise_detector_phoenix.py /app \\
                                    --output container-security.txt
                            fi
                        '''
                    }
                }
            }
        }
    }
    
    post {
        always {
            archiveArtifacts artifacts: '*security.txt'
        }
    }
}
```

### Example 14: Integration with Slack Notifications

```groovy
pipeline {
    agent any
    
    environment {
        SLACK_WEBHOOK_URL = credentials('slack-webhook-url')
    }
    
    stages {
        stage('Security Scan') {
            steps {
                sh '''
                    python3 enhanced_npm_compromise_detector_phoenix.py . \\
                        --output slack-security-report.txt
                '''
            }
        }
        
        stage('Parse Results') {
            steps {
                script {
                    def reportFile = 'slack-security-report.txt'
                    
                    if (fileExists(reportFile)) {
                        def reportContent = readFile(reportFile)
                        
                        // Extract metrics
                        def criticalMatches = (reportContent =~ /CRITICAL: (\d+)/)
                        def infoMatches = (reportContent =~ /INFO: (\d+)/)
                        
                        env.CRITICAL_COUNT = criticalMatches ? criticalMatches[0][1] : '0'
                        env.INFO_COUNT = infoMatches ? infoMatches[0][1] : '0'
                        
                        // Extract first few findings for summary
                        def findings = []
                        reportContent.eachLine { line ->
                            if (line.startsWith('1. [CRITICAL]') || line.startsWith('2. [CRITICAL]')) {
                                findings << line.replaceAll(/^\d+\. /, '')
                            }
                        }
                        env.TOP_FINDINGS = findings.take(3).join('\\n')
                    }
                }
            }
        }
    }
    
    post {
        always {
            script {
                def color = 'good'
                def emoji = '✅'
                def status = 'SUCCESS'
                
                if (env.CRITICAL_COUNT && env.CRITICAL_COUNT.toInteger() > 0) {
                    color = 'danger'
                    emoji = '🚨'
                    status = 'CRITICAL VULNERABILITIES FOUND'
                }
                
                def slackMessage = """
${emoji} NPM Security Scan Complete - Build #${BUILD_NUMBER}

*Repository:* ${env.JOB_NAME}
*Branch:* ${env.BRANCH_NAME ?: 'main'}
*Status:* ${status}
*Critical Vulnerabilities:* ${env.CRITICAL_COUNT ?: '0'}
*Safe Packages:* ${env.INFO_COUNT ?: '0'}

*Build URL:* ${env.BUILD_URL}
                """.stripIndent()
                
                if (env.TOP_FINDINGS) {
                    slackMessage += "\n*Top Critical Findings:*\n```${env.TOP_FINDINGS}```"
                }
                
                sh """
                    curl -X POST -H 'Content-type: application/json' \\
                    --data '{"text":"${slackMessage}","color":"${color}"}' \\
                    \${SLACK_WEBHOOK_URL}
                """
            }
        }
    }
}
```

---

## 🐛 Troubleshooting Examples

### Example 15: Diagnostic Pipeline

```groovy
pipeline {
    agent any
    
    stages {
        stage('Environment Diagnostics') {
            steps {
                sh '''
                    echo "=== System Information ==="
                    uname -a
                    
                    echo "=== Python Information ==="
                    python3 --version
                    pip3 --version
                    pip3 list | grep -E "(requests|configparser)" || echo "Required packages not found"
                    
                    echo "=== File Permissions ==="
                    ls -la enhanced_npm_compromise_detector_phoenix.py
                    
                    echo "=== NPM Files Detection ==="
                    find . -name "package*.json" -o -name "yarn.lock"
                    
                    echo "=== Git Information ==="
                    git --version
                    git remote -v || echo "No git remotes configured"
                '''
            }
        }
        
        stage('Credential Validation') {
            steps {
                script {
                    try {
                        withCredentials([
                            string(credentialsId: 'phoenix-client-id', variable: 'CLIENT_ID'),
                            string(credentialsId: 'phoenix-client-secret', variable: 'CLIENT_SECRET'),
                            string(credentialsId: 'phoenix-api-url', variable: 'API_URL')
                        ]) {
                            sh '''
                                echo "=== Phoenix Credentials Check ==="
                                echo "Client ID length: ${#CLIENT_ID}"
                                echo "Client Secret length: ${#CLIENT_SECRET}"
                                echo "API URL: ${API_URL}"
                                
                                echo "=== Phoenix API Connectivity ==="
                                curl -s -f -u "${CLIENT_ID}:${CLIENT_SECRET}" \\
                                    "${API_URL}/v1/auth/access_token" \\
                                    && echo "✅ Phoenix API connection successful" \\
                                    || echo "❌ Phoenix API connection failed"
                            '''
                        }
                    } catch (Exception e) {
                        echo "⚠️ Phoenix credentials not configured or invalid: ${e.getMessage()}"
                    }
                }
            }
        }
        
        stage('Test Security Scan') {
            steps {
                script {
                    try {
                        sh '''
                            echo "=== Running Test Security Scan ==="
                            python3 enhanced_npm_compromise_detector_phoenix.py . \\
                                --output diagnostic-test.txt \\
                                --debug
                            
                            echo "=== Scan Results ==="
                            if [ -f "diagnostic-test.txt" ]; then
                                head -20 diagnostic-test.txt
                                echo "✅ Security scan completed successfully"
                            else
                                echo "❌ Security scan failed - no output file generated"
                            fi
                            
                            echo "=== Debug Files ==="
                            ls -la debug/ 2>/dev/null || echo "No debug files generated"
                        '''
                    } catch (Exception e) {
                        echo "❌ Security scan failed: ${e.getMessage()}"
                        currentBuild.result = 'FAILURE'
                    }
                }
            }
        }
    }
    
    post {
        always {
            archiveArtifacts artifacts: 'diagnostic-test.txt, debug/**', allowEmptyArchive: true
        }
    }
}
```

### Example 16: Error Recovery Pipeline

```groovy
pipeline {
    agent any
    
    stages {
        stage('Primary Security Scan') {
            steps {
                script {
                    try {
                        sh '''
                            python3 enhanced_npm_compromise_detector_phoenix.py . \\
                                --enable-phoenix \\
                                --output primary-scan.txt
                        '''
                        env.SCAN_METHOD = 'phoenix'
                    } catch (Exception phoenixError) {
                        echo "⚠️ Phoenix scan failed: ${phoenixError.getMessage()}"
                        echo "🔄 Attempting fallback to local scan..."
                        
                        try {
                            sh '''
                                python3 enhanced_npm_compromise_detector_phoenix.py . \\
                                    --output fallback-scan.txt
                            '''
                            env.SCAN_METHOD = 'local'
                            currentBuild.result = 'UNSTABLE'
                        } catch (Exception localError) {
                            echo "❌ Local scan also failed: ${localError.getMessage()}"
                            echo "🔄 Attempting quick check as last resort..."
                            
                            sh '''
                                ./quick-check-compromised-packages-2025.sh . > quick-check.txt
                            '''
                            env.SCAN_METHOD = 'quick'
                            currentBuild.result = 'UNSTABLE'
                        }
                    }
                }
            }
        }
        
        stage('Results Processing') {
            steps {
                script {
                    echo "📊 Scan completed using: ${env.SCAN_METHOD}"
                    
                    def reportFile
                    switch(env.SCAN_METHOD) {
                        case 'phoenix':
                            reportFile = 'primary-scan.txt'
                            break
                        case 'local':
                            reportFile = 'fallback-scan.txt'
                            break
                        case 'quick':
                            reportFile = 'quick-check.txt'
                            break
                    }
                    
                    if (fileExists(reportFile)) {
                        def reportContent = readFile(reportFile)
                        echo "📋 Report summary (first 10 lines):"
                        echo reportContent.split('\n').take(10).join('\n')
                    }
                }
            }
        }
    }
    
    post {
        always {
            archiveArtifacts artifacts: '*-scan.txt, quick-check.txt', allowEmptyArchive: true
        }
        unstable {
            echo '⚠️ Build marked as unstable due to scan method fallback'
        }
    }
}
```

---

## 📚 Additional Resources

### Quick Reference Commands

```bash
# Basic scan
python3 enhanced_npm_compromise_detector_phoenix.py .

# Phoenix-enabled scan
python3 enhanced_npm_compromise_detector_phoenix.py . --enable-phoenix

# Light scan with repository list
python3 enhanced_npm_compromise_detector_phoenix.py --light-scan --repo-list repos.txt

# Debug mode
python3 enhanced_npm_compromise_detector_phoenix.py . --debug

# Organized output
python3 enhanced_npm_compromise_detector_phoenix.py . --organize-folders
```

### Common Pipeline Patterns

1. **Single Stage**: Basic security scan
2. **Multi-Stage**: Setup → Scan → Gate → Report
3. **Parallel**: Multiple scan types simultaneously
4. **Conditional**: Based on environment or branch
5. **Recovery**: Fallback mechanisms for failures

### Best Practices

- ✅ Always use credential binding for sensitive data
- ✅ Archive artifacts for debugging and compliance
- ✅ Implement proper error handling and fallbacks
- ✅ Use descriptive stage names and build descriptions
- ✅ Set appropriate build results (SUCCESS/UNSTABLE/FAILURE)
- ✅ Clean up temporary files and credentials
- ✅ Implement security gates based on vulnerability thresholds

---

**🎉 These examples should cover most Jenkins integration scenarios for the NPM Security Scanner!**

For additional customization or specific use cases, refer to the Jenkins Pipeline documentation and the main setup guide.
