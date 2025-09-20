# 🔌 IDE & CI/CD Platform Integrations

This directory contains integrations for various IDEs and CI/CD platforms to seamlessly incorporate NPM security scanning into your development workflow.

## 📁 Directory Structure

```
ide-plugins/
├── jenkins/                    # Jenkins CI/CD Integration
│   ├── Jenkinsfile            # Full-featured declarative pipeline
│   ├── Jenkinsfile.declarative # Simplified declarative pipeline
│   ├── Jenkinsfile.scripted   # Advanced scripted pipeline
│   ├── jenkins-setup.sh       # Automated setup script
│   ├── JENKINS_SETUP_GUIDE.md # Comprehensive setup guide
│   └── JENKINS_EXAMPLES.md    # Practical examples and use cases
└── README.md                  # This file
```

## 🚀 Available Integrations

### 🔧 Jenkins CI/CD

**Status**: ✅ **Complete and Production-Ready**

Jenkins integration provides comprehensive NPM security scanning capabilities with Phoenix Security platform integration.

#### **Features:**
- 🔍 **Multiple Scan Types**: Quick, enhanced, light-scan, and Phoenix integration
- 🛡️ **Security Gates**: Configurable vulnerability thresholds
- 📊 **Detailed Reporting**: Comprehensive security reports and metrics
- 🔗 **Phoenix Integration**: Direct vulnerability management platform integration
- 🔔 **Notifications**: Slack, email, and webhook notifications
- 📦 **Artifact Management**: Automated archiving of reports and debug files
- 🌿 **Multi-Branch Support**: Branch-specific scanning configurations
- 🏗️ **Pipeline Types**: Declarative, scripted, and simplified options

#### **Quick Start:**
```bash
# Run the Jenkins setup script
cd ide-plugins/jenkins
./jenkins-setup.sh --credentials --pipeline-type declarative
```

#### **Documentation:**
- [`JENKINS_SETUP_GUIDE.md`](jenkins/JENKINS_SETUP_GUIDE.md) - Complete setup instructions
- [`JENKINS_EXAMPLES.md`](jenkins/JENKINS_EXAMPLES.md) - 16 practical examples
- [`jenkins-setup.sh`](jenkins/jenkins-setup.sh) - Automated setup assistance

#### **Pipeline Files:**
- **`Jenkinsfile`** - Full-featured declarative pipeline with parameters and security gates
- **`Jenkinsfile.declarative`** - Simplified pipeline for quick setup
- **`Jenkinsfile.scripted`** - Advanced scripted pipeline with maximum flexibility

---

## 🔮 Planned Integrations

### GitHub Actions
**Status**: ✅ **Already Available**
- Located in `.github/workflows/` directory
- Full Phoenix integration support
- Multiple workflow types available

### GitLab CI/CD
**Status**: 🔄 **Planned**
- GitLab CI/CD pipeline configurations
- GitLab Container Registry integration
- GitLab Security Dashboard integration

### Azure DevOps
**Status**: 🔄 **Planned**
- Azure Pipelines YAML configurations
- Azure Artifacts integration
- Azure Security Center integration

### CircleCI
**Status**: 🔄 **Planned**
- CircleCI configuration files
- Orb development for reusability
- Workflow optimization

### VS Code Extension
**Status**: 🔄 **Planned**
- Real-time security scanning
- Inline vulnerability warnings
- Phoenix integration from IDE

### IntelliJ IDEA Plugin
**Status**: 🔄 **Planned**
- JetBrains plugin development
- Gradle/Maven integration
- IDE-native reporting

## 🛠️ Integration Features Comparison

| Feature | Jenkins | GitHub Actions | GitLab CI | Azure DevOps | CircleCI |
|---------|---------|----------------|-----------|--------------|----------|
| **Status** | ✅ Complete | ✅ Complete | 🔄 Planned | 🔄 Planned | 🔄 Planned |
| **Phoenix Integration** | ✅ Yes | ✅ Yes | 🔄 Planned | 🔄 Planned | 🔄 Planned |
| **Multiple Scan Types** | ✅ Yes | ✅ Yes | 🔄 Planned | 🔄 Planned | 🔄 Planned |
| **Security Gates** | ✅ Yes | ✅ Yes | 🔄 Planned | 🔄 Planned | 🔄 Planned |
| **Notifications** | ✅ Yes | ✅ Yes | 🔄 Planned | 🔄 Planned | 🔄 Planned |
| **Artifact Management** | ✅ Yes | ✅ Yes | 🔄 Planned | 🔄 Planned | 🔄 Planned |
| **Multi-Branch** | ✅ Yes | ✅ Yes | 🔄 Planned | 🔄 Planned | 🔄 Planned |

