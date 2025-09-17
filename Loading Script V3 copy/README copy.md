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
- **Comprehensive Reporting**: Detailed success/failure reports with metrics
- **Scanner Validation**: Built-in scanner type validation with suggestions
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
- **🐛 FIXED:** Configuration file parsing errors with duplicate batch entries
- **🐛 FIXED:** Indentation errors in batch processing code
- **🐛 FIXED:** Proper batch configuration format using `[batch-N]` sections
- **✨ NEW:** Enhanced scanner type validation using Scanner_Selection.txt (156+ scanner types)
- **✨ NEW:** Default scan file support via `scan_file` configuration parameter
- **✨ NEW:** Screen-only report display (saves to file only when --report_file specified)
- **✨ NEW:** Advanced batch processing system with configuration-driven batches
- **✨ NEW:** Priority system ensuring `--folder` overrides batch processing
- **🔧 IMPROVED:** Better error messages and scanner type recommendations
- **🔧 IMPROVED:** Function parameter handling for API calls
- **📝 UPDATED:** Configuration examples with proper batch configuration format

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

**One of the following must be specified:**

- `--folder PATH` - Process all importable files in the specified directory
- `--file PATH` - Process a single file

### Optional Arguments

#### Authentication
- `--client_id ID` - Phoenix API Client ID
- `--client_secret SECRET` - Phoenix API Client Secret  
- `--phoenix_api_url URL` - Phoenix API base URL

#### Import Configuration
- `--scan_type TYPE` - Scanner type (e.g., "Tenable Scan", "SonarQube Scan")
- `--import_type {new,delta}` - Import type (default: new)

#### File Management
- `--config_file PATH` - Custom configuration file path
- `--report_file PATH` - Custom report output path

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

#### 5. Legacy Mode / Default File Processing
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

## Advanced Batch Processing

### Configuration-Driven Batch Processing

The tool supports advanced batch processing through configuration files, allowing you to define multiple batches with different settings for each batch.

#### Batch Configuration Format

Define multiple batches in your `config.ini` file using `[batch-N]` sections:

```ini
[phoenix]
client_id = your_client_id
client_secret = your_client_secret
api_base_url = https://api.poc1.appsecphx.io
scan_type = Tenable Scan
batch_delay = 2

[batch-1]
file_path = import-file/usb_cis_db_auth_20250819.csv
scan_type = Tenable Scan
assessment_name = usb_cis_db_auth_20250819
import_type = new
scan_target = usb_cis_db_auth_20250819
auto_import = True
wait_for_completion = True

[batch-2]
file_path = import-file/usb_cis_jun_auth_20250819.csv
scan_type = SonarQube Scan
assessment_name = usb_cis_jun_auth_20250819
import_type = delta
scan_target = usb_cis_jun_auth_20250819
auto_import = True
wait_for_completion = True

[batch-3]
file_path = import-file/usb_cis_lnx_auth_20250819.csv
scan_type = Aqua Scan
assessment_name = usb_cis_lnx_auth_20250819
import_type = new
scan_target = usb_cis_lnx_auth_20250819
auto_import = True
wait_for_completion = True
```

#### Batch Processing Modes

1. **Automatic Batch Processing** (when no `--folder` or `--file` specified):
   ```bash
   python phoenix_import2_batch_file_v2_new.py
   # Processes all [batch-N] sections from config.ini
   ```

2. **Interactive Batch Processing**:
   ```bash
   python phoenix_import2_batch_file_v2_new.py --interactive
   # Prompts for confirmation before each batch
   ```

3. **Fast Batch Processing** (no delays):
   ```bash
   python phoenix_import2_batch_file_v2_new.py --no_delay
   # Skips delays between batches
   ```

4. **Custom Batch Delay**:
   ```bash
   python phoenix_import2_batch_file_v2_new.py --batch_delay 5
   # Sets 5-second delay between batches
   ```

### Processing Priority System

The tool uses a clear priority system to determine processing mode:

1. **`--folder` argument** (Highest Priority)
   - Processes all files in specified folder
   - Completely overrides batch processing
   - Uses command-line or config settings for all files

2. **`--file` argument**
   - Processes single specified file
   - Overrides batch processing and config scan_file

3. **`scan_file` from configuration**
   - Processes single file specified in config
   - Used when no command-line file arguments provided

4. **Batch processing from configuration** (Lowest Priority)
   - Only activated when no file/folder arguments provided
   - Processes all `[batch-N]` sections in sequence

### Batch Processing Features

#### Intelligent Delay Management
- **Automatic delays** between batches to prevent API overload
- **File size-based delays** for larger files
- **Configurable delays** via `--batch_delay` or config file
- **Skip delays** option with `--no_delay` flag

#### Interactive Mode
- **Confirmation prompts** before each batch
- **Batch information display** (file, scanner type, assessment name)
- **Skip/Continue/Quit options** for flexible control
- **Real-time batch summaries**

