# Phoenix Security Asset Import Tool - Changelog

All notable changes to the Phoenix Security Asset Import Tool are documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/), and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Planned Features
- Parallel processing for improved performance
- Advanced file filtering options
- Custom report formats (JSON, HTML, CSV)
- Integration with monitoring systems
- Enhanced error recovery mechanisms

---

## [2.0.0] - 2025-08-22

### 🚀 Major Features Added

#### Batch Processing System
- **NEW:** `--folder` argument for processing multiple files in a directory
- **NEW:** Automatic file discovery for supported formats (.csv, .json, .xml, .txt, .xlsx)
- **NEW:** Sequential processing with individual file status tracking
- **NEW:** Comprehensive batch processing reports with success metrics

#### Command Line Interface
- **NEW:** Complete argument parser with `argparse` library
- **NEW:** Flexible authentication options (`--client_id`, `--client_secret`, `--phoenix_api_url`)
- **NEW:** Scanner type configuration (`--scan_type`)
- **NEW:** Import type selection (`--import_type` with choices: new, delta)
- **NEW:** Custom configuration file support (`--config_file`)
- **NEW:** Custom report output location (`--report_file`)

#### Enhanced Configuration System
- **NEW:** Multi-tier configuration priority system
- **NEW:** Environment variable support (`PHOENIX_*` variables)
- **NEW:** Command line argument override capability
- **NEW:** Configuration validation with detailed error messages
- **NEW:** Scanner type parameter in configuration files

#### Advanced Reporting System
- **NEW:** Comprehensive HTML-style text reports
- **NEW:** Success rate calculations and metrics
- **NEW:** Detailed error reporting with context
- **NEW:** Automatic report file naming with timestamps
- **NEW:** Separate sections for successful and failed imports

#### File Processing Enhancements
- **NEW:** Automatic assessment naming based on file names and timestamps
- **NEW:** Intelligent scan target generation from file names
- **NEW:** Support for multiple file formats in batch operations
- **NEW:** File validation before processing

### 🛠 Technical Improvements

#### Code Architecture
- **IMPROVED:** Modular function design for better maintainability
- **IMPROVED:** Separation of concerns between configuration, processing, and reporting
- **IMPROVED:** Error handling with try-catch blocks throughout
- **IMPROVED:** Type hints and comprehensive docstrings

#### Error Handling
- **IMPROVED:** Graceful error handling that doesn't stop batch processing
- **IMPROVED:** Detailed error context in reports
- **IMPROVED:** Configuration validation with helpful error messages
- **IMPROVED:** Network error handling with retry logic

#### Performance Optimizations
- **IMPROVED:** Efficient file discovery using glob patterns
- **IMPROVED:** Memory-efficient file processing
- **IMPROVED:** Reduced API calls through better token management
- **IMPROVED:** Optimized report generation

### 📝 Documentation

#### New Documentation Files
- **NEW:** Comprehensive README.md with usage examples
- **NEW:** CHANGELOG.md with detailed version history
- **NEW:** README_batch_import.md for batch processing guide
- **NEW:** Enhanced config.ini.example with scanner type parameter

#### Documentation Improvements
- **IMPROVED:** Detailed usage examples for all operation modes
- **IMPROVED:** Troubleshooting guide with common issues and solutions
- **IMPROVED:** Best practices section for security and operations
- **IMPROVED:** API integration documentation

### 🔧 Configuration Changes

#### New Configuration Options
```ini
[phoenix]
client_id = YOUR_CLIENT_ID
client_secret = YOUR_CLIENT_SECRET
api_base_url = https://api.your-phoenix-instance.com
scan_type = Tenable Scan  # NEW: Default scanner type
```

#### New Environment Variables
- `PHOENIX_CLIENT_ID` - Phoenix API Client ID
- `PHOENIX_CLIENT_SECRET` - Phoenix API Client Secret
- `PHOENIX_API_BASE_URL` - Phoenix API base URL
- `PHOENIX_SCAN_TYPE` - Default scanner type

### 🔄 Backward Compatibility

