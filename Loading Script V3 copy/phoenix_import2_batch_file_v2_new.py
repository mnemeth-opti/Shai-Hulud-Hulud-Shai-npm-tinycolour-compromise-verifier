import requests
from requests.auth import HTTPBasicAuth
import json
import os
import time
import difflib
import configparser
from pathlib import Path
import argparse
import glob
from datetime import datetime

def load_configuration(config_file_path=None):
    """
    Load configuration from environment variables or config file.
    Priority: Command line args > Environment variables > config.ini file > defaults
    
    :param config_file_path: Optional path to config file
    :return: Dictionary containing configuration values and batch configurations
    """
    config = {}
    
    # Try to load from environment variables first
    config['CLIENT_ID'] = os.getenv('PHOENIX_CLIENT_ID')
    config['CLIENT_SECRET'] = os.getenv('PHOENIX_CLIENT_SECRET')
    config['API_BASE_URL'] = os.getenv('PHOENIX_API_BASE_URL')
    config['SCAN_TYPE'] = os.getenv('PHOENIX_SCAN_TYPE')
    config['SCAN_FILE'] = os.getenv('PHOENIX_SCAN_FILE')
    config['BATCH_DELAY'] = os.getenv('PHOENIX_BATCH_DELAY')
    
    # Initialize batch configurations
    config['BATCHES'] = []
    
    # If any config is missing, try to load from config file
    if not config_file_path:
        config_file_path = Path(__file__).parent / 'config.ini'
    else:
        config_file_path = Path(config_file_path)
        
    if config_file_path.exists():
        parser = configparser.ConfigParser()
        parser.read(config_file_path)
        
        if 'phoenix' in parser:
            phoenix_section = parser['phoenix']
            if not config['CLIENT_ID']:
                config['CLIENT_ID'] = phoenix_section.get('client_id')
            if not config['CLIENT_SECRET']:
                config['CLIENT_SECRET'] = phoenix_section.get('client_secret')
            if not config['API_BASE_URL']:
                config['API_BASE_URL'] = phoenix_section.get('api_base_url')
            if not config['SCAN_TYPE']:
                config['SCAN_TYPE'] = phoenix_section.get('scan_type')
            if not config['SCAN_FILE']:
                config['SCAN_FILE'] = phoenix_section.get('scan_file')
            if not config['BATCH_DELAY']:
                config['BATCH_DELAY'] = phoenix_section.get('batch_delay', '10')
        
        # Load batch configurations
        config['BATCHES'] = load_batch_configurations(parser)
    
    # Set default batch delay if not configured
    if not config['BATCH_DELAY']:
        config['BATCH_DELAY'] = '10'
    
    # Convert batch delay to integer
    try:
        config['BATCH_DELAY'] = int(config['BATCH_DELAY'])
    except (ValueError, TypeError):
        config['BATCH_DELAY'] = 10
    
    return config

def load_batch_configurations(parser):
    """
    Load batch configurations from config file.
    
    :param parser: ConfigParser instance
    :return: List of batch configuration dictionaries
    """
    batches = []
    
    # Look for batch sections (batch-1, batch-2, etc.) or individual batch configs in phoenix section
    for section_name in parser.sections():
        if section_name.startswith('batch-'):
            batch_config = dict(parser[section_name])
            batch_config['batch_name'] = section_name
            batches.append(batch_config)
    
    # Also check phoenix section for legacy single batch config
    if 'phoenix' in parser:
        phoenix_section = parser['phoenix']
        if 'batch' in phoenix_section or 'file_path' in phoenix_section:
            batch_config = {
                'batch_name': f"batch-{phoenix_section.get('batch', '1')}",
                'file_path': phoenix_section.get('file_path'),
                'scan_type': phoenix_section.get('scan_type'),
                'assessment_name': phoenix_section.get('assessment_name'),
                'import_type': phoenix_section.get('import_type', 'new'),
                'scan_target': phoenix_section.get('scan_target'),
                'auto_import': phoenix_section.getboolean('auto_import', True),
                'wait_for_completion': phoenix_section.getboolean('wait_for_completion', True)
            }
            # Only add if we have essential batch parameters
            if batch_config['file_path'] or batch_config['scan_type']:
                batches.append(batch_config)
    
    return batches

