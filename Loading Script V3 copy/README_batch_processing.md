# Enhanced Batch Processing Features

## Overview

The Phoenix Security Asset Import Tool now supports enhanced batch processing with configurable delays, interactive prompts, and comprehensive success rate reporting.

## New Features

### 1. Configurable Batch Delays

Control the delay between batch processing to avoid overwhelming the Phoenix API or to comply with rate limiting requirements.

#### Configuration Options:

**Config File (config.ini):**
```ini
[phoenix]
# Delay between batches in seconds (default: 10)
batch_delay = 2
```

**Environment Variable:**
```bash
export PHOENIX_BATCH_DELAY=5
```

**Command Line:**
```bash
python phoenix_import2_simple_file_v2_new.py --batch_delay 3
```

#### Special Options:
- `--no_delay` - Skip all delays between batches
- `--batch_delay 0` - Set delay to 0 seconds

### 2. Interactive Batch Processing

Get prompted before each batch to review and confirm processing.

```bash
python phoenix_import2_simple_file_v2_new.py --interactive
```

#### Interactive Prompt Options:
- **Y/Yes/Enter** - Continue with this batch
- **N/No** - Skip this batch and continue with next
- **S/Skip** - Skip this batch and continue with next  
- **Q/Quit** - Stop batch processing entirely

#### Example Interactive Session:
```
============================================================
READY TO PROCESS BATCH 2 of 4
============================================================
Batch Name: batch-2
File Path: import-file/usb_cis_jun_auth_20250819.csv
Scan Type: Tenable Scan
Assessment: usb_cis_jun_auth_20250819
------------------------------------------------------------
Continue with this batch? [Y/n/s/q]: y
```

### 3. Enhanced Batch Configuration

Support for multiple batch configurations with individual settings per batch.

#### Multi-Batch Config Example:
```ini
[phoenix]
client_id = your_client_id
client_secret = your_client_secret
api_base_url = https://api.poc1.appsecphx.io
batch_delay = 2

[batch-1]
FILE_PATH = import-file/usb_cis_db_auth_20250819.csv
SCAN_TYPE = Tenable Scan
ASSESSMENT_NAME = usb_cis_db_auth_20250819
IMPORT_TYPE = new
SCAN_TARGET = usb_cis_db_auth_20250819.csv
AUTO_IMPORT = true
WAIT_FOR_COMPLETION = true

[batch-2]
FILE_PATH = import-file/usb_cis_jun_auth_20250819.csv
SCAN_TYPE = Tenable Scan
ASSESSMENT_NAME = usb_cis_jun_auth_20250819
IMPORT_TYPE = new
SCAN_TARGET = usb_cis_jun_auth_20250819
AUTO_IMPORT = true
WAIT_FOR_COMPLETION = true

[batch-3]
FILE_PATH = import-file/usb_cis_lnx_auth_20250819.csv
SCAN_TYPE = Tenable Scan
ASSESSMENT_NAME = usb_cis_lnx_auth_20250819
IMPORT_TYPE = new
SCAN_TARGET = usb_cis_lnx_auth_20250819
AUTO_IMPORT = true
WAIT_FOR_COMPLETION = true
```

### 4. Comprehensive Success Rate Reporting

Get detailed success rates for individual batches and overall processing.

#### Example Output:
```
============================================================
BATCH 1 of 3
============================================================
📦 Processing batch-1
   File: import-file/usb_cis_db_auth_20250819.csv

🔄 Processing file: import-file/usb_cis_db_auth_20250819.csv
   Assessment: usb_cis_db_auth_20250819
   Scan Type: Tenable Scan
   Import Type: new
   Batch: batch-1

📊 Batch batch-1 Summary:
   ✅ Successful: 1
   ❌ Failed: 0
   📈 Success Rate: 100.0%

⏳ Waiting 2 seconds before next batch...

================================================================================
OVERALL SUMMARY
================================================================================
📦 batch-1:
   ✅ Successful: 1/1 (100.0%)
   ❌ Failed: 0

📦 batch-2:
   ✅ Successful: 1/1 (100.0%)
   ❌ Failed: 0

📦 batch-3:
   ✅ Successful: 0/1 (0.0%)
   ❌ Failed: 1

🎯 OVERALL STATISTICS:
   Total files processed: 3
   ✅ Overall successful: 2
   ❌ Overall failed: 1
   📈 Overall success rate: 66.7%
```

