#!/usr/bin/env bash

# Demo script for Light Scan functionality
# Shows the difference between full scan and light scan modes

set -euo pipefail

echo "🚀 NPM Compromise Detector - Light Scan Demo"
echo "=============================================="

# Create demo repository list
cat > demo_repos.txt << EOF
# Demo Repository List for Light Scan
https://github.com/facebook/create-react-app
https://github.com/vuejs/vue
https://github.com/Security-Phoenix-demo/Shai-Halud-tinycolour-compromise-verifier
EOF

echo "📋 Created demo repository list:"
cat demo_repos.txt
echo

echo "🔍 Testing Light Scan Mode..."
echo "=============================="
echo "⚡ Light scan downloads only NPM files (package.json, package-lock.json, yarn.lock)"
echo "💾 No repository cloning required"
echo "🌐 Uses GitHub API for selective file access"
echo

# Test light scan mode
echo "🪶 Running light scan..."
python3 enhanced_npm_compromise_detector_phoenix.py --repo-list demo_repos.txt --light-scan --quiet

echo
echo "✅ Light scan complete!"
echo

echo "💡 Tips for Production Use:"
echo "=========================="
echo "1. Set GITHUB_TOKEN for higher rate limits:"
echo "   export GITHUB_TOKEN=your_github_token_here"
echo
echo "2. Enable Phoenix integration:"
echo "   python3 enhanced_npm_compromise_detector_phoenix.py --repo-list repos.txt --light-scan --enable-phoenix"
echo
echo "3. Save detailed reports:"
echo "   python3 enhanced_npm_compromise_detector_phoenix.py --repo-list repos.txt --light-scan --output security_report.txt"
echo

echo "📊 Performance Comparison:"
echo "========================="
echo "Light Scan Mode:"
echo "  ⚡ Speed: Very Fast (seconds)"
echo "  💾 Storage: Zero (no cloning)"
echo "  🌐 Network: Minimal (only NPM files)"
echo "  🎯 Best for: Batch scanning, CI/CD, regular monitoring"
echo
echo "Full Scan Mode:"
echo "  🐌 Speed: Slower (minutes)"
echo "  💽 Storage: Full repositories"
echo "  📡 Network: Heavy (full clones)"
echo "  🎯 Best for: Deep analysis, dependency trees"
echo

# Cleanup
rm -f demo_repos.txt

echo "🎉 Demo complete! Try light scan mode for your repositories."