def parse_arguments():
    """
    Parse command line arguments.
    
    :return: Parsed arguments
    """
    parser = argparse.ArgumentParser(description='Phoenix Security Asset Import Tool')
    
    # Required arguments
    parser.add_argument('--folder', type=str, help='Process all files in the specified folder')
    parser.add_argument('--file', type=str, help='Process a single file')
    
    # Authentication arguments
    parser.add_argument('--client_id', type=str, help='Phoenix API Client ID (overrides config)')
    parser.add_argument('--client_secret', type=str, help='Phoenix API Client Secret (overrides config)')
    parser.add_argument('--phoenix_api_url', type=str, help='Phoenix API base URL (overrides config)')
    
    # Import configuration
    parser.add_argument('--scan_type', type=str, help='Scanner type (overrides config)')
    parser.add_argument('--import_type', type=str, choices=['new', 'delta'], default='new',
                       help='Import type: new or delta (default: new)')
    
    # Batch processing options
    parser.add_argument('--batch_delay', type=int, help='Delay in seconds between batches (overrides config)')
    parser.add_argument('--interactive', action='store_true', help='Prompt for confirmation before each batch')
    parser.add_argument('--no_delay', action='store_true', help='Skip delays between batches')
    
    # Optional arguments
    parser.add_argument('--config_file', type=str, help='Path to config file (default: config.ini)')
    parser.add_argument('--report_file', type=str, help='Path to save the report (default: import_report.txt)')
    
    return parser.parse_args()

def get_files_to_process(args, config):
    """
    Get list of files to process based on arguments and configuration.
    
    :param args: Parsed command line arguments
    :param config: Configuration dictionary
    :return: List of file paths
    """
    files_to_process = []
    
    if args.folder:
        folder_path = Path(args.folder)
        if not folder_path.exists():
            raise ValueError(f"Folder does not exist: {args.folder}")
        
        # Find all common file types that might be importable
        patterns = ['*.csv', '*.json', '*.xml', '*.txt', '*.xlsx']
        for pattern in patterns:
            files_to_process.extend(glob.glob(str(folder_path / pattern)))
        
        if not files_to_process:
            raise ValueError(f"No importable files found in folder: {args.folder}")
    
    elif args.file:
        file_path = Path(args.file)
        if not file_path.exists():
            raise ValueError(f"File does not exist: {args.file}")
        files_to_process.append(str(file_path))
    
    elif config.get('SCAN_FILE'):
        # Use scan file from configuration if no command line argument provided
        file_path = Path(config['SCAN_FILE'])
        if not file_path.exists():
            raise ValueError(f"Scan file from config does not exist: {config['SCAN_FILE']}")
        files_to_process.append(str(file_path))
        print(f"📁 Using scan file from configuration: {config['SCAN_FILE']}")
    
    else:
        raise ValueError("Either --folder, --file must be specified, or scan_file must be configured")
    
    return files_to_process

