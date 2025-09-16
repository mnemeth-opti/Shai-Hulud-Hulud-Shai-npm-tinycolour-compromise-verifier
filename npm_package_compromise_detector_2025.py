#!/usr/bin/env python3
"""
NPM Package Compromise Detection Tool - Extended 2025 Edition
Detects compromised NPM packages including @ctrl, @nativescript-community, and other affected packages
Comprehensive dependency tree analysis with detailed reporting

Author: DevSecOps Security Team
Date: September 2025
Updated: Extended package list for 2025 compromise detection
"""

import json
import os
import re
import sys
import subprocess
from pathlib import Path
from typing import Dict, List, Set, Tuple, Optional, Any
import argparse
from datetime import datetime
import tempfile
import shutil

class NPMCompromiseDetector2025:
    def __init__(self, config_file: str = None):
        """Initialize the detector with compromised package data"""
        self.config_file = config_file or "compromised_packages_2025.json"
        self.load_compromise_data()
        
        self.findings = []
        self.scanned_files = []
        self.scanned_packages = []
        self.package_sources = {}
        self.safe_packages = []
        self.dependency_stats = {
            'direct_dependencies': 0,
            'transitive_dependencies': 0,
            'lock_file_packages': 0,
            'tree_resolved_packages': 0,
            'safe_packages_found': 0,
            'compromised_packages_found': 0,
            'potentially_compromised_found': 0
        }
        self.full_tree_analysis = False
        
    def load_compromise_data(self):
        """Load compromised package data from JSON configuration"""
        try:
            if os.path.exists(self.config_file):
                with open(self.config_file, 'r', encoding='utf-8') as f:
                    data = json.load(f)
                
                self.incident_metadata = data.get('incident_metadata', {})
                self.compromised_packages = data.get('compromised_packages', {})
                self.potentially_compromised = set(data.get('potentially_compromised_packages', []))
                self.malicious_urls = data.get('malicious_indicators', {}).get('domains', [])
                self.crypto_indicators = data.get('crypto_indicators', [])
                self.suspicious_patterns = data.get('suspicious_patterns', [])
                self.safe_overrides = data.get('remediation', {}).get('safe_overrides', {})
                
                print(f"✅ Loaded compromise data: {len(self.compromised_packages)} packages with specific versions")
                print(f"✅ Loaded {len(self.potentially_compromised)} potentially compromised packages")
            else:
                print(f"⚠️  Configuration file {self.config_file} not found, using default data")
                self._load_default_data()
                
        except Exception as e:
            print(f"❌ Error loading compromise data: {str(e)}")
            self._load_default_data()
            
    def _load_default_data(self):
        """Load default compromise data if config file is not available"""
        self.compromised_packages = {
            "@ctrl/tinycolor": {"compromised_versions": ["4.1.1", "4.1.2"], "safe_version": "4.0.0"},
            "angulartics2": {"compromised_versions": ["14.1.2"], "safe_version": "14.1.1"},
            "@ctrl/deluge": {"compromised_versions": ["7.2.2"], "safe_version": "7.2.1"},
        }
        self.potentially_compromised = set([
            "@ahmedhfarag/ngx-perfect-scrollbar",
            "@ahmedhfarag/ngx-virtual-scroller",
            "@art-ws/common"
        ])
        self.malicious_urls = ["npmjs.help", "support@npmjs.help"]
        self.crypto_indicators = ["cryptocurrency", "wallet", "private key", "bitcoin", "ethereum"]
        self.suspicious_patterns = []
        self.safe_overrides = {}
        
    def log_finding(self, severity: str, message: str, file_path: str = None, details: Dict = None):
        """Log a security finding"""
        finding = {
            'timestamp': datetime.now().isoformat(),
            'severity': severity,
            'message': message,
            'file': file_path,
            'details': details or {}
        }
        self.findings.append(finding)
        
    def enable_full_tree_analysis(self, enable: bool = True):
        """Enable or disable full dependency tree analysis"""
        self.full_tree_analysis = enable
        
    def track_package(self, package_name: str, version: str, source: str, file_path: str = None, depth: int = 0):
        """Track a scanned package for reporting purposes"""
        package_key = f"{package_name}@{version}"
        
        if package_key not in [p['key'] for p in self.scanned_packages]:
            package_info = {
                'key': package_key,
                'name': package_name,
                'version': version,
                'source': source,
                'file_path': file_path,
                'depth': depth,
                'first_seen': datetime.now().isoformat()
            }
            self.scanned_packages.append(package_info)
            
        if package_key not in self.package_sources:
            self.package_sources[package_key] = []
        
        source_info = {
            'source': source,
            'file_path': file_path,
            'depth': depth
        }
        
        if source_info not in self.package_sources[package_key]:
            self.package_sources[package_key].append(source_info)
            
    def track_safe_package(self, package_name: str, version: str, compromised_versions: List[str], source: str, file_path: str = None, depth: int = 0):
        """Track a package that is a safe version of a potentially compromised package"""
        safe_package_info = {
            'name': package_name,
            'version': version,
            'compromised_versions': compromised_versions,
            'source': source,
            'file_path': file_path,
            'depth': depth,
            'found_at': datetime.now().isoformat()
        }
        
        existing = any(
            p['name'] == package_name and 
            p['version'] == version and 
            p['file_path'] == file_path and
            p['source'] == source
            for p in self.safe_packages
        )
        
        if not existing:
            self.safe_packages.append(safe_package_info)
            self.dependency_stats['safe_packages_found'] += 1
            
    def normalize_version(self, version: str) -> str:
        """Normalize version string by removing prefixes like ^, ~, >=, etc."""
        if not version:
            return ""
        # Remove common npm version prefixes
        cleaned = re.sub(r'^[^\d]*', '', str(version))
        # Handle version ranges like "1.0.0 - 2.0.0"
        if ' - ' in cleaned:
            cleaned = cleaned.split(' - ')[0]
        # Handle || operators
        if ' || ' in cleaned:
            cleaned = cleaned.split(' || ')[0]
        return cleaned.strip()
        
    def check_package_compromise(self, package_name: str, version: str) -> Tuple[bool, str, List[str]]:
        """
        Check if a package version is compromised
        Returns: (is_compromised, severity, compromised_versions_list)
        """
        normalized_version = self.normalize_version(version)
        
        # Check exact compromised packages with versions
        if package_name in self.compromised_packages:
            pkg_data = self.compromised_packages[package_name]
            compromised_versions = pkg_data.get('compromised_versions', [])
            
            if normalized_version in compromised_versions:
                return True, 'CRITICAL', compromised_versions
            else:
                # Package is in our list but version is different - could be safe
                return False, 'INFO', compromised_versions
                
        # Check potentially compromised packages (no specific version)
        if package_name in self.potentially_compromised:
            return True, 'HIGH', []
            
        return False, '', []
        
    def get_npm_dependency_tree(self, package_json_dir: str) -> Dict:
        """Get full dependency tree using npm list"""
        try:
            original_cwd = os.getcwd()
            os.chdir(package_json_dir)
            
            # Try different npm list commands for better compatibility
            commands = [
                ['npm', 'list', '--json', '--all', '--prod'],
                ['npm', 'list', '--json', '--all'],
                ['npm', 'list', '--json', '--depth=0']
            ]
            
            for cmd in commands:
                try:
                    result = subprocess.run(
                        cmd,
                        capture_output=True,
                        text=True,
                        timeout=60
                    )
                    
                    if result.returncode == 0 or result.stdout:
                        # npm list can return non-zero even with valid output
                        tree_data = json.loads(result.stdout)
                        os.chdir(original_cwd)
                        return tree_data
                        
                except (json.JSONDecodeError, subprocess.TimeoutExpired):
                    continue
                    
            os.chdir(original_cwd)
                    
        except Exception as e:
            if 'original_cwd' in locals():
                os.chdir(original_cwd)
            self.log_finding('WARNING', f'Error getting npm dependency tree: {str(e)}', package_json_dir)
            
        return {}
        
    def scan_dependency_tree_recursive(self, deps: Dict, file_path: str, depth: int = 0) -> List[Dict]:
        """Recursively scan dependency tree for compromised packages"""
        findings = []
        
        if depth > 50:  # Prevent infinite recursion
            return findings
            
        for package_name, package_info in deps.items():
            version = package_info.get('version', '')
            
            if version:
                source_type = 'transitive_dependency' if depth > 0 else 'tree_resolved_dependency'
                self.track_package(package_name, version, source_type, file_path, depth)
                
                if depth > 0:
                    self.dependency_stats['transitive_dependencies'] += 1
                else:
                    self.dependency_stats['tree_resolved_packages'] += 1
            
            # Check if package is compromised
            is_compromised, severity, compromised_versions = self.check_package_compromise(package_name, version)
            
            if is_compromised and severity == 'CRITICAL':
                self.log_finding(
                    'CRITICAL',
                    f'Compromised package in dependency tree: {package_name}@{version} (depth: {depth})',
                    file_path,
                    {
                        'package': package_name, 
                        'version': version, 
                        'depth': depth,
                        'tree_source': 'npm_list',
                        'compromised_versions': compromised_versions
                    }
                )
                findings.append({
                    'package': package_name,
                    'version': version,
                    'file': file_path,
                    'depth': depth,
                    'source': 'dependency_tree'
                })
                self.dependency_stats['compromised_packages_found'] += 1
                
            elif is_compromised and severity == 'HIGH':
                self.log_finding(
                    'HIGH',
                    f'Potentially compromised package in dependency tree: {package_name}@{version} (depth: {depth})',
                    file_path,
                    {
                        'package': package_name,
                        'version': version,
                        'depth': depth,
                        'tree_source': 'npm_list',
                        'reason': 'Package name in potentially compromised list'
                    }
                )
                findings.append({
                    'package': package_name,
                    'version': version,
                    'file': file_path,
                    'depth': depth,
                    'source': 'dependency_tree',
                    'type': 'potentially_compromised'
                })
                self.dependency_stats['potentially_compromised_found'] += 1
                
            elif package_name in self.compromised_packages and not is_compromised:
                # Package is in our compromised list but using a different (potentially safe) version
                self.track_safe_package(
                    package_name, version, compromised_versions,
                    f'safe_tree_dependency', file_path, depth
                )
                self.log_finding(
                    'INFO',
                    f'Safe version in dependency tree: {package_name}@{version} (depth: {depth}, compromised: {", ".join(compromised_versions)})',
                    file_path,
                    {
                        'package': package_name,
                        'safe_version': version,
                        'compromised_versions': compromised_versions,
                        'depth': depth,
                        'tree_source': 'npm_list'
                    }
                )
                    
            # Recursively check nested dependencies
            if 'dependencies' in package_info and package_info['dependencies']:
                findings.extend(self.scan_dependency_tree_recursive(
                    package_info['dependencies'], file_path, depth + 1
                ))
                
        return findings

    def scan_package_json(self, file_path: str) -> List[Dict]:
        """Scan package.json for compromised packages"""
        findings = []
        
        try:
            with open(file_path, 'r', encoding='utf-8') as f:
                package_data = json.load(f)
                
            # Check direct dependencies
            for dep_type in ['dependencies', 'devDependencies', 'peerDependencies', 'optionalDependencies']:
                if dep_type in package_data:
                    for package_name, version in package_data[dep_type].items():
                        clean_version = self.normalize_version(version)
                        self.track_package(package_name, clean_version, f'direct_{dep_type}', file_path, depth=0)
                        self.dependency_stats['direct_dependencies'] += 1
                        
                        # Check if package is compromised
                        is_compromised, severity, compromised_versions = self.check_package_compromise(package_name, clean_version)
                        
                        if is_compromised and severity == 'CRITICAL':
                            self.log_finding(
                                'CRITICAL',
                                f'Compromised package detected: {package_name}@{version}',
                                file_path,
                                {
                                    'package': package_name,
                                    'version': version,
                                    'normalized_version': clean_version,
                                    'dependency_type': dep_type,
                                    'compromised_versions': compromised_versions
                                }
                            )
                            findings.append({
                                'package': package_name,
                                'version': version,
                                'type': dep_type,
                                'file': file_path
                            })
                            self.dependency_stats['compromised_packages_found'] += 1
                            
                        elif is_compromised and severity == 'HIGH':
                            self.log_finding(
                                'HIGH',
                                f'Potentially compromised package detected: {package_name}@{version}',
                                file_path,
                                {
                                    'package': package_name,
                                    'version': version,
                                    'dependency_type': dep_type,
                                    'reason': 'Package name in potentially compromised list'
                                }
                            )
                            findings.append({
                                'package': package_name,
                                'version': version,
                                'type': dep_type,
                                'file': file_path,
                                'compromise_type': 'potentially_compromised'
                            })
                            self.dependency_stats['potentially_compromised_found'] += 1
                            
                        elif package_name in self.compromised_packages and not is_compromised:
                            # Package is in our compromised list but using a different version
                            self.track_safe_package(
                                package_name, clean_version, compromised_versions, 
                                f'safe_{dep_type}', file_path, depth=0
                            )
                            self.log_finding(
                                'INFO',
                                f'Safe version detected: {package_name}@{version} (compromised: {", ".join(compromised_versions)})',
                                file_path,
                                {
                                    'package': package_name,
                                    'safe_version': version,
                                    'compromised_versions': compromised_versions,
                                    'dependency_type': dep_type
                                }
                            )
            
            # Full tree analysis if enabled
            if self.full_tree_analysis:
                package_dir = os.path.dirname(file_path)
                
                if (os.path.exists(os.path.join(package_dir, 'package-lock.json')) or 
                    os.path.exists(os.path.join(package_dir, 'node_modules'))):
                    print(f"📦 Getting full dependency tree for {file_path}")
                    dep_tree = self.get_npm_dependency_tree(package_dir)
                    
                    if dep_tree and 'dependencies' in dep_tree:
                        tree_findings = self.scan_dependency_tree_recursive(
                            dep_tree['dependencies'], file_path, depth=1
                        )
                        findings.extend(tree_findings)
                        
                        if tree_findings:
                            compromised_count = len([f for f in tree_findings if f.get('type') != 'potentially_compromised'])
                            potentially_count = len([f for f in tree_findings if f.get('type') == 'potentially_compromised'])
                            
                            self.log_finding(
                                'INFO',
                                f'Full dependency tree analysis: {compromised_count} compromised, {potentially_count} potentially compromised',
                                file_path,
                                {
                                    'compromised_count': compromised_count,
                                    'potentially_compromised_count': potentially_count,
                                    'total_findings': len(tree_findings)
                                }
                            )
                                
        except (json.JSONDecodeError, FileNotFoundError) as e:
            self.log_finding('ERROR', f'Failed to parse {file_path}: {str(e)}', file_path)
            
        return findings
        
    def scan_lock_file(self, file_path: str) -> List[Dict]:
        """Scan package-lock.json or yarn.lock for compromised packages"""
        findings = []
        
        try:
            if file_path.endswith('package-lock.json'):
                findings.extend(self._scan_package_lock(file_path))
            elif file_path.endswith('yarn.lock'):
                findings.extend(self._scan_yarn_lock(file_path))
                
        except Exception as e:
            self.log_finding('ERROR', f'Failed to scan lock file {file_path}: {str(e)}', file_path)
            
        return findings
        
    def _scan_package_lock(self, file_path: str) -> List[Dict]:
        """Scan package-lock.json specifically"""
        findings = []
        
        with open(file_path, 'r', encoding='utf-8') as f:
            lock_data = json.load(f)
            
        # Check packages in lockfile v2/v3 format
        if 'packages' in lock_data:
            for package_path, package_info in lock_data['packages'].items():
                if package_path.startswith('node_modules/'):
                    # Handle scoped packages correctly
                    path_parts = package_path.replace('node_modules/', '').split('/')
                    if path_parts[0].startswith('@'):
                        package_name = '/'.join(path_parts[:2])  # @scope/name
                    else:
                        package_name = path_parts[0]
                        
                    version = package_info.get('version', '')
                    
                    if version:
                        depth = package_path.count('/') - 1
                        self.track_package(package_name, version, 'lock_file_v2_v3', file_path, depth)
                        self.dependency_stats['lock_file_packages'] += 1
                    
                    # Check if package is compromised
                    is_compromised, severity, compromised_versions = self.check_package_compromise(package_name, version)
                    
                    if is_compromised and severity == 'CRITICAL':
                        self.log_finding(
                            'CRITICAL',
                            f'Compromised package in lock file: {package_name}@{version}',
                            file_path,
                            {
                                'package': package_name, 
                                'version': version, 
                                'path': package_path,
                                'compromised_versions': compromised_versions
                            }
                        )
                        findings.append({
                            'package': package_name,
                            'version': version,
                            'file': file_path
                        })
                        self.dependency_stats['compromised_packages_found'] += 1
                        
                    elif is_compromised and severity == 'HIGH':
                        self.log_finding(
                            'HIGH',
                            f'Potentially compromised package in lock file: {package_name}@{version}',
                            file_path,
                            {
                                'package': package_name,
                                'version': version,
                                'path': package_path,
                                'reason': 'Package name in potentially compromised list'
                            }
                        )
                        findings.append({
                            'package': package_name,
                            'version': version,
                            'file': file_path,
                            'type': 'potentially_compromised'
                        })
                        self.dependency_stats['potentially_compromised_found'] += 1
                        
                    elif package_name in self.compromised_packages and not is_compromised:
                        # Package is in our compromised list but using a safe version
                        depth = package_path.count('/') - 1
                        self.track_safe_package(
                            package_name, version, compromised_versions,
                            'safe_lock_file_v2_v3', file_path, depth
                        )
                        self.log_finding(
                            'INFO',
                            f'Safe version in lock file: {package_name}@{version} (compromised: {", ".join(compromised_versions)})',
                            file_path,
                            {
                                'package': package_name,
                                'safe_version': version,
                                'compromised_versions': compromised_versions,
                                'path': package_path
                            }
                        )
                            
        # Check dependencies in lockfile v1 format
        if 'dependencies' in lock_data:
            findings.extend(self._scan_dependencies_recursive(lock_data['dependencies'], file_path))
            
        return findings
        
    def _scan_dependencies_recursive(self, deps: Dict, file_path: str, prefix: str = '') -> List[Dict]:
        """Recursively scan dependencies in package-lock.json"""
        findings = []
        
        for package_name, package_info in deps.items():
            version = package_info.get('version', '')
            
            if version:
                depth = len(prefix.split('/')) - 1 if prefix else 0
                self.track_package(package_name, version, 'lock_file_dependency', file_path, depth)
                self.dependency_stats['lock_file_packages'] += 1
            
            # Check if package is compromised
            is_compromised, severity, compromised_versions = self.check_package_compromise(package_name, version)
            
            if is_compromised and severity in ['CRITICAL', 'HIGH']:
                self.log_finding(
                    severity,
                    f'{"Compromised" if severity == "CRITICAL" else "Potentially compromised"} package in dependencies: {package_name}@{version}',
                    file_path,
                    {
                        'package': package_name, 
                        'version': version,
                        'compromised_versions': compromised_versions if severity == 'CRITICAL' else []
                    }
                )
                findings.append({
                    'package': package_name,
                    'version': version,
                    'file': file_path,
                    'type': 'potentially_compromised' if severity == 'HIGH' else 'compromised'
                })
                
                if severity == 'CRITICAL':
                    self.dependency_stats['compromised_packages_found'] += 1
                else:
                    self.dependency_stats['potentially_compromised_found'] += 1
                    
            elif package_name in self.compromised_packages and not is_compromised:
                # Safe version
                depth = len(prefix.split('/')) - 1 if prefix else 0
                self.track_safe_package(
                    package_name, version, compromised_versions,
                    'safe_lock_file_dependency', file_path, depth
                )
                    
            # Recursively check nested dependencies
            if 'dependencies' in package_info:
                findings.extend(self._scan_dependencies_recursive(
                    package_info['dependencies'], file_path, f"{prefix}{package_name}/"
                ))
                
        return findings
        
    def _scan_yarn_lock(self, file_path: str) -> List[Dict]:
        """Scan yarn.lock file"""
        findings = []
        
        with open(file_path, 'r', encoding='utf-8') as f:
            content = f.read()
            
        # Parse yarn.lock format for our compromised packages
        all_packages = {**self.compromised_packages}
        for pkg_name in self.potentially_compromised:
            all_packages[pkg_name] = {"compromised_versions": [], "safe_version": "unknown"}
            
        for package_name, pkg_data in all_packages.items():
            compromised_versions = pkg_data.get('compromised_versions', [])
            
            # Look for package entries in yarn.lock
            escaped_name = re.escape(package_name)
            
            if compromised_versions:
                # Check for specific compromised versions
                for comp_version in compromised_versions:
                    pattern = rf'^{escaped_name}@.*?:\s*\n(?:\s+.*\n)*?\s+version\s+"?{re.escape(comp_version)}"?'
                    matches = re.findall(pattern, content, re.MULTILINE)
                    
                    if matches:
                        self.log_finding(
                            'CRITICAL',
                            f'Compromised package in yarn.lock: {package_name}@{comp_version}',
                            file_path,
                            {'package': package_name, 'version': comp_version}
                        )
                        findings.append({
                            'package': package_name,
                            'version': comp_version,
                            'file': file_path
                        })
                        self.dependency_stats['compromised_packages_found'] += 1
            else:
                # Check for potentially compromised packages (any version)
                pattern = rf'^{escaped_name}@.*?:\s*\n(?:\s+.*\n)*?\s+version\s+"?([^"]+)"?'
                matches = re.findall(pattern, content, re.MULTILINE)
                
                if matches:
                    for version in matches:
                        self.log_finding(
                            'HIGH',
                            f'Potentially compromised package in yarn.lock: {package_name}@{version}',
                            file_path,
                            {'package': package_name, 'version': version}
                        )
                        findings.append({
                            'package': package_name,
                            'version': version,
                            'file': file_path,
                            'type': 'potentially_compromised'
                        })
                        self.dependency_stats['potentially_compromised_found'] += 1
                
        return findings
        
    def scan_source_files(self, file_path: str) -> List[Dict]:
        """Scan source files for malicious URLs and crypto-related indicators"""
        findings = []
        
        try:
            with open(file_path, 'r', encoding='utf-8', errors='ignore') as f:
                content = f.read()
                
            # Check for malicious URLs
            for url in self.malicious_urls:
                if url in content:
                    self.log_finding(
                        'HIGH',
                        f'Malicious URL detected: {url}',
                        file_path,
                        {'url': url, 'context': self._extract_context(content, url)}
                    )
                    findings.append({
                        'type': 'malicious_url',
                        'url': url,
                        'file': file_path
                    })
                    
            # Check for crypto-related indicators
            crypto_matches = []
            for indicator in self.crypto_indicators:
                if indicator.lower() in content.lower():
                    crypto_matches.append(indicator)
                    
            if crypto_matches:
                self.log_finding(
                    'MEDIUM',
                    f'Crypto-related keywords detected: {", ".join(crypto_matches)}',
                    file_path,
                    {'keywords': crypto_matches}
                )
                findings.append({
                    'type': 'crypto_indicators',
                    'keywords': crypto_matches,
                    'file': file_path
                })
                
            # Check for suspicious patterns
            suspicious_matches = []
            for pattern in self.suspicious_patterns:
                if re.search(pattern, content):
                    suspicious_matches.append(pattern)
                    
            if suspicious_matches:
                self.log_finding(
                    'MEDIUM',
                    f'Suspicious code patterns detected: {len(suspicious_matches)} patterns',
                    file_path,
                    {'patterns': suspicious_matches}
                )
                findings.append({
                    'type': 'suspicious_patterns',
                    'patterns': suspicious_matches,
                    'file': file_path
                })
                
        except Exception as e:
            self.log_finding('ERROR', f'Failed to scan source file {file_path}: {str(e)}', file_path)
            
        return findings
        
    def _extract_context(self, content: str, search_term: str, context_lines: int = 2) -> str:
        """Extract context around a found term"""
        lines = content.split('\n')
        for i, line in enumerate(lines):
            if search_term in line:
                start = max(0, i - context_lines)
                end = min(len(lines), i + context_lines + 1)
                return '\n'.join(lines[start:end])
        return ''
        
    def scan_directory(self, directory: str, recursive: bool = True) -> None:
        """Scan a directory for compromised packages and malicious content"""
        directory_path = Path(directory)
        
        if not directory_path.exists():
            self.log_finding('ERROR', f'Directory does not exist: {directory}')
            return
            
        # Find package.json files
        package_files = []
        if recursive:
            package_files = list(directory_path.rglob('package.json'))
        else:
            package_files = list(directory_path.glob('package.json'))
            
        for package_file in package_files:
            self.scanned_files.append(str(package_file))
            self.scan_package_json(str(package_file))
            
        # Find lock files
        lock_files = []
        if recursive:
            lock_files.extend(directory_path.rglob('package-lock.json'))
            lock_files.extend(directory_path.rglob('yarn.lock'))
        else:
            lock_files.extend(directory_path.glob('package-lock.json'))
            lock_files.extend(directory_path.glob('yarn.lock'))
            
        for lock_file in lock_files:
            self.scanned_files.append(str(lock_file))
            self.scan_lock_file(str(lock_file))
            
        # Scan JavaScript/TypeScript files for malicious content
        source_extensions = ['*.js', '*.ts', '*.jsx', '*.tsx', '*.mjs', '*.cjs']
        source_files = []
        
        for ext in source_extensions:
            if recursive:
                source_files.extend(directory_path.rglob(ext))
            else:
                source_files.extend(directory_path.glob(ext))
                
        # Limit source file scanning for performance
        max_source_files = 200
        if len(source_files) > max_source_files:
            print(f"⚠️  Found {len(source_files)} source files, scanning first {max_source_files} for performance")
            source_files = source_files[:max_source_files]
                
        for source_file in source_files:
            self.scanned_files.append(str(source_file))
            self.scan_source_files(str(source_file))
            
    def generate_report(self, output_file: str = None) -> str:
        """Generate a comprehensive security report"""
        report_lines = []
        report_lines.append("=" * 80)
        report_lines.append("NPM PACKAGE COMPROMISE DETECTION REPORT - 2025 EXTENDED")
        report_lines.append("=" * 80)
        report_lines.append(f"Scan completed: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}")
        report_lines.append(f"Files scanned: {len(self.scanned_files)}")
        report_lines.append(f"Total findings: {len(self.findings)}")
        report_lines.append(f"Packages analyzed: {len(self.scanned_packages)}")
        
        if hasattr(self, 'incident_metadata') and self.incident_metadata:
            report_lines.append(f"Incident: {self.incident_metadata.get('name', 'Unknown')}")
            
        report_lines.append("")
        
        # Summary by severity
        severity_counts = {}
        for finding in self.findings:
            severity = finding['severity']
            severity_counts[severity] = severity_counts.get(severity, 0) + 1
            
        # Package analysis summary
        report_lines.append("PACKAGE ANALYSIS SUMMARY:")
        report_lines.append("-" * 30)
        report_lines.append(f"Direct dependencies: {self.dependency_stats['direct_dependencies']}")
        report_lines.append(f"Transitive dependencies: {self.dependency_stats['transitive_dependencies']}")
        report_lines.append(f"Lock file packages: {self.dependency_stats['lock_file_packages']}")
        if self.full_tree_analysis:
            report_lines.append(f"Tree resolved packages: {self.dependency_stats['tree_resolved_packages']}")
        report_lines.append(f"Compromised packages found: {self.dependency_stats['compromised_packages_found']}")
        report_lines.append(f"Potentially compromised found: {self.dependency_stats['potentially_compromised_found']}")
        report_lines.append(f"Safe versions found: {self.dependency_stats['safe_packages_found']}")
        report_lines.append("")
        
        # Package source breakdown
        source_counts = {}
        for package in self.scanned_packages:
            source = package['source']
            source_counts[source] = source_counts.get(source, 0) + 1
            
        if source_counts:
            report_lines.append("PACKAGE SOURCES:")
            report_lines.append("-" * 20)
            for source, count in sorted(source_counts.items()):
                report_lines.append(f"{source}: {count}")
            report_lines.append("")
        
        report_lines.append("SEVERITY SUMMARY:")
        report_lines.append("-" * 20)
        for severity in ['CRITICAL', 'HIGH', 'MEDIUM', 'WARNING', 'ERROR', 'INFO']:
            if severity in severity_counts:
                report_lines.append(f"{severity}: {severity_counts[severity]}")
        report_lines.append("")
        
        # Detailed findings
        if self.findings:
            report_lines.append("DETAILED FINDINGS:")
            report_lines.append("-" * 20)
            
            for i, finding in enumerate(self.findings, 1):
                report_lines.append(f"{i}. [{finding['severity']}] {finding['message']}")
                if finding['file']:
                    report_lines.append(f"   📁 Location: {finding['file']}")
                if finding['details']:
                    for key, value in finding['details'].items():
                        if key == 'depth' and value > 0:
                            report_lines.append(f"   🔗 Dependency depth: {value}")
                        elif key == 'dependency_type':
                            report_lines.append(f"   📦 Type: {value}")
                        elif key == 'compromised_versions' and value:
                            report_lines.append(f"   ⚠️  Compromised versions: {', '.join(value)}")
                        elif key in ['package', 'version', 'safe_version', 'normalized_version']:
                            report_lines.append(f"   {key}: {value}")
                        elif key == 'reason':
                            report_lines.append(f"   💡 Reason: {value}")
                        else:
                            report_lines.append(f"   {key}: {value}")
                report_lines.append("")
        else:
            report_lines.append("✅ No compromised packages detected!")
            report_lines.append("")
            
        # Add safe packages summary if any found
        if self.safe_packages:
            report_lines.append("SAFE VERSIONS OF MONITORED PACKAGES:")
            report_lines.append("-" * 40)
            
            # Group safe packages by name
            safe_by_name = {}
            for safe_pkg in self.safe_packages:
                name = safe_pkg['name']
                if name not in safe_by_name:
                    safe_by_name[name] = []
                safe_by_name[name].append(safe_pkg)
            
            for package_name in sorted(safe_by_name.keys()):
                safe_versions = safe_by_name[package_name]
                compromised_versions = safe_versions[0]['compromised_versions']
                unique_versions = list(set(pkg['version'] for pkg in safe_versions))
                
                report_lines.append(f"✅ {package_name}")
                report_lines.append(f"   Safe versions found: {', '.join(sorted(unique_versions))}")
                if compromised_versions:
                    report_lines.append(f"   Compromised versions: {', '.join(compromised_versions)}")
                report_lines.append(f"   Found in {len(safe_versions)} location(s)")
                report_lines.append("")
            
        # Recommendations
        report_lines.append("RECOMMENDATIONS:")
        report_lines.append("-" * 20)
        
        critical_findings = [f for f in self.findings if f['severity'] == 'CRITICAL']
        high_findings = [f for f in self.findings if f['severity'] == 'HIGH']
        
        if critical_findings:
            report_lines.append("🚨 IMMEDIATE ACTION REQUIRED:")
            report_lines.append("1. Stop all running applications immediately")
            report_lines.append("2. Remove or update all compromised packages")
            report_lines.append("3. Clear npm cache: npm cache clean --force")
            report_lines.append("4. Remove node_modules and lock files")
            report_lines.append("5. Update to safe package versions")
            report_lines.append("6. Reinstall dependencies")
            report_lines.append("7. Review application logs for suspicious activity")
            report_lines.append("8. Check for unauthorized network connections")
            report_lines.append("")
            
        if high_findings:
            report_lines.append("⚠️  HIGH PRIORITY ACTIONS:")
            report_lines.append("1. Review potentially compromised packages")
            report_lines.append("2. Verify package authenticity")
            report_lines.append("3. Consider alternative packages if available")
            report_lines.append("4. Monitor for updates from package maintainers")
            report_lines.append("")
            
        if self.safe_overrides:
            report_lines.append("SAFE VERSION OVERRIDES (add to package.json):")
            report_lines.append('  "overrides": {')
            for package, version in self.safe_overrides.items():
                report_lines.append(f'    "{package}": "{version}",')
            report_lines.append('  }')
            report_lines.append("")
        
        if hasattr(self, 'incident_metadata') and self.incident_metadata:
            report_lines.append("REFERENCE:")
            if self.incident_metadata.get('github_issue'):
                report_lines.append(f"- GitHub Issue: {self.incident_metadata['github_issue']}")
            if self.incident_metadata.get('attack_vector'):
                report_lines.append(f"- Attack Vector: {self.incident_metadata['attack_vector']}")
            if self.incident_metadata.get('impact'):
                report_lines.append(f"- Impact: {self.incident_metadata['impact']}")
            report_lines.append("")
        
        report_content = '\n'.join(report_lines)
        
        if output_file:
            with open(output_file, 'w', encoding='utf-8') as f:
                f.write(report_content)
            print(f"📄 Report saved to: {output_file}")
            
        return report_content