## 📋 Getting Started

### 1. Choose Your Platform

Select the CI/CD platform or IDE you're using:

- **Jenkins**: Go to [`jenkins/`](jenkins/) directory
- **GitHub Actions**: Go to `.github/workflows/` directory
- **Other platforms**: Check back soon for additional integrations

### 2. Follow Platform-Specific Setup

Each integration includes:
- 📖 **Setup Guide** - Step-by-step instructions
- 🎯 **Examples** - Practical use cases and configurations
- 🔧 **Setup Scripts** - Automated configuration assistance
- 📊 **Templates** - Ready-to-use pipeline configurations

### 3. Configure Credentials

All integrations support secure credential management:
- **Phoenix Security API** credentials
- **GitHub tokens** for enhanced API limits
- **Notification webhooks** (Slack, Teams, etc.)

### 4. Customize for Your Needs

Each integration is highly configurable:
- **Scan types and depths**
- **Security gate thresholds**
- **Notification preferences**
- **Artifact retention policies**

## 🔐 Security Best Practices

### Credential Management
- ✅ Use platform-native credential stores
- ✅ Never hardcode secrets in pipeline files
- ✅ Rotate credentials regularly
- ✅ Use least-privilege access principles

### Pipeline Security
- ✅ Validate all input parameters
- ✅ Sanitize file paths and commands
- ✅ Implement proper error handling
- ✅ Archive sensitive data securely

### Access Control
- ✅ Limit pipeline execution permissions
- ✅ Use branch protection rules
- ✅ Implement approval workflows for production
- ✅ Monitor pipeline execution logs

## 🤝 Contributing New Integrations

We welcome contributions for additional CI/CD platforms and IDEs!

### Contribution Guidelines

1. **Create Platform Directory**
   ```bash
   mkdir ide-plugins/your-platform
   ```

2. **Include Required Files**
   - Pipeline/workflow configuration files
   - Setup guide (`PLATFORM_SETUP_GUIDE.md`)
   - Examples document (`PLATFORM_EXAMPLES.md`)
   - Setup script (if applicable)

3. **Follow Naming Conventions**
   - Use lowercase with hyphens for directories
   - Use descriptive filenames
   - Include platform name in documentation titles

4. **Ensure Feature Parity**
   - Phoenix Security integration
   - Multiple scan types
   - Security gates
   - Proper error handling
   - Artifact management

5. **Test Thoroughly**
   - Test all scan types
   - Verify Phoenix integration
   - Test error scenarios
   - Validate security practices

### Template Structure

```
ide-plugins/new-platform/
├── pipeline-config.yml        # Main pipeline configuration
├── pipeline-config.simple.yml # Simplified version
├── setup-script.sh           # Setup automation
├── PLATFORM_SETUP_GUIDE.md   # Complete setup instructions
├── PLATFORM_EXAMPLES.md      # Practical examples
└── README.md                 # Platform-specific overview
```

## 📞 Support and Documentation

### Platform-Specific Support
- **Jenkins**: See [`jenkins/JENKINS_SETUP_GUIDE.md`](jenkins/JENKINS_SETUP_GUIDE.md)
- **GitHub Actions**: See `.github/workflows/` and `GITHUB_ACTIONS_SETUP.md`

### General Support
- **Main Documentation**: See root `README.md`
- **Security Guide**: See `SECURITY_CREDENTIAL_GUIDE.md`
- **Phoenix Integration**: See `GITHUB_ACTIONS_PHOENIX_VERIFICATION.md`

### Community Resources
- **Issues**: Report platform-specific issues with appropriate labels
- **Discussions**: Share integration experiences and best practices
- **Wiki**: Community-maintained integration tips and tricks

## 🎯 Roadmap

### Short Term (Next Release)
- [ ] GitLab CI/CD integration
- [ ] Azure DevOps integration
- [ ] CircleCI integration

### Medium Term
- [ ] VS Code extension
- [ ] IntelliJ IDEA plugin
- [ ] Bitbucket Pipelines integration

### Long Term
- [ ] TeamCity integration
- [ ] Bamboo integration
- [ ] Custom webhook integrations
- [ ] Kubernetes operator

---

**🚀 Ready to integrate NPM security scanning into your development workflow?**

Choose your platform from the available integrations above and follow the platform-specific setup guides. Each integration is designed to provide comprehensive security scanning with minimal configuration required.

**🛡️ Secure your supply chain across all your development tools!** ✨