def generate_report(results, report_file=None):
    """
    Generate a report of the import results.
    
    :param results: List of import results
    :param report_file: Path to save the report (optional, displays on screen if None)
    """
    timestamp = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    successful = [r for r in results if r['success']]
    failed = [r for r in results if not r['success']]
    
    # Generate report content
    report_content = []
    report_content.append("=" * 80)
    report_content.append("PHOENIX SECURITY ASSET IMPORT REPORT")
    report_content.append("=" * 80)
    report_content.append(f"Generated: {timestamp}")
    report_content.append("")
    
    report_content.append("SUMMARY:")
    report_content.append(f"  Total files processed: {len(results)}")
    report_content.append(f"  Successful imports: {len(successful)}")
    report_content.append(f"  Failed imports: {len(failed)}")
    if len(results) > 0:
        report_content.append(f"  Success rate: {len(successful)/len(results)*100:.1f}%")
    report_content.append("")
    
    if successful:
        report_content.append("✅ SUCCESSFUL IMPORTS:")
        report_content.append("-" * 40)
        for result in successful:
            report_content.append(f"  File: {result['file']}")
            report_content.append(f"  Assessment: {result['assessment_name']}")
            report_content.append(f"  Scan Type: {result['scan_type']}")
            if result.get('batch_name'):
                report_content.append(f"  Batch: {result['batch_name']}")
            report_content.append(f"  Request ID: {result['request_id']}")
            report_content.append(f"  Status: {result['final_status']}")
            report_content.append("")
    
    if failed:
        report_content.append("❌ FAILED IMPORTS:")
        report_content.append("-" * 40)
        for result in failed:
            report_content.append(f"  File: {result['file']}")
            report_content.append(f"  Assessment: {result['assessment_name']}")
            report_content.append(f"  Scan Type: {result['scan_type']}")
            if result.get('batch_name'):
                report_content.append(f"  Batch: {result['batch_name']}")
            report_content.append(f"  Error: {result['error']}")
            report_content.append("")
    
    # Output report
    if report_file:
        # Save to file
        with open(report_file, 'w') as f:
            f.write('\n'.join(report_content))
        print(f"\n📊 Report saved to: {report_file}")
    else:
        # Display on screen
        print(f"\n📊 IMPORT REPORT:")
        print('\n'.join(report_content))
    
    # Always show summary on screen
    if len(results) > 0:
        print(f"✅ Successful: {len(successful)}/{len(results)} ({len(successful)/len(results)*100:.1f}%)")

def process_single_file(file_path, config, args, batch_config=None):
    """
    Process a single file for import.
    
    :param file_path: Path to the file to process
    :param config: Configuration dictionary
    :param args: Command line arguments
    :param batch_config: Optional batch-specific configuration
    :return: Dictionary with import result
    """
    file_name = Path(file_path).stem
    
    # Use batch-specific configuration if available
    if batch_config:
        assessment_name = batch_config.get('assessment_name', f"{file_name}_{datetime.now().strftime('%Y%m%d_%H%M%S')}")
        scan_type = batch_config.get('scan_type', config['SCAN_TYPE'])
        scan_target = batch_config.get('scan_target', file_name)
        import_type = batch_config.get('import_type', 'new')
        auto_import = batch_config.get('auto_import', True)
        wait_for_completion = batch_config.get('wait_for_completion', True)
    else:
        assessment_name = f"{file_name}_{datetime.now().strftime('%Y%m%d_%H%M%S')}"
        scan_type = config['SCAN_TYPE']
        scan_target = file_name
        import_type = args.import_type if args else 'new'
        auto_import = True
        wait_for_completion = True
    
    print(f"\n🔄 Processing file: {file_path}")
    print(f"   Assessment: {assessment_name}")
    print(f"   Scan Type: {scan_type}")
    print(f"   Import Type: {import_type}")
    if batch_config:
        print(f"   Batch: {batch_config.get('batch_name', 'Unknown')}")
    
    try:
        request_id, final_status = send_results(
            file_path=file_path,
            scan_type=scan_type,
            assessment_name=assessment_name,
            import_type=import_type,
            client_id=config['CLIENT_ID'],
            client_secret=config['CLIENT_SECRET'],
            api_base_url=config['API_BASE_URL'],
            scan_target=scan_target,
            auto_import=auto_import,
            wait_for_completion=wait_for_completion
        )
        
        if request_id and final_status:
            status = final_status.get('status', 'UNKNOWN') if isinstance(final_status, dict) else 'COMPLETED'
            return {
                'file': file_path,
                'assessment_name': assessment_name,
                'scan_type': scan_type,
                'request_id': request_id,
                'final_status': status,
                'success': True,
                'error': None,
                'batch_name': batch_config.get('batch_name') if batch_config else None
            }
        else:
            return {
                'file': file_path,
                'assessment_name': assessment_name,
                'scan_type': scan_type,
                'request_id': None,
                'final_status': None,
                'success': False,
                'error': 'Failed to get request ID or final status',
                'batch_name': batch_config.get('batch_name') if batch_config else None
            }
    
    except Exception as e:
        return {
            'file': file_path,
            'assessment_name': assessment_name,
            'scan_type': scan_type,
            'request_id': None,
            'final_status': None,
            'success': False,
            'error': str(e),
            'batch_name': batch_config.get('batch_name') if batch_config else None
        }