## Usage Examples

### 1. Automatic Batch Processing with Default Delay
```bash
# Uses batch_delay from config.ini (default: 10 seconds)
python phoenix_import2_simple_file_v2_new.py
```

### 2. Fast Batch Processing (No Delays)
```bash
# Skip all delays between batches
python phoenix_import2_simple_file_v2_new.py --no_delay
```

### 3. Custom Delay Between Batches
```bash
# Wait 5 seconds between each batch
python phoenix_import2_simple_file_v2_new.py --batch_delay 5
```

### 4. Interactive Batch Processing
```bash
# Prompt before each batch
python phoenix_import2_simple_file_v2_new.py --interactive
```

### 5. Interactive with Custom Delay
```bash
# Prompt before each batch and wait 3 seconds between batches
python phoenix_import2_simple_file_v2_new.py --interactive --batch_delay 3
```

### 6. Save Detailed Report
```bash
# Process batches and save comprehensive report to file
python phoenix_import2_simple_file_v2_new.py --report_file batch_processing_report.txt
```

## Configuration Priority

Settings are applied in the following priority order (highest to lowest):

1. **Command Line Arguments** (highest priority)
   - `--batch_delay 5`
   - `--no_delay`
   - `--interactive`

2. **Environment Variables**
   - `PHOENIX_BATCH_DELAY=5`

3. **Configuration File**
   - `batch_delay = 5` in `[phoenix]` section

4. **Default Values** (lowest priority)
   - `batch_delay = 10` seconds

## Error Handling

### Batch Processing Errors
- Failed batches don't stop the overall process
- Each batch error is logged and reported
- Success rates are calculated excluding skipped batches
- Final report shows both individual batch and overall statistics

### User Interruption
- Ctrl+C during delay: Skips current delay and continues
- Ctrl+C during interactive prompt: Safely exits batch processing
- Quit option ('q') in interactive mode: Graceful shutdown

### File Not Found
- Missing files are reported as failed batches
- Processing continues with remaining batches
- Detailed error information in final report

## Best Practices

### 1. Rate Limiting Compliance
```bash
# For APIs with strict rate limits
python phoenix_import2_simple_file_v2_new.py --batch_delay 30
```

### 2. Large File Processing
```bash
# Interactive mode for large files to monitor progress
python phoenix_import2_simple_file_v2_new.py --interactive --batch_delay 60
```

### 3. Development/Testing
```bash
# Fast processing for development
python phoenix_import2_simple_file_v2_new.py --no_delay --interactive
```

### 4. Production Automation
```bash
# Reliable production processing with moderate delays
python phoenix_import2_simple_file_v2_new.py --batch_delay 10 --report_file "/logs/batch_$(date +%Y%m%d_%H%M%S).txt"
```

## Troubleshooting

### Issue: Batches Processing Too Fast
**Solution:** Increase batch delay or use interactive mode
```bash
python phoenix_import2_simple_file_v2_new.py --batch_delay 15 --interactive
```

### Issue: Processing Takes Too Long
**Solution:** Reduce delay or disable delays
```bash
python phoenix_import2_simple_file_v2_new.py --no_delay
```

### Issue: Need to Skip Problematic Batches
**Solution:** Use interactive mode to selectively skip batches
```bash
python phoenix_import2_simple_file_v2_new.py --interactive
```

### Issue: Want to Monitor Each Batch
**Solution:** Use interactive mode with custom delay
```bash
python phoenix_import2_simple_file_v2_new.py --interactive --batch_delay 5
```

## Integration Examples

### Cron Job with Logging
```bash
#!/bin/bash
# daily_batch_import.sh
LOG_FILE="/var/log/phoenix/batch_$(date +%Y%m%d).log"
python phoenix_import2_simple_file_v2_new.py \
    --batch_delay 10 \
    --report_file "$LOG_FILE" \
    >> "$LOG_FILE" 2>&1
```

### Jenkins Pipeline
```groovy
pipeline {
    agent any
    stages {
        stage('Batch Import') {
            steps {
                sh '''
                    python phoenix_import2_simple_file_v2_new.py \
                        --batch_delay 5 \
                        --report_file ./batch_report.txt
                '''
                archiveArtifacts artifacts: 'batch_report.txt'
            }
        }
    }
}
```

---

*For additional configuration options and advanced usage, refer to the main README.md file.*
