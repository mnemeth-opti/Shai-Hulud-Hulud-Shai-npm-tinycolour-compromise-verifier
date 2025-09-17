# Phoenix Security Asset Import Tool

A comprehensive Python tool for importing security scan results into Phoenix Security platform with support for both single file and batch processing operations.

## Table of Contents

- [Overview](#overview)
- [Features](#features)
- [Recent Updates](#recent-updates)
- [Installation](#installation)
- [Configuration](#configuration)
- [Usage](#usage)
- [File Processing](#file-processing)
- [Report Generation](#report-generation)
- [Error Handling](#error-handling)
- [API Integration](#api-integration)
- [Examples](#examples)
- [Troubleshooting](#troubleshooting)
- [Best Practices](#best-practices)

## Overview

This tool provides a robust interface for importing security assessment data into the Phoenix Security platform. It supports various scan formats and offers both interactive single-file processing and automated batch processing capabilities with comprehensive reporting.

### Key Capabilities

- **Multi-format Support**: Handles CSV, JSON, XML, TXT, and Excel files
- **Batch Processing**: Process entire directories of scan files
- **Flexible Configuration**: Multiple configuration methods with priority hierarchy
- **Real-time Monitoring**: Track import progress with status updates
- **Comprehensive Reporting**: Detailed success/failure reports with metrics (screen or file output)
- **Scanner Validation**: Built-in scanner type validation against 156+ known scanner types
- **Legacy Compatibility**: Maintains backward compatibility with existing workflows

## Features

### Core Functionality

- ✅ **Batch File Processing** - Process multiple files in a single operation
- ✅ **Single File Import** - Individual file processing with detailed feedback
- ✅ **Auto-discovery** - Automatic detection of importable file types
- ✅ **Status Monitoring** - Real-time import status tracking
- ✅ **Error Recovery** - Robust error handling with detailed logging
- ✅ **Configuration Flexibility** - Multiple configuration sources and priorities

### Advanced Features

- ✅ **Scanner Type Validation** - Validates against 156+ known scanner types with fuzzy matching
- ✅ **Assessment Auto-naming** - Intelligent naming based on file names and timestamps
- ✅ **Import Type Selection** - Support for new and delta import modes
- ✅ **Comprehensive Reporting** - Detailed reports with success metrics (screen or file output)
- ✅ **Timeout Management** - Configurable timeouts for long-running imports
- ✅ **Retry Logic** - Built-in retry mechanisms for transient failures
- ✅ **Default File Processing** - Uses scan_file from config when no arguments provided

## Recent Updates

### Version 2.0.1 - January 2025 🔧

**Critical Fixes & Enhancements:**

- **🐛 FIXED:** Function scope issue causing "name 'send_results' is not defined" error
- **🐛 FIXED:** Global variable dependency issues in API functions
- **✨ NEW:** Enhanced scanner type validation using Scanner_Selection.txt (156+ scanner types)
- **✨ NEW:** Default scan file support via `scan_file` configuration parameter
- **✨ NEW:** Screen-only report display (saves to file only when --report_file specified)
- **🔧 IMPROVED:** Better error messages and scanner type recommendations
- **🔧 IMPROVED:** Function parameter handling for API calls
- **📝 UPDATED:** Configuration examples with new scan_file parameter

**Breaking Changes:** None - fully backward compatible

**Migration:** No changes required for existing users

## Installation

### Prerequisites

- Python 3.7 or higher
- Required Python packages:
  ```bash
  pip install requests configparser pathlib
  ```

### Setup

1. **Download the Script**
   ```bash
   # Place the script in your desired directory
   cp phoenix_import2_simple_file_v2_new.py /path/to/your/tools/
   ```

2. **Create Configuration File**
   ```bash
   # Copy the example configuration
   cp config.ini.example config.ini
   # Edit with your credentials
   nano config.ini
   ```

3. **Set Execute Permissions**
   ```bash
   chmod +x phoenix_import2_simple_file_v2_new.py
   ```

## Configuration

The tool supports multiple configuration methods with the following priority order (highest to lowest):

1. **Command Line Arguments** (Highest Priority)
2. **Environment Variables**
3. **Configuration File**
4. **Default Values** (Lowest Priority)

### Configuration File Format

Create a `config.ini` file in the same directory as the script:

```ini
[phoenix]
# Phoenix Security API Configuration
client_id = YOUR_CLIENT_ID
client_secret = YOUR_CLIENT_SECRET
api_base_url = https://api.your-phoenix-instance.com
scan_type = Tenable Scan

# Default scan file to process if no --file or --folder is specified
# scan_file = nessus-import.csv
```

### Environment Variables

Set these environment variables for system-wide configuration:

```bash
export PHOENIX_CLIENT_ID="your_client_id"
export PHOENIX_CLIENT_SECRET="your_client_secret"
export PHOENIX_API_BASE_URL="https://api.your-phoenix-instance.com"
export PHOENIX_SCAN_TYPE="Tenable Scan"
export PHOENIX_SCAN_FILE="nessus-import.csv"  # Optional default scan file
```

### Command Line Override

Any configuration can be overridden via command line arguments:

```bash
python phoenix_import2_simple_file_v2_new.py \
  --client_id "override_client_id" \
  --phoenix_api_url "https://api.different-instance.com"
```

## Usage

### Command Line Interface

```bash
python phoenix_import2_simple_file_v2_new.py [OPTIONS]
```

### Required Arguments

**One of the following must be specified (or use scan_file in config):**

- `--folder PATH` - Process all importable files in the specified directory
- `--file PATH` - Process a single file
- No arguments - Uses `scan_file` from configuration

### Optional Arguments

#### Authentication
- `--client_id ID` - Phoenix API Client ID
- `--client_secret SECRET` - Phoenix API Client Secret  
- `--phoenix_api_url URL` - Phoenix API base URL

#### Import Configuration
- `--scan_type TYPE` - Scanner type (validated against 156+ known types)
- `--import_type {new,delta}` - Import type (default: new)

#### File Management
- `--config_file PATH` - Custom configuration file path
- `--report_file PATH` - Custom report output path (optional - displays on screen if not specified)

### Usage Modes

#### 1. Batch Processing Mode
Process all files in a directory:

```bash
python phoenix_import2_simple_file_v2_new.py \
  --folder /path/to/scan/files \
  --scan_type "Tenable Scan" \
  --import_type new
```

#### 2. Single File Mode
Process one specific file:

```bash
python phoenix_import2_simple_file_v2_new.py \
  --file /path/to/specific/scan.csv \
  --scan_type "SonarQube Scan"
```

#### 3. Configuration File Mode
Use configuration file for credentials:

```bash
python phoenix_import2_simple_file_v2_new.py \
  --folder /path/to/scans \
  --config_file /path/to/custom/config.ini
```

#### 4. Environment Variable Mode
Rely on environment variables:

```bash
# Set environment variables first
export PHOENIX_CLIENT_ID="your_id"
export PHOENIX_CLIENT_SECRET="your_secret"
export PHOENIX_API_BASE_URL="https://api.phoenix.com"
export PHOENIX_SCAN_TYPE="Aqua Scan"

# Then run with minimal arguments
python phoenix_import2_simple_file_v2_new.py --folder /path/to/scans
```

#### 5. Default File Processing Mode
Run without arguments to use default scan file from configuration:

```bash
python phoenix_import2_simple_file_v2_new.py
# Uses scan_file from config.ini or hardcoded parameters for backward compatibility
```

#### 6. Screen-Only Reports
Process files with report displayed on screen only (no file saved):

```bash
python phoenix_import2_simple_file_v2_new.py --folder /path/to/scans
# Report displays on screen, no file created unless --report_file specified
```

## File Processing

### Supported File Types

The tool automatically detects and processes these file formats:

| Extension | Description | Common Use Case |
|-----------|-------------|-----------------|
| `.csv` | Comma-separated values | Vulnerability scan exports |
| `.json` | JSON format | API responses, structured data |
| `.xml` | XML format | Nessus files, SAST reports |
| `.txt` | Plain text | Custom format exports |
| `.xlsx` | Excel spreadsheet | Manual reports, consolidated data |

### File Discovery Process

When using `--folder` mode:

1. **Directory Scan** - Recursively searches the specified directory
2. **Pattern Matching** - Identifies files matching supported extensions
3. **Validation** - Verifies file accessibility and readability
4. **Processing Queue** - Creates ordered list for sequential processing

### Automatic Naming Convention

For each processed file, the tool automatically generates:

#### Assessment Name Format
```
{filename_without_extension}_{timestamp}
```
**Example:** `vulnerability_scan_20250115_143022`

#### Scan Target Format
```
{filename_without_extension}
```
**Example:** `vulnerability_scan`

### Scanner Type Validation

The tool validates scanner types against 156+ known scanner types from `Scanner_Selection.txt`:

- **Valid Types**: Displays confirmation message
- **Invalid Types**: Suggests closest match using fuzzy matching
- **Unknown Types**: Shows available options and uses provided type with warning

**Example Scanner Types:**
- Tenable Scan
- SonarQube Scan
- Aqua Scan
- Nessus Scan
- SAST Scan
- And 150+ more...

## Report Generation

### Report Output Options

**Screen Display (Default):**
Reports are displayed on screen by default. No file is created unless explicitly requested.

**File Output:**
Specify a custom report file location:
```bash
python phoenix_import2_simple_file_v2_new.py \
  --folder /path/to/scans \
  --report_file /custom/path/my_report.txt
```

### Report Structure

#### Header Section
```
================================================================================
PHOENIX SECURITY ASSET IMPORT REPORT
================================================================================
Generated: 2025-01-15 14:30:22
```

#### Summary Section
```
SUMMARY:
  Total files processed: 10
  Successful imports: 8
  Failed imports: 2
  Success rate: 80.0%
```

#### Successful Imports Section
```
✅ SUCCESSFUL IMPORTS:
----------------------------------------
  File: /data/scans/nessus_scan_001.csv
  Assessment: nessus_scan_001_20250115_143022
  Scan Type: Tenable Scan
  Request ID: 12345678-1234-5678-9abc-123456789012
  Status: IMPORTED
```

#### Failed Imports Section
```
❌ FAILED IMPORTS:
----------------------------------------
  File: /data/scans/corrupted_file.csv
  Assessment: corrupted_file_20250115_143025
  Scan Type: Tenable Scan
  Error: Failed to authenticate with API
```

## Error Handling

### Error Categories

#### 1. Configuration Errors
- Missing required parameters
- Invalid authentication credentials
- Malformed configuration files

#### 2. File System Errors
- Non-existent files or directories
- Permission denied errors
- Corrupted or unreadable files

#### 3. Network Errors
- API connectivity issues
- Timeout errors
- Rate limiting responses

#### 4. API Errors
- Authentication failures
- Invalid request formats
- Server-side processing errors

#### 5. Scanner Validation Errors
- Invalid scanner types with suggestions
- Missing Scanner_Selection.txt file

### Error Recovery Mechanisms

#### Graceful Degradation
- Failed files don't stop batch processing
- Detailed error logging for troubleshooting
- Continuation of processing for remaining files

#### Retry Logic
- Automatic retries for transient network issues
- Configurable timeout periods
- Exponential backoff for rate limiting

#### Validation Safeguards
- Pre-flight checks for configuration
- File existence validation before processing
- Scanner type validation with suggestions

## API Integration

### Authentication Flow

1. **Credential Validation** - Verify client ID and secret are provided
2. **Token Request** - Submit credentials to `/v1/auth/access_token` endpoint
3. **Token Storage** - Cache token for subsequent requests
4. **Token Refresh** - Automatic token renewal as needed

### Import Process

1. **File Upload** - Submit file to `/v1/import/assets/file/translate` endpoint
2. **Request Tracking** - Receive unique request ID for status monitoring
3. **Status Polling** - Periodically check import progress
4. **Completion Detection** - Identify successful or failed completion
5. **Result Collection** - Gather final import status and metadata

### API Endpoints Used

| Endpoint | Purpose | Method |
|----------|---------|--------|
| `/v1/auth/access_token` | Authentication | GET |
| `/v1/import/assets/file/translate` | File upload | POST |
| `/v1/import/assets/file/translate/request/{id}` | Status check | GET |

## Examples

### Basic Examples

#### Process Single CSV File
```bash
python phoenix_import2_simple_file_v2_new.py \
  --file /data/nessus_scan.csv \
  --client_id "your_client_id" \
  --client_secret "your_secret" \
  --phoenix_api_url "https://api.phoenix.com" \
  --scan_type "Tenable Scan"
```

#### Process All Files in Directory with Screen Report
```bash
python phoenix_import2_simple_file_v2_new.py \
  --folder /data/security_scans \
  --scan_type "SonarQube Scan" \
  --import_type delta
# Report displays on screen only
```

#### Process with File Report
```bash
python phoenix_import2_simple_file_v2_new.py \
  --folder /data/security_scans \
  --scan_type "Aqua Scan" \
  --report_file /reports/import_results.txt
```

### Advanced Examples

#### Using Default Scan File from Config
```bash
# Add to config.ini: scan_file = daily_scan.csv
python phoenix_import2_simple_file_v2_new.py
# Processes daily_scan.csv from config, displays report on screen
```

#### Environment Variable Configuration
```bash
#!/bin/bash
# setup_and_run.sh

export PHOENIX_CLIENT_ID="prod_client_123"
export PHOENIX_CLIENT_SECRET="secret_key_456"
export PHOENIX_API_BASE_URL="https://api.production.phoenix.com"
export PHOENIX_SCAN_TYPE="Aqua Scan"
export PHOENIX_SCAN_FILE="default_scan.csv"

python phoenix_import2_simple_file_v2_new.py
# Uses environment variables and default scan file
```

### Integration Examples

#### Automated Daily Processing
```bash
#!/bin/bash
# daily_import.sh - Cron job script

LOG_DIR="/var/log/phoenix"
SCAN_DIR="/data/daily_scans"
DATE=$(date +%Y%m%d)

echo "Starting daily import process at $(date)" >> "$LOG_DIR/daily.log"

python /opt/phoenix/phoenix_import2_simple_file_v2_new.py \
  --folder "$SCAN_DIR" \
  --import_type new \
  --report_file "$LOG_DIR/import_$DATE.txt" \
  >> "$LOG_DIR/daily.log" 2>&1

echo "Daily import completed at $(date)" >> "$LOG_DIR/daily.log"
```

## Troubleshooting

### Common Issues and Solutions

#### Issue: Function Scope Errors
```
❌ Failed: filename.csv - name 'send_results' is not defined
```
**Solution:**
- This was a known issue in earlier versions, fixed in v2.0.1
- Update to the latest version of the script
- Ensure all API functions are properly imported

#### Issue: Missing Configuration
```
Error: Missing required configuration: CLIENT_ID, CLIENT_SECRET
```
**Solution:**
- Verify configuration file exists and has correct format
- Check environment variables are set correctly
- Provide values via command line arguments
- Use `scan_file` parameter in config for default file processing

#### Issue: No Files Found
```
Error: No importable files found in folder: /path/to/folder
```
**Solution:**
- Verify folder path exists
- Check folder contains supported file types (.csv, .json, .xml, .txt, .xlsx)
- Verify file permissions allow reading
- Use `scan_file` in config.ini for single file processing without arguments

#### Issue: Scanner Type Validation
```
❌ Warning: 'Custom Scanner' is not a valid scanner type.
💡 Did you mean 'SonarQube Scan'?
🔄 Using 'SonarQube Scan' instead.
```
**Solution:**
- Use suggested scanner type from the 156+ available types
- Check Scanner_Selection.txt for valid scanner types
- Update configuration with valid scanner type
- The tool will auto-correct to closest match when possible

#### Issue: Authentication Failure
```
Failed to obtain token: 401 Unauthorized
```
**Solution:**
- Verify client ID and secret are correct
- Check API URL is accessible
- Confirm credentials have necessary permissions

### Debug Strategies

#### 1. Test with Single File
Start with a small, known-good file to verify configuration:
```bash
python phoenix_import2_simple_file_v2_new.py \
  --file /path/to/small_test.csv \
  --scan_type "Tenable Scan"
```

#### 2. Test Default Configuration
Test using scan_file from config without arguments:
```bash
# Add to config.ini: scan_file = test.csv
python phoenix_import2_simple_file_v2_new.py
```

#### 3. Verify Scanner Type Validation
Test scanner type validation:
```bash
python -c "
from phoenix_import2_simple_file_v2_new import validate_scanner_type
result = validate_scanner_type('Tenable Scan')
print('Validated scanner type:', result)
"
```

### Log Analysis

#### Console Output Patterns
```bash
# Successful processing with validation
✅ Scanner type 'Tenable Scan' is valid.
🚀 Starting Phoenix Security Asset Import
🔄 Processing file: /data/scan.csv
✅ Success: scan.csv

# Failed processing with suggestions
❌ Warning: 'Custom Scanner' is not a valid scanner type.
💡 Did you mean 'SonarQube Scan'?
🔄 Using 'SonarQube Scan' instead.
❌ Failed: bad_scan.csv - Authentication failed
```

#### Screen Report Display
When no --report_file is specified, reports display on screen:
```bash
📊 IMPORT REPORT:
================================================================================
PHOENIX SECURITY ASSET IMPORT REPORT
================================================================================
Generated: 2025-01-20 11:52:42

SUMMARY:
  Total files processed: 6
  Successful imports: 4
  Failed imports: 2
  Success rate: 66.7%
```

## Best Practices

### Security Practices

#### 1. Credential Management
- **Never hardcode credentials** in scripts or configuration files
- **Use environment variables** for production deployments
- **Implement credential rotation** for long-running systems
- **Restrict file permissions** on configuration files (600)

#### 2. Network Security
- **Use HTTPS endpoints** for all API communications
- **Implement certificate validation** for API connections
- **Use firewall rules** to restrict API access
- **Monitor API usage** for unusual patterns

### Operational Practices

#### 1. File Organization
- **Organize scan files** in dated directories
- **Use consistent naming** conventions for files
- **Implement file retention** policies
- **Create backup copies** of important scan data

#### 2. Configuration Management
- **Test with single files** before batch processing
- **Use config files** for credentials security
- **Validate scanner types** against Phoenix requirements
- **Use screen reports** for quick checks, file reports for auditing

#### 3. Monitoring and Alerting
- **Monitor import success rates** over time
- **Set up alerts** for failed imports
- **Track processing times** for performance analysis
- **Review screen reports** for immediate feedback

### Performance Optimization

#### 1. Batch Size Management
- **Process files in manageable batches** to avoid memory issues
- **Monitor system resources** during processing
- **Adjust timeouts** based on file sizes

#### 2. Network Optimization
- **Use persistent connections** when possible
- **Monitor bandwidth usage** during uploads
- **Implement retry logic** with exponential backoff

---

## Support and Maintenance

### Version Compatibility
- **Python 3.7+** required
- **Requests library 2.25+** recommended
- **Phoenix API v1** compatible

### Known Limitations
- **File size limits** based on Phoenix API constraints
- **Rate limiting** may affect high-volume processing
- **Network timeouts** for very large files
- **Scanner type validation** requires Scanner_Selection.txt file

### Future Enhancements
- **Parallel processing** for improved performance
- **Advanced filtering** options for file selection
- **Custom report formats** (JSON, HTML, CSV)
- **Integration with monitoring systems**
- **Enhanced error recovery** mechanisms

---

*This tool is designed for enterprise security operations and supports integration with automated security workflows. The latest version includes comprehensive fixes for function scope issues and enhanced scanner type validation with 156+ supported scanner types.*