def process_batch_configuration(batch_config, config, args):
    """
    Process a single batch configuration.
    
    :param batch_config: Batch configuration dictionary
    :param config: Main configuration dictionary
    :param args: Command line arguments
    :return: List of import results for this batch
    """
    batch_name = batch_config.get('batch_name', 'Unknown')
    file_path = batch_config.get('file_path')
    
    print(f"\n📦 Processing {batch_name}")
    print(f"   File: {file_path}")
    
    if not file_path:
        print(f"   ❌ No file_path specified for {batch_name}")
        return [{
            'file': 'N/A',
            'assessment_name': 'N/A',
            'scan_type': batch_config.get('scan_type', 'Unknown'),
            'request_id': None,
            'final_status': None,
            'success': False,
            'error': 'No file_path specified in batch configuration',
            'batch_name': batch_name
        }]
    
    # Handle file path - could be relative to config file location
    if not Path(file_path).is_absolute():
        config_dir = Path(args.config_file).parent if args and args.config_file else Path(__file__).parent
        file_path = config_dir / file_path
    
    file_path = str(file_path)
    
    if not Path(file_path).exists():
        print(f"   ❌ File not found: {file_path}")
        return [{
            'file': file_path,
            'assessment_name': batch_config.get('assessment_name', 'N/A'),
            'scan_type': batch_config.get('scan_type', 'Unknown'),
            'request_id': None,
            'final_status': None,
            'success': False,
            'error': f'File not found: {file_path}',
            'batch_name': batch_name
        }]
    
    # Process the file with batch-specific configuration
    result = process_single_file(file_path, config, args, batch_config)
    return [result]

def prompt_user_continuation(batch_config, batch_num, total_batches):
    """
    Prompt user for confirmation before processing the next batch.
    
    :param batch_config: Current batch configuration
    :param batch_num: Current batch number
    :param total_batches: Total number of batches
    :return: True to continue, False to skip this batch
    """
    batch_name = batch_config.get('batch_name', f'batch-{batch_num}')
    file_path = batch_config.get('file_path', 'Unknown file')
    
    print(f"\n{'='*60}")
    print(f"READY TO PROCESS BATCH {batch_num} of {total_batches}")
    print(f"{'='*60}")
    print(f"Batch Name: {batch_name}")
    print(f"File Path: {file_path}")
    print(f"Scan Type: {batch_config.get('scan_type', 'Default')}")
    print(f"Assessment: {batch_config.get('assessment_name', 'Auto-generated')}")
    print("-" * 60)
    
    while True:
        try:
            response = input("Continue with this batch? [Y/n/s/q]: ").strip().lower()
            if response in ['', 'y', 'yes']:
                return True
            elif response in ['n', 'no']:
                print(f"⏭️  Skipping batch {batch_num}")
                return False
            elif response in ['s', 'skip']:
                print(f"⏭️  Skipping batch {batch_num}")
                return False
            elif response in ['q', 'quit', 'exit']:
                print("🛑 User requested to quit batch processing")
                return 'quit'
            else:
                print("Please enter Y (yes), N (no), S (skip), or Q (quit)")
        except KeyboardInterrupt:
            print("\n🛑 User interrupted batch processing")
            return 'quit'

def wait_between_batches(config, args, batch_num, total_batches):
    """
    Wait between batches with configurable delay.
    
    :param config: Configuration dictionary
    :param args: Command line arguments
    :param batch_num: Current batch number
    :param total_batches: Total number of batches
    """
    # Skip delay if this is the last batch or if no_delay flag is set
    if batch_num >= total_batches or (args and args.no_delay):
        return
    
    # Get delay from command line args or config
    if args and args.batch_delay is not None:
        delay = args.batch_delay
    else:
        delay = config.get('BATCH_DELAY', 10)
    
    if delay > 0:
        print(f"\n⏳ Waiting {delay} seconds before next batch...")
        try:
            time.sleep(delay)
        except KeyboardInterrupt:
            print("\n⚠️  Wait interrupted by user")

