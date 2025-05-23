# RobotSellineumTesting
# AliExpress Test Automation

## Overview
Automated test suite for AliExpress platform covering:
- 🌐 Language selection functionality  
- 🔐 User login flows  
- 💰 Currency conversion features  

Built with:
- **Robot Framework** (test automation)  
- **SeleniumLibrary** (browser automation)  
- **Firefox** (default browser)  

## Test Suite Structure

### Language Functionality Tests
| Test Case | Description | Verification Points |
|-----------|-------------|----------------------|
| Change to English | Switch from Arabic to English | English UI elements appear |
| Change to Arabic | Revert to Arabic interface | Arabic content visible |
| Persistence Check | Language remains after refresh | Session maintains selection |
| Language Search | Search for Spanish in selector | Español option appears |
| Search Page Stability | Language change during search | Stays on results page |

### Login Functionality Tests
| Test Case | Description | Verification Points |
|-----------|-------------|----------------------|
| Valid Login | Correct credentials | Redirects to account page |
| Invalid Password | Wrong password attempt | Shows error message |
| Invalid Username | Nonexistent account | Displays username error |

### Currency Functionality Tests  
| Test Case | Description | Verification Points |
|-----------|-------------|----------------------|
| EGP → USD | Change to US Dollars | Prices show $ format |
| USD → EGP | Revert to Egyptian Pounds | Prices show EGP format |
| SAR Conversion | Switch to Saudi Riyal | Prices show ر.س. format |

## Installation Guide

### Prerequisites
- Python 3.8+
- Firefox browser
- geckodriver (for Firefox automation)

### Setup
```bash
pip install -r requirements.txt 

```
```
requirements.txt:

robotframework==6.0.2
selenium==4.10.0
robotframework-seleniumlibrary==6.1.0
```

## Execution

Run all tests:
```bash
robot tests/aliexpress_suite.robot
```
## Run specific test
```
robot -t "Verify Successful Login" tests/aliexpress_suite.robot
```

## Configuration

| Variable | Default Value | Description |
|----------|---------------|-------------|
| `${BROWSER}` | `firefox` | Browser for testing |
| `${HOMEPAGE_URL}` | `https://www.aliexpress.com/` | Test environment URL |
| `${VALID_USERNAME}` | `janamohamed248@gmail.com` | Test account email |
| `${VALID_PASSWORD}` | `ONEDIRECTION` | Test account password |


## Maintenance Notes

    Element Locators may need updates when AliExpress modifies their UI

    Test Credentials should be rotated periodically

    Browser Drivers must match your installed browser versions

## Known Limitations
```
⚠️ Popup Handling - Some tests include ad-closing steps that may need adjustment
⚠️ XPath Fragility - Consider converting to CSS selectors for more stability
⚠️ Currency Tests - Dependent on product pages maintaining consistent price locators
```