#### Comprehensive Reporting
- **Individual batch reports** with success/failure metrics
- **Overall summary** across all batches
- **Detailed error logging** for failed batches
- **Success rate calculations** per batch and overall

#### Error Handling
- **Continue on error** - Failed batches don't stop processing
- **Detailed error context** in reports
- **Batch isolation** - Errors in one batch don't affect others
- **Graceful degradation** for configuration issues

### Example Batch Processing Workflows

#### Workflow 1: Daily Security Scan Processing
```bash
# config.ini setup for daily scans
[phoenix]
client_id = daily_scanner_client
client_secret = daily_scanner_secret
api_base_url = https://api.prod.appsecphx.io
batch_delay = 10

[batch-1]
file_path = daily-scans/nessus-scan.csv
scan_type = Tenable Scan
assessment_name = daily_nessus_scan
import_type = delta

[batch-2]
file_path = daily-scans/sonar-results.json
scan_type = SonarQube Scan
assessment_name = daily_sonar_scan
import_type = delta

# Run with interactive confirmation
python phoenix_import2_batch_file_v2_new.py --interactive
```

#### Workflow 2: Weekly Comprehensive Assessment
```bash
# Process multiple scanner outputs with different settings
[batch-1]
file_path = weekly/aqua-container-scan.json
scan_type = Aqua Scan
assessment_name = weekly_container_security
import_type = new

[batch-2]  
file_path = weekly/nessus-infrastructure.csv
scan_type = Tenable Scan
assessment_name = weekly_infrastructure_scan
import_type = new

[batch-3]
file_path = weekly/sonar-code-analysis.xml
scan_type = SonarQube Scan
assessment_name = weekly_code_quality
import_type = new

# Run with custom delays
python phoenix_import2_batch_file_v2_new.py --batch_delay 30
```

#### Workflow 3: Mixed Processing Modes
```bash
# Override batch processing with folder mode
python phoenix_import2_batch_file_v2_new.py --folder emergency-scans/
# Processes all files in folder, ignoring batch configurations

# Then run batch processing separately
python phoenix_import2_batch_file_v2_new.py
# Processes configured batches
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

### Processing Workflow

1. **File Validation** - Verify file exists and is readable
2. **Scanner Type Validation** - Check against known scanner types
3. **API Authentication** - Obtain access token
4. **File Upload** - Submit file to Phoenix API
5. **Status Monitoring** - Track import progress
6. **Result Collection** - Gather final status and metadata
7. **Report Generation** - Add results to comprehensive report

## Report Generation

### Report Structure

The tool generates comprehensive reports in text format with the following sections:

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

**Auto-Generated File Names:**
When saving to file without specifying a name, reports are automatically named:
```
import_report_YYYYMMDD_HHMMSS.txt
```
**Example:** `import_report_20250115_143022.txt`

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

### Error Reporting

All errors are captured and reported in multiple ways:

1. **Console Output** - Real-time error messages during processing
2. **Report File** - Detailed error descriptions in final report
3. **Exit Codes** - Standard exit codes for script automation

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

### Request Parameters

#### File Upload Parameters
- `scanType` - Type of security scanner
- `assessmentName` - Unique assessment identifier
- `importType` - Import mode (new/delta)
- `scanTarget` - Target system identifier
- `autoImport` - Automatic import flag (always true)

#### Status Check Parameters
- `request_id` - Unique request identifier from upload response

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

#### Process All Files in Directory
```bash
python phoenix_import2_simple_file_v2_new.py \
  --folder /data/security_scans \
  --scan_type "SonarQube Scan" \
  --import_type delta
```

### Advanced Examples

#### Using Custom Configuration File
```bash
python phoenix_import2_simple_file_v2_new.py \
  --folder /data/scans \
  --config_file /etc/phoenix/production.ini \
  --report_file /var/log/phoenix_import.log
```

#### Environment Variable Configuration
```bash
#!/bin/bash
# setup_and_run.sh

export PHOENIX_CLIENT_ID="prod_client_123"
export PHOENIX_CLIENT_SECRET="secret_key_456"
export PHOENIX_API_BASE_URL="https://api.production.phoenix.com"
export PHOENIX_SCAN_TYPE="Aqua Scan"

python phoenix_import2_simple_file_v2_new.py \
  --folder /data/daily_scans \
  --import_type new \
  --report_file "/reports/daily_$(date +%Y%m%d).txt"
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