def process_all_batches(config, args):
    """
    Process all batch configurations from the config file.
    
    :param config: Configuration dictionary containing BATCHES
    :param args: Command line arguments
    :return: List of all import results
    """
    all_results = []
    batches = config.get('BATCHES', [])
    
    if not batches:
        print("📦 No batch configurations found in config file")
        return all_results
    
    # Get batch delay configuration
    batch_delay = config.get('BATCH_DELAY', 10)
    if args and args.batch_delay is not None:
        batch_delay = args.batch_delay
    
    print(f"🚀 Starting batch processing for {len(batches)} batch(es)")
    if batch_delay > 0 and not (args and args.no_delay):
        print(f"⏳ Batch delay configured: {batch_delay} seconds")
    if args and args.interactive:
        print("🔄 Interactive mode enabled - will prompt before each batch")
    
    for i, batch_config in enumerate(batches, 1):
        # Interactive prompt if enabled
        if args and args.interactive:
            user_choice = prompt_user_continuation(batch_config, i, len(batches))
            if user_choice == 'quit':
                print("🛑 Batch processing terminated by user")
                break
            elif user_choice is False:
                # Skip this batch
                continue
        else:
            print(f"\n{'='*60}")
            print(f"BATCH {i} of {len(batches)}")
            print(f"{'='*60}")
        
        batch_results = process_batch_configuration(batch_config, config, args)
        all_results.extend(batch_results)
        
        # Show batch summary
        successful = [r for r in batch_results if r['success']]
        failed = [r for r in batch_results if not r['success']]
        
        print(f"\n📊 Batch {batch_config.get('batch_name', f'batch-{i}')} Summary:")
        print(f"   ✅ Successful: {len(successful)}")
        print(f"   ❌ Failed: {len(failed)}")
        if batch_results:
            success_rate = len(successful) / len(batch_results) * 100
            print(f"   📈 Success Rate: {success_rate:.1f}%")
        
        # Wait between batches
        wait_between_batches(config, args, i, len(batches))
    
    return all_results