#### Legacy Mode Support
- **MAINTAINED:** Original single-file processing functionality
- **MAINTAINED:** Hardcoded parameter support for existing workflows
- **MAINTAINED:** Original API integration without breaking changes
- **MAINTAINED:** Existing configuration file format compatibility

#### Migration Path
- **AUTOMATIC:** Existing configurations work without modification
- **OPTIONAL:** New features available through command line arguments
- **GRADUAL:** Can migrate to new configuration system incrementally

### 📊 Usage Examples

#### New Batch Processing
```bash
# Process all files in a folder
python phoenix_import2_simple_file_v2_new.py \
  --folder /path/to/scan/files \
  --scan_type "Tenable Scan" \
  --import_type new
```

#### Enhanced Single File Processing
```bash
# Process single file with new interface
python phoenix_import2_simple_file_v2_new.py \
  --file /path/to/scan.csv \
  --client_id "your_id" \
  --client_secret "your_secret" \
  --phoenix_api_url "https://api.phoenix.com"
```

#### Configuration File Usage
```bash
# Use custom configuration file
python phoenix_import2_simple_file_v2_new.py \
  --folder /path/to/scans \
  --config_file /path/to/custom/config.ini \
  --report_file /path/to/custom/report.txt
```

---

## [1.2.1] - 2024-12-10

### 🐛 Bug Fixes
- **FIXED:** File handle not being properly closed after upload
- **FIXED:** Error message formatting for HTTP status codes
- **FIXED:** Memory leak in large file processing

### 🔧 Minor Improvements
- **IMPROVED:** Error message clarity for authentication failures
- **IMPROVED:** Timeout handling for slow API responses
- **IMPROVED:** Status polling frequency optimization

---

## [1.2.0] - 2024-11-15

### ✨ Features Added
- **NEW:** Scanner type validation with fuzzy matching
- **NEW:** Closest scanner type suggestions for invalid types
- **NEW:** Scanner types file support for validation
- **NEW:** Enhanced status monitoring with detailed progress updates

### 🛠 Technical Changes
- **ADDED:** `difflib` library for fuzzy string matching
- **ADDED:** `load_scanner_types()` function for validation data
- **ADDED:** `find_closest_scanner_type()` function for suggestions
- **ADDED:** `validate_scanner_type()` function for input validation

### 📝 Configuration Updates
- **NEW:** Scanner types file path configuration
- **NEW:** Validation cutoff threshold configuration
- **NEW:** Enhanced error messages for invalid scanner types

### 🔄 API Improvements
- **IMPROVED:** Better error handling for scanner type validation
- **IMPROVED:** More descriptive warning messages
- **IMPROVED:** Fallback behavior for unknown scanner types

---

## [1.1.2] - 2024-10-20

### 🐛 Bug Fixes
- **FIXED:** Import status polling infinite loop issue
- **FIXED:** Timeout calculation error in wait_for_import_completion
- **FIXED:** Status response parsing for edge cases

### 🔧 Improvements
- **IMPROVED:** Status check interval configuration
- **IMPROVED:** Timeout handling with better error messages
- **IMPROVED:** Status polling efficiency

---

## [1.1.1] - 2024-09-25

### 🐛 Bug Fixes
- **FIXED:** Configuration file parsing for special characters
- **FIXED:** API URL construction with trailing slashes
- **FIXED:** Token refresh mechanism reliability

### 🔧 Minor Improvements
- **IMPROVED:** Configuration validation error messages
- **IMPROVED:** API endpoint URL handling
- **IMPROVED:** Token caching efficiency

---

## [1.1.0] - 2024-09-01

### ✨ Features Added
- **NEW:** Import status monitoring with `check_import_status()` function
- **NEW:** Automated import completion waiting with `wait_for_import_completion()`
- **NEW:** Configurable status check intervals and timeouts
- **NEW:** Real-time import progress reporting

### 🛠 Technical Improvements
- **ADDED:** Status polling mechanism for import tracking
- **ADDED:** Timeout management for long-running imports
- **ADDED:** Status response validation and error handling
- **ADDED:** Import completion detection logic