def main():
    parser = argparse.ArgumentParser(description='NPM Package Compromise Detection Tool - 2025 Extended')
    parser.add_argument('directory', nargs='?', default='.', 
                       help='Directory to scan (default: current directory)')
    parser.add_argument('--output', '-o', help='Output report file')
    parser.add_argument('--config', '-c', default='compromised_packages_2025.json',
                       help='Configuration file with compromised package data')
    parser.add_argument('--no-recursive', action='store_true', 
                       help='Do not scan subdirectories')
    parser.add_argument('--full-tree', action='store_true',
                       help='Enable full dependency tree analysis (slower but comprehensive)')
    parser.add_argument('--quiet', '-q', action='store_true',
                       help='Only show critical and high severity findings')
    
    args = parser.parse_args()
    
    print("🔍 NPM Package Compromise Detector 2025 - Extended Edition")
    print("=" * 60)
    
    detector = NPMCompromiseDetector2025(config_file=args.config)
    
    if args.full_tree:
        detector.enable_full_tree_analysis(True)
        print("🌳 Full dependency tree analysis enabled")
    
    print(f"📁 Scanning directory: {os.path.abspath(args.directory)}")
    if args.full_tree:
        print("⚠️  Full tree analysis may take longer but will find all transitive dependencies")
    print()
    
    # Scan directory
    detector.scan_directory(args.directory, recursive=not args.no_recursive)
    
    # Generate and display report
    report = detector.generate_report(args.output)
    
    if not args.quiet:
        print(report)
    else:
        critical_findings = [f for f in detector.findings if f['severity'] == 'CRITICAL']
        high_findings = [f for f in detector.findings if f['severity'] == 'HIGH']
        
        if critical_findings:
            print("🚨 CRITICAL FINDINGS DETECTED!")
            for finding in critical_findings:
                print(f"  - {finding['message']}")
                if finding['file']:
                    print(f"    File: {finding['file']}")
        
        if high_findings:
            print("⚠️  HIGH PRIORITY FINDINGS DETECTED!")
            for finding in high_findings:
                print(f"  - {finding['message']}")
                if finding['file']:
                    print(f"    File: {finding['file']}")
                    
        if not critical_findings and not high_findings:
            print("✅ No critical or high priority findings detected")
    
    # Exit with error code if critical or high findings
    critical_count = len([f for f in detector.findings if f['severity'] in ['CRITICAL', 'HIGH']])
    sys.exit(1 if critical_count > 0 else 0)


if __name__ == '__main__':
    main()