#### Jenkins Pipeline Integration
```groovy
pipeline {
    agent any
    
    environment {
        PHOENIX_CLIENT_ID = credentials('phoenix-client-id')
        PHOENIX_CLIENT_SECRET = credentials('phoenix-client-secret')
        PHOENIX_API_BASE_URL = 'https://api.phoenix.com'
    }
    
    stages {
        stage('Import Security Scans') {
            steps {
                script {
                    sh '''
                        python phoenix_import2_simple_file_v2_new.py \
                          --folder ./scan_results \
                          --scan_type "SonarQube Scan" \
                          --import_type new \
                          --report_file ./import_report.txt
                    '''
                }
            }
        }
        
        stage('Archive Report') {
            steps {
                archiveArtifacts artifacts: 'import_report.txt'
            }
        }
    }
}
```

## Troubleshooting

### Common Issues and Solutions

#### Issue: Missing Configuration
```
Error: Missing required configuration: CLIENT_ID, CLIENT_SECRET
```
**Solution:**
- Verify configuration file exists and has correct format
- Check environment variables are set correctly
- Provide values via command line arguments

#### Issue: Authentication Failure
```
Failed to obtain token: 401 Unauthorized
```
**Solution:**
- Verify client ID and secret are correct
- Check API URL is accessible
- Confirm credentials have necessary permissions

#### Issue: No Files Found
```
Error: No importable files found in folder: /path/to/folder
```
**Solution:**
- Verify folder path exists
- Check folder contains supported file types (.csv, .json, .xml, .txt, .xlsx)
- Verify file permissions allow reading

#### Issue: Scanner Type Validation
```
Warning: 'Custom Scanner' is not a valid scanner type.
Did you mean 'SonarQube Scan'?
```
**Solution:**
- Use suggested scanner type
- Check available scanner types in Phoenix
- Update configuration with valid scanner type

#### Issue: Import Timeout
```
Import timed out after 3600 seconds
```
**Solution:**
- Check file size and complexity
- Verify Phoenix server is responding
- Consider splitting large files

### Debug Strategies

#### 1. Test with Single File
Start with a small, known-good file to verify configuration:
```bash
python phoenix_import2_simple_file_v2_new.py \
  --file /path/to/small_test.csv \
  --scan_type "Tenable Scan"
```

#### 2. Verify Configuration
Test configuration loading:
```bash
python -c "
from phoenix_import2_simple_file_v2_new import load_configuration
config = load_configuration()
print('Config loaded:', config)
"
```

#### 3. Check API Connectivity
Test API connection:
```bash
python -c "
from phoenix_import2_simple_file_v2_new import get_access_token
token = get_access_token('client_id', 'client_secret')
print('Token obtained:', bool(token))
"
```

#### 4. Monitor Network Traffic
Use network monitoring to debug API issues:
```bash
# Monitor HTTP traffic
tcpdump -i any -s 0 -A 'host api.phoenix.com'
```

### Log Analysis

#### Console Output Patterns
```bash
# Successful processing
🚀 Starting Phoenix Security Asset Import
🔄 Processing file: /data/scan.csv
✅ Success: scan.csv

# Failed processing
🔄 Processing file: /data/bad_scan.csv
❌ Failed: bad_scan.csv - Authentication failed
```

#### Report File Analysis
Check report files for patterns:
```bash
# Count successful vs failed imports
grep -c "✅ SUCCESSFUL" import_report.txt
grep -c "❌ FAILED" import_report.txt

# Extract error patterns
grep -A 3 "❌ FAILED" import_report.txt
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

#### 2. Monitoring and Alerting
- **Monitor import success rates** over time
- **Set up alerts** for failed imports
- **Track processing times** for performance analysis
- **Implement log rotation** for long-running systems

#### 3. Testing and Validation
- **Test with sample data** before production use
- **Validate scanner types** against Phoenix requirements
- **Verify file formats** before processing
- **Test error conditions** and recovery procedures

### Performance Optimization

#### 1. Batch Size Management
- **Process files in manageable batches** to avoid memory issues
- **Implement parallel processing** for large datasets
- **Monitor system resources** during processing
- **Adjust timeouts** based on file sizes

#### 2. Network Optimization
- **Use persistent connections** when possible
- **Implement connection pooling** for high-volume processing
- **Monitor bandwidth usage** during uploads
- **Implement retry logic** with exponential backoff

### Maintenance Practices

#### 1. Regular Updates
- **Keep the script updated** with latest features
- **Update scanner type definitions** as new scanners are added
- **Review and update configuration** files periodically
- **Test updates** in non-production environments first

#### 2. Documentation
- **Document configuration changes** and their reasons
- **Maintain runbooks** for common operations
- **Create troubleshooting guides** for team members
- **Document custom integrations** and modifications

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
- **Scanner type validation** requires valid scanner list file

### Future Enhancements
- **Parallel processing** for improved performance
- **Advanced filtering** options for file selection
- **Custom report formats** (JSON, HTML, CSV)
- **Integration with monitoring systems**
- **Enhanced error recovery** mechanisms

---

*This tool is designed for enterprise security operations and supports integration with automated security workflows. For additional features or custom integrations, please refer to the changelog and contact your system administrator.*