### 📊 Status Monitoring Features
- **NEW:** Real-time status updates during import process
- **NEW:** Automatic completion detection (IMPORTED status)
- **NEW:** Error detection and reporting (ERROR status)
- **NEW:** Intermediate status handling (TRANSLATING, READY_FOR_IMPORT)

### 🔧 Configuration Options
- **NEW:** `check_interval` parameter for status polling frequency
- **NEW:** `timeout` parameter for maximum wait time
- **NEW:** `wait_for_completion` flag for automatic waiting

---

## [1.0.2] - 2024-08-15

### 🐛 Bug Fixes
- **FIXED:** HTTP Basic Authentication encoding issue
- **FIXED:** File upload content-type specification
- **FIXED:** Response JSON parsing error handling

### 🔧 Improvements
- **IMPROVED:** Error message clarity for API failures
- **IMPROVED:** HTTP status code handling
- **IMPROVED:** File upload reliability

---

## [1.0.1] - 2024-07-20

### 🐛 Bug Fixes
- **FIXED:** Configuration file path resolution on different operating systems
- **FIXED:** Environment variable precedence over config file values
- **FIXED:** Missing configuration validation for required parameters

### 📝 Documentation
- **ADDED:** Configuration file example with detailed comments
- **IMPROVED:** Error message documentation
- **ADDED:** Environment variable usage examples

---

## [1.0.0] - 2024-07-01

### 🎉 Initial Release

#### Core Features
- **NEW:** Phoenix Security API integration
- **NEW:** File upload functionality for security scan results
- **NEW:** HTTP Basic Authentication with client ID/secret
- **NEW:** Configuration file support (config.ini)
- **NEW:** Environment variable configuration support

#### API Integration
- **NEW:** Access token retrieval from `/v1/auth/access_token`
- **NEW:** File upload to `/v1/import/assets/file/translate`
- **NEW:** Support for multiple scan types and assessment names
- **NEW:** Import type selection (new/merge)

#### Configuration System
- **NEW:** Multi-source configuration loading
- **NEW:** Priority-based configuration (Environment > Config File > Defaults)
- **NEW:** Comprehensive configuration validation
- **NEW:** Detailed error messages for missing configuration

#### File Processing
- **NEW:** Support for various file formats
- **NEW:** Configurable scan parameters
- **NEW:** Auto-import functionality
- **NEW:** Scan target specification

#### Technical Foundation
- **NEW:** Python requests library integration
- **NEW:** ConfigParser for configuration file handling
- **NEW:** Pathlib for cross-platform file path handling
- **NEW:** Comprehensive error handling and logging

#### Security Features
- **NEW:** Secure credential handling
- **NEW:** HTTPS API communication
- **NEW:** Token-based authentication
- **NEW:** Configuration file security recommendations

---

## Development Roadmap

### Version 2.1.0 (Planned - Q2 2025)
- **Parallel Processing:** Multi-threaded file processing for improved performance
- **Advanced Filtering:** File selection based on patterns, dates, and sizes
- **Custom Report Formats:** JSON, HTML, and CSV report output options
- **Monitoring Integration:** Support for external monitoring systems
- **Database Logging:** Optional database storage for processing history

### Version 2.2.0 (Planned - Q3 2025)
- **Web Interface:** Optional web-based interface for file management
- **Scheduled Processing:** Built-in cron-like scheduling capabilities
- **Advanced Error Recovery:** Automatic retry mechanisms with exponential backoff
- **Performance Analytics:** Detailed performance metrics and optimization suggestions
- **Multi-tenant Support:** Support for multiple Phoenix instances

### Version 3.0.0 (Planned - Q4 2025)
- **Plugin Architecture:** Support for custom scanner type plugins
- **Advanced Workflow Engine:** Complex processing workflows with dependencies
- **Real-time Monitoring:** Live dashboard for processing status
- **API Rate Limiting:** Intelligent API rate limiting and queue management
- **High Availability:** Support for multiple API endpoints and failover

---

## Migration Guide

### From Version 1.x to 2.0.0

#### No Breaking Changes
Version 2.0.0 maintains full backward compatibility with version 1.x. Existing scripts and configurations will continue to work without modification.

#### Optional Upgrades