def main():
    """
    Main function to handle command line execution.
    """
    args = parse_arguments()
    
    try:
        # Load configuration
        config = load_configuration(args.config_file)
        
        # Override config with command line arguments if provided
        if args.client_id:
            config['CLIENT_ID'] = args.client_id
        if args.client_secret:
            config['CLIENT_SECRET'] = args.client_secret
        if args.phoenix_api_url:
            config['API_BASE_URL'] = args.phoenix_api_url
        if args.scan_type:
            config['SCAN_TYPE'] = args.scan_type
        if args.batch_delay is not None:
            config['BATCH_DELAY'] = args.batch_delay
        
        # Validate required configuration
        missing_configs = []
        if not config.get('CLIENT_ID'):
            missing_configs.append('CLIENT_ID')
        if not config.get('CLIENT_SECRET'):
            missing_configs.append('CLIENT_SECRET')
        if not config.get('API_BASE_URL'):
            missing_configs.append('API_BASE_URL')
        
        if missing_configs:
            raise ValueError(f"Missing required configuration: {', '.join(missing_configs)}.\n"
                               f"Please provide via command line arguments, environment variables, or config file.")
            
        print(f"🚀 Starting Phoenix Security Asset Import")
        print(f"   API URL: {config['API_BASE_URL']}")
        
        # Determine processing mode
        if args.folder or args.file:
            # Standard file/folder processing mode
            if not config.get('SCAN_TYPE'):
                missing_configs.append('SCAN_TYPE')
                raise ValueError(f"Missing required configuration: SCAN_TYPE.\n"
                               f"Please provide via command line arguments, environment variables, or config file.")
            
            print(f"   Scan Type: {config['SCAN_TYPE']}")
            print(f"   Import Type: {args.import_type}")
            
            # Get files to process
            files_to_process = get_files_to_process(args, config)
            print(f"   Files to process: {len(files_to_process)}")
            
            # Process each file
            results = []
            for file_path in files_to_process:
                result = process_single_file(file_path, config, args)
                results.append(result)
                
                if result['success']:
                    print(f"   ✅ Success: {Path(file_path).name}")
                else:
                    print(f"   ❌ Failed: {Path(file_path).name} - {result['error']}")
        
        else:
            # Batch processing mode using configuration file
            print(f"   Mode: Batch processing from configuration")
            results = process_all_batches(config, args)
        
        # Generate comprehensive report
        if results:
            print(f"\n{'='*80}")
            print("OVERALL SUMMARY")
            print(f"{'='*80}")
            
            # Group results by batch if applicable
            batch_summaries = {}
            for result in results:
                batch_name = result.get('batch_name', 'Standard Processing')
                if batch_name not in batch_summaries:
                    batch_summaries[batch_name] = {'successful': 0, 'failed': 0, 'total': 0}
                
                batch_summaries[batch_name]['total'] += 1
                if result['success']:
                    batch_summaries[batch_name]['successful'] += 1
                else:
                    batch_summaries[batch_name]['failed'] += 1
            
            # Display batch summaries
            for batch_name, summary in batch_summaries.items():
                success_rate = summary['successful'] / summary['total'] * 100 if summary['total'] > 0 else 0
                print(f"📦 {batch_name}:")
                print(f"   ✅ Successful: {summary['successful']}/{summary['total']} ({success_rate:.1f}%)")
                print(f"   ❌ Failed: {summary['failed']}")
            
            # Overall statistics
            total_successful = sum(r['success'] for r in results)
            total_failed = len(results) - total_successful
            overall_success_rate = total_successful / len(results) * 100 if results else 0
            
            print(f"\n🎯 OVERALL STATISTICS:")
            print(f"   Total files processed: {len(results)}")
            print(f"   ✅ Overall successful: {total_successful}")
            print(f"   ❌ Overall failed: {total_failed}")
            print(f"   📈 Overall success rate: {overall_success_rate:.1f}%")
            
            # Generate detailed report
            if args.report_file:
                generate_report(results, args.report_file)
            else:
                generate_report(results)  # Display on screen only
        else:
            print("⚠️  No files were processed")
        
    except Exception as e:
        print(f"❌ Error: {e}")
    exit(1)

# Scanner types file path
SCANNER_TYPES_FILE = Path(__file__).parent / 'Scanner_Selection.txt'

def load_scanner_types(file_path=SCANNER_TYPES_FILE):
    """
    Load valid scanner types from the specified file.
    
    :param file_path: Path to the file containing valid scanner types
    :return: List of valid scanner types
    """
    try:
        with open(file_path, 'r') as f:
            return [line.strip() for line in f if line.strip()]
    except FileNotFoundError:
        print(f"Warning: Scanner types file '{file_path}' not found.")
        return []

def find_closest_scanner_type(scanner_type, valid_scanner_types):
    """
    Find the closest matching scanner type from the list of valid types.
    
    :param scanner_type: The scanner type to validate
    :param valid_scanner_types: List of valid scanner types
    :return: The closest matching scanner type or None if no close match
    """
    if not valid_scanner_types:
        return None
    
    matches = difflib.get_close_matches(scanner_type, valid_scanner_types, n=1, cutoff=0.6)
    return matches[0] if matches else None

