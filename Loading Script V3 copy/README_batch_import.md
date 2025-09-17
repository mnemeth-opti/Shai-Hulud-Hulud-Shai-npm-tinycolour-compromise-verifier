# Phoenix Security Asset Import Tool - Batch Processing

This enhanced version of `phoenix_import2_simple_file_v2_new.py` now supports batch processing of multiple files in a folder with comprehensive command-line interface.

## Features

- **Batch Processing**: Process all files in a folder with `--folder` option
- **Single File Processing**: Process individual files with `--file` option  
- **Flexible Configuration**: Use config files, environment variables, or command-line arguments
- **Comprehensive Reporting**: Generates detailed reports of successful and failed imports
- **Auto-naming**: Automatically generates assessment names and scan targets from filenames
- **Legacy Support**: Maintains backward compatibility with existing usage

## Command Line Usage

### Basic Syntax
```bash
python phoenix_import2_simple_file_v2_new.py [OPTIONS]
```

### Required Arguments
Either `--folder` or `--file` must be specified:

- `--folder PATH`: Process all importable files in the specified folder
- `--file PATH`: Process a single file

### Authentication Options
- `--client_id ID`: Phoenix API Client ID (overrides config)
- `--client_secret SECRET`: Phoenix API Client Secret (overrides config)
- `--phoenix_api_url URL`: Phoenix API base URL (overrides config)

### Import Configuration
- `--scan_type TYPE`: Scanner type (overrides config)
- `--import_type TYPE`: Import type - `new` or `delta` (default: new)

### Optional Arguments
- `--config_file PATH`: Path to config file (default: config.ini)
- `--report_file PATH`: Path to save the report (default: auto-generated)

## Configuration Priority

Configuration values are loaded in this order (highest priority first):
1. Command line arguments
2. Environment variables
3. Config file (config.ini)
4. Defaults

### Environment Variables
- `PHOENIX_CLIENT_ID`
- `PHOENIX_CLIENT_SECRET` 
- `PHOENIX_API_BASE_URL`
- `PHOENIX_SCAN_TYPE`

### Config File Format
```ini
[phoenix]
client_id = YOUR_CLIENT_ID
client_secret = YOUR_CLIENT_SECRET
api_base_url = https://api.poc1.appsecphx.io
scan_type = Tenable Scan
```

## Usage Examples

### Process All Files in a Folder
```bash
python phoenix_import2_simple_file_v2_new.py \
  --folder /path/to/scan/files \
  --client_id YOUR_CLIENT_ID \
  --client_secret YOUR_CLIENT_SECRET \
  --phoenix_api_url https://api.poc1.appsecphx.io \
  --scan_type "Tenable Scan" \
  --import_type new
```

### Process Single File with Config File
```bash
python phoenix_import2_simple_file_v2_new.py \
  --file /path/to/scan.csv \
  --config_file /path/to/config.ini
```

### Using Environment Variables
```bash
export PHOENIX_CLIENT_ID="your_client_id"
export PHOENIX_CLIENT_SECRET="your_client_secret"
export PHOENIX_API_BASE_URL="https://api.poc1.appsecphx.io"
export PHOENIX_SCAN_TYPE="Tenable Scan"

python phoenix_import2_simple_file_v2_new.py --folder /path/to/scan/files
```

## File Processing

### Supported File Types
The tool automatically detects and processes these file types:
- `.csv` - Comma-separated values
- `.json` - JSON format
- `.xml` - XML format  
- `.txt` - Text files
- `.xlsx` - Excel files

### Automatic Naming
- **Assessment Name**: `{filename}_{timestamp}` (e.g., `scan_data_20250101_143022`)
- **Scan Target**: `{filename}` (e.g., `scan_data`)

## Report Generation

After processing, a detailed report is generated showing:

### Summary Section
- Total files processed
- Successful imports count
- Failed imports count
- Success rate percentage

### Successful Imports
For each successful import:
- File path
- Assessment name
- Scan type
- Request ID
- Final status

### Failed Imports  
For each failed import:
- File path
- Assessment name
- Scan type
- Error message

### Report Example
```
================================================================================
PHOENIX SECURITY ASSET IMPORT REPORT
================================================================================
Generated: 2025-01-15 14:30:22

SUMMARY:
  Total files processed: 5
  Successful imports: 4
  Failed imports: 1
  Success rate: 80.0%

✅ SUCCESSFUL IMPORTS:
----------------------------------------
  File: /data/nessus_scan1.csv
  Assessment: nessus_scan1_20250115_143022
  Scan Type: Tenable Scan
  Request ID: 12345678-1234-5678-9abc-123456789012
  Status: IMPORTED

❌ FAILED IMPORTS:
----------------------------------------
  File: /data/corrupt_file.csv
  Assessment: corrupt_file_20250115_143025
  Scan Type: Tenable Scan
  Error: Failed to get request ID or final status
```

## Error Handling

The tool includes comprehensive error handling:

- **Configuration Errors**: Missing required parameters
- **File Errors**: Non-existent files or folders
- **API Errors**: Authentication failures, network issues
- **Import Errors**: Scanner validation, processing failures

Failed imports don't stop the batch process - all files are attempted and results are reported.

## Legacy Mode

The script maintains backward compatibility. When run without command-line arguments, it operates in legacy mode using hardcoded parameters.

## Best Practices

1. **Test with Single Files**: Test configuration with `--file` before batch processing
2. **Use Config Files**: Store credentials in config files for security
3. **Monitor Reports**: Review generated reports for failed imports
4. **Validate Scanner Types**: Ensure scanner types match Phoenix requirements
5. **Organize Files**: Keep scan files organized in dedicated folders

## Troubleshooting

### Common Issues

**Missing Configuration**
```
Error: Missing required configuration: CLIENT_ID, CLIENT_SECRET
```
Solution: Provide credentials via command line, environment variables, or config file.

**No Files Found**
```
Error: No importable files found in folder: /path/to/folder
```
Solution: Ensure folder contains supported file types (.csv, .json, .xml, .txt, .xlsx).

**Authentication Failed**
```
Failed to obtain token: 401 Unauthorized
```
Solution: Verify client ID and secret are correct.

**Invalid Scanner Type**
```
Warning: 'Custom Scanner' is not a valid scanner type.
```
Solution: Use valid scanner types or the tool will suggest alternatives.

### Debug Tips

1. Start with a single file to test configuration
2. Check the generated report for detailed error messages
3. Verify file permissions and paths
4. Ensure API URL is accessible
5. Validate scanner type against Phoenix requirements