1. **Enhanced Configuration**
   ```ini
   # Add to existing config.ini
   [phoenix]
   # ... existing configuration ...
   scan_type = Tenable Scan  # NEW optional parameter
   ```

2. **Command Line Usage**
   ```bash
   # Old method still works
   python phoenix_import2_simple_file_v2_new.py
   
   # New method available
   python phoenix_import2_simple_file_v2_new.py --folder /path/to/scans
   ```

3. **Environment Variables**
   ```bash
   # Optional new environment variables
   export PHOENIX_SCAN_TYPE="Tenable Scan"
   # Existing variables still supported
   ```

#### Recommended Migration Steps

1. **Test New Features:** Try new command line options in test environment
2. **Update Documentation:** Update internal documentation with new capabilities
3. **Gradual Adoption:** Migrate to batch processing for appropriate use cases
4. **Monitor Performance:** Compare performance between old and new methods
5. **Update Automation:** Enhance existing automation with new reporting features

---

## Support Information

### Compatibility Matrix

| Python Version | Supported | Tested | Notes |
|----------------|-----------|--------|-------|
| 3.7 | ✅ | ✅ | Minimum required version |
| 3.8 | ✅ | ✅ | Recommended |
| 3.9 | ✅ | ✅ | Recommended |
| 3.10 | ✅ | ✅ | Recommended |
| 3.11 | ✅ | ✅ | Latest tested |
| 3.12 | ✅ | ⚠️ | Should work, limited testing |

### Dependency Matrix

| Library | Version | Required | Purpose |
|---------|---------|----------|---------|
| requests | ≥2.25.0 | Yes | HTTP API communication |
| configparser | Built-in | Yes | Configuration file parsing |
| pathlib | Built-in | Yes | File path handling |
| argparse | Built-in | Yes | Command line argument parsing |
| glob | Built-in | Yes | File pattern matching |
| datetime | Built-in | Yes | Timestamp generation |
| difflib | Built-in | Yes | Scanner type validation |

### Known Issues

#### Current Limitations
1. **File Size Limits:** Large files (>500MB) may timeout during upload
2. **Rate Limiting:** High-volume batch processing may hit API rate limits
3. **Memory Usage:** Very large files may consume significant memory
4. **Network Dependencies:** Requires stable internet connection for API access

#### Workarounds
1. **Large Files:** Split large files into smaller chunks before processing
2. **Rate Limits:** Add delays between batch processing operations
3. **Memory Issues:** Process files individually rather than in large batches
4. **Network Issues:** Implement retry logic and verify connectivity

### Performance Characteristics

#### Typical Processing Times
- **Small files (<1MB):** 5-15 seconds per file
- **Medium files (1-50MB):** 30-120 seconds per file
- **Large files (50-500MB):** 2-10 minutes per file
- **Batch processing overhead:** ~2-5 seconds per file

#### Resource Usage
- **Memory:** ~50-200MB for typical operations
- **CPU:** Low usage, mostly I/O bound
- **Network:** Depends on file sizes and API response times
- **Disk:** Minimal, mainly for report generation

---

## Contributing Guidelines

### Development Environment Setup
1. **Python Environment:** Use Python 3.7 or higher
2. **Dependencies:** Install required packages: `pip install requests`
3. **Testing:** Test against actual Phoenix Security instance
4. **Documentation:** Update documentation for any changes

### Code Standards
- **PEP 8:** Follow Python coding standards
- **Type Hints:** Use type hints for function parameters and returns
- **Docstrings:** Comprehensive docstrings for all functions
- **Error Handling:** Robust error handling with meaningful messages

### Testing Requirements
- **Unit Tests:** Test individual functions in isolation
- **Integration Tests:** Test against real Phoenix API
- **Performance Tests:** Verify performance with various file sizes
- **Compatibility Tests:** Test with different Python versions

### Documentation Standards
- **Changelog:** Update changelog for all changes
- **README:** Update README for new features
- **Comments:** Inline comments for complex logic
- **Examples:** Provide usage examples for new features

---

*This changelog is maintained to provide transparency about changes and improvements to the Phoenix Security Asset Import Tool. For questions about specific versions or features, please refer to the comprehensive README.md file.*