def validate_scanner_type(scanner_type):
    """
    Validate if the provided scanner type is in the list of valid types.
    If not, suggest the closest match and show available options.
    
    :param scanner_type: The scanner type to validate
    :return: The validated scanner type (either the original or the closest match)
    """
    valid_scanner_types = load_scanner_types()
    
    if not valid_scanner_types:
        print(f"⚠️  Warning: Scanner types file not found. Using '{scanner_type}' without validation.")
        return scanner_type
    
    if scanner_type in valid_scanner_types:
        print(f"✅ Scanner type '{scanner_type}' is valid.")
        return scanner_type
    
    closest_match = find_closest_scanner_type(scanner_type, valid_scanner_types)
    
    print(f"❌ Warning: '{scanner_type}' is not a valid scanner type.")
    
    if closest_match:
        print(f"💡 Did you mean '{closest_match}'?")
        print(f"🔄 Using '{closest_match}' instead.")
        return closest_match
    else:
        print("📋 Available scanner types include:")
        # Show first 10 scanner types as examples
        for i, scanner in enumerate(valid_scanner_types[:10]):
            print(f"   • {scanner}")
        if len(valid_scanner_types) > 10:
            print(f"   ... and {len(valid_scanner_types) - 10} more")
        
        print(f"⚠️  Using '{scanner_type}' anyway, but this may cause import failures.")
        return scanner_type

def get_access_token(client_id, client_secret, api_base_url):
    # The line `url = "https://api.https://demo2.appsecphx.io//v1/auth/access_token"` is defining the URL
    # endpoint for obtaining an access token. This URL is used in the `get_access_token` function to make
    # a GET request with HTTP basic authentication using the provided client ID and client secret. The
    # response from this URL is expected to contain the access token needed for authentication in
    # subsequent API requests.
    url = f"{api_base_url}/v1/auth/access_token"

    response = requests.get(url, auth=HTTPBasicAuth(client_id, client_secret))
    if response.status_code == 200:
        return response.json()['token']
    else:
        print(response.status_code)
        print("Failed to obtain token:", response.text)
    return None

def check_import_status(request_id, client_id, client_secret, api_base_url):
    """
    Check the status of an import request.
    
    :param request_id: The UUID identifying the import request
    :param client_id: Client ID for authentication
    :param client_secret: Client secret for authentication
    :param api_base_url: Phoenix API base URL
    :return: The status response from the API
    """
    token = get_access_token(client_id, client_secret, api_base_url)
    if token is None:
        return None
    
    url = f"{api_base_url}/v1/import/assets/file/translate/request/{request_id}"
    
    headers = {
        'Authorization': f'Bearer {token}'
    }
    
    response = requests.get(url, headers=headers)
    if response.status_code == 200:
        return response.json()
    else:
        print(f"Status Code: {response.status_code}")
        print(f"Failed to check import status: {response.text}")
        return None

def wait_for_import_completion(request_id, client_id, client_secret, api_base_url, check_interval=10, timeout=3600):
    """
    Continuously check the status of an import until it completes or times out.
    
    :param request_id: The UUID identifying the import request
    :param client_id: Client ID for authentication
    :param client_secret: Client secret for authentication
    :param api_base_url: Phoenix API base URL
    :param check_interval: Time in seconds between status checks (default: 10)
    :param timeout: Maximum time in seconds to wait for completion (default: 3600 = 1 hour)
    :return: The final status response from the API
    """
    start_time = time.time()
    
    while True:
        status_response = check_import_status(request_id, client_id, client_secret, api_base_url)
        
        if status_response is None:
            print("Failed to get status response")
            return None
        
        current_status = status_response.get('status')
        print(f"Current import status: {current_status}")
        
        if current_status == "IMPORTED":
            print("Import completed successfully!")
            return status_response
        elif current_status == "ERROR":
            print(f"Import failed with error: {status_response.get('error', 'Unknown error')}")
            return status_response
        elif current_status in ["TRANSLATING", "READY_FOR_IMPORT"]:
            # Check if we've exceeded the timeout
            if time.time() - start_time > timeout:
                print(f"Import timed out after {timeout} seconds")
                return status_response
            
            # Wait before checking again
            print(f"Waiting {check_interval} seconds before checking again...")
            time.sleep(check_interval)
        else:
            print(f"Unknown status: {current_status}")
            return status_response

def send_results(file_path, scan_type, assessment_name, import_type, client_id, client_secret, api_base_url, scan_target=None, auto_import=True, wait_for_completion=True):
    """
    Send scan results to the API and optionally wait for the import to complete.
    
    :param file_path: Path to the file to be imported
    :param scan_type: Type of scan (e.g., "SonarQube Scan")
    :param assessment_name: Name of the assessment
    :param import_type: Type of import ("new" or "merge")
    :param client_id: Client ID for authentication
    :param client_secret: Client secret for authentication
    :param api_base_url: Phoenix API base URL
    :param scan_target: Target of the scan (optional)
    :param auto_import: Whether to automatically import after processing (default: True)
    :param wait_for_completion: Whether to wait for the import to complete (default: True)
    :return: The import request ID and final status response if wait_for_completion is True
    """
    # Validate scanner type
    scan_type = validate_scanner_type(scan_type)
    
    token = get_access_token(client_id, client_secret, api_base_url)
    if token is None:
        return None, None
    
    url = f"{api_base_url}/v1/import/assets/file/translate"

    headers = {
        'Authorization': f'Bearer {token}'
    }
    files = {
        'file': (file_path, open(file_path, 'rb'), 'application/octet-stream')
    }
    data = {
        'scanType': scan_type,
        'assessmentName': assessment_name,
        'importType': import_type,
        'scanTarget': scan_target if scan_target else '',
        'autoImport': 'true' if auto_import else 'false'
    }
    
    response = requests.post(url, headers=headers, files=files, data=data)
    files['file'][1].close() # Make sure to close the file
    
    print("Status Code:", response.status_code)
    
    if response.status_code != 200:
        print("Failed to send results:", response.text)
        return None, None
    
    response_data = response.json()
    print("Response:", response_data)
    
    request_id = response_data.get('id')
    
    if wait_for_completion and request_id:
        print(f"Waiting for import to complete (request ID: {request_id})...")
        final_status = wait_for_import_completion(request_id, client_id, client_secret, api_base_url)
        return request_id, final_status
    
    return request_id, response_data

# Example usage
#client_id = os.environ["CLIENT_ID"]
#client_secret = os.environ["CLIENT_SECRET"]



# Legacy support - only run if not imported and no command line args
if __name__ == "__main__":
    import sys
    if len(sys.argv) > 1:
        # Command line mode
        main()
    else:
        # Legacy mode - load configuration and run single file
        try:
            config = load_configuration()
            
            # Check for required configuration
            missing_configs = []
            if not config['CLIENT_ID']:
                missing_configs.append('CLIENT_ID')
            if not config['CLIENT_SECRET']:
                missing_configs.append('CLIENT_SECRET')
            if not config['API_BASE_URL']:
                missing_configs.append('API_BASE_URL')
            
            if missing_configs:
                raise ValueError(f"Missing required configuration: {', '.join(missing_configs)}.\n"
                                f"Please set environment variables: PHOENIX_CLIENT_ID, PHOENIX_CLIENT_SECRET, PHOENIX_API_BASE_URL\n"
                                f"Or create a config.ini file with [phoenix] section containing: client_id, client_secret, api_base_url")
            
            CLIENT_ID = config['CLIENT_ID']
            CLIENT_SECRET = config['CLIENT_SECRET']
            API_BASE_URL = config['API_BASE_URL']
            print(f"Configuration loaded successfully. Using API base URL: {API_BASE_URL}")
            
            # Legacy import parameters
            FILE_PATH = 'nessus-import.csv'
            SCAN_TYPE = 'Tenable Scan'
            ASSESSMENT_NAME = 'usb_cis_fg_auth_20250813'
            IMPORT_TYPE = 'new'
            SCAN_TARGET = 'usb_cis_fg_auth'
            AUTO_IMPORT = True
            WAIT_FOR_COMPLETION = True
            
            # Execute legacy single file import
            request_id, final_status = send_results(
                FILE_PATH, 
                SCAN_TYPE, 
                ASSESSMENT_NAME, 
                IMPORT_TYPE, 
                CLIENT_ID, 
                CLIENT_SECRET, 
                API_BASE_URL,
                SCAN_TARGET,
                AUTO_IMPORT,
                WAIT_FOR_COMPLETION
            )

        except ValueError as e:
            print(f"Configuration error: {e}")
            exit(1)