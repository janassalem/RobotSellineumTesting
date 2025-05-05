*** Settings ***
Library    SeleniumLibrary
Suite Setup     Open Browser To AliExpress Homepage
Suite Teardown  Close All Browsers

*** Variables ***
${BROWSER}        firefox
${HOMEPAGE_URL}    https://www.aliexpress.com/
${CLOSE_ADD}      class=_24EHh

# Language related variables
${LANGUAGE_DROPDOWN}    class=es--wrap--RYjm1RT
${LANGUAGE_SELECTOR}    xpath=//*[@id="_full_container_header_23_"]/div[2]/div/div[2]/div[2]/div[2]/div[4]/div/div[1]
${LANGUAGE_SEARCH_BAR}  xpath=//*[@id="_full_container_header_23_"]/div[2]/div/div[2]/div[2]/div[2]/div[4]/div/div[2]/div[1]/input
${LANGUAGE_CONFIRM_BUTTON}    class=es--saveBtn--w8EuBuy
${ARABIC_OPTION}    xpath=//*[@id="_full_container_header_23_"]/div[2]/div/div[2]/div[2]/div[2]/div[4]/div/div[2]/div[3]
${ENGLISH_OPTION}    xpath=//*[@id="_full_container_header_23_"]/div[2]/div/div[2]/div[2]/div[2]/div[4]/div/div[2]/div[2]
${SPANISH_OPTION}    xpath=//*[@id="_full_container_header_23_"]/div[2]/div/div[2]/div[2]/div[2]/div[6]/div/div[2]/div[3]

# Search related variables
${SEARCHITEM}    xpath=//*[@id="search-words"]
${SEARCHBAR}    xpath=/html/body/div[1]/div[1]/div/div/div[2]/div/div[1]/div/input[2]

# Login related variables
${ACCOUNT_MENU}    xpath=//*[@id="_full_container_header_23_"]/div[2]/div/div[2]/div[3]
${LOGIN_BUTTON}    class=my-account--signin--RiPQVPB
${CONTINUE_BUTTON}   xpath=//*[@id="batman-dialog-wrap"]/div/div/div/div[1]/div/div[3]/div[3]/button
${USERNAME_FIELD}    xpath=//*[@id="batman-dialog-wrap"]/div/div/div/div[1]/div/div[3]/div[2]/div/span/span[1]/span[1]/input
${PASSWORD_FIELD}    xpath=//*[@id="fm-login-password"]
${SUBMIT_BUTTON}    xpath=//*[@id="batman-dialog-wrap"]/div/div/div/div[1]/div[9]/button
${VALID_USERNAME}   janamohamed248@gmail.com
${VALID_PASSWORD}    ONEDIRECTION
${INVALID_USER}       invalid_user@example.com
${INVALID_PASSWORD}    invalid_password123

# Currency related variables
${SHIP_TO_DROPDOWN}      class=ship-to--text--3H_PaoC
${CURRENCY_DROPDOWN}     xpath=//*[@id="_full_container_header_23_"]/div[2]/div/div[2]/div[2]/div[2]/div[6]/div
${USD_OPTION}            xpath=//*[@id="_full_container_header_23_"]/div[2]/div/div[2]/div[2]/div[2]/div[6]/div/div[2]/div[2]
${EGP_OPTION}            xpath=//*[@id="_full_container_header_23_"]/div[2]/div/div[2]/div[2]/div[2]/div[6]/div/div[2]/div[4]
${SAR_OPTION}            xpath=//*[@id="_full_container_header_23_"]/div[2]/div/div[2]/div[2]/div[2]/div[6]/div/div[2]/div[3]
${CURRENCY_CONFIRM}      class=es--saveBtn--w8EuBuy
${PRICE_LOCATOR}         xpath=//*[@id="root"]/div[2]/div[4]/div/div/div/div/div[2]/div[2]/a/div/div[2]/div/div[2]/div[1]/div/div/div/div[2]/div[2]/div/span[1]
${EPRICE_LOCATOR}        xpath=//*[@id="root"]/div[2]/div[7]/div/div/div/div[2]/div[3]/div/div/a/div[2]/div[3]/div[1]/span[1]
${SAR_PRICELOCATOR}      xpath=//*[@id="root"]/div[2]/div[4]/div/div/div/div/div[2]/div[1]/a/div/div[2]/div/div[2]/div[3]/div/div/div/div[2]/div[2]/div/span[1]
${PRICE_TEXT}            EGP

*** Test Cases ***
Verify User Can Change Website Language To English
    [Documentation]    Test that user can change website language to English
    Close Add
    Open Language Settings
    Select Language    ${ENGLISH_OPTION}
    Confirm Language Change
    Verify Language Changed To English

Verify User Can Change Website Language To Arabic
    [Documentation]    Test that user can change website language back to Arabic
    Close Add
    Open Language Settings
    Select Language    ${ARABIC_OPTION}
    Confirm Language Change
    Verify Language Changed To Arabic

Verify Language Change Persists After Page Refresh
    [Documentation]    Test that language selection persists after refreshing the page
    Close Add
    Reload Page And Verify Arabic Language
    [Teardown]    Change Language To English

Verify User Can Search For Language
    [Documentation]    Test that user can search for a language in the language selector
    Close Add
    Open Language Settings
    Search For Language    Español
    Page Should Contain Element    ${SPANISH_OPTION}

Verify Language Change During Search Doesn't Redirect To Homepage
    [Documentation]    Test that changing language during search keeps user on search results
    Perform Search For Item
    Open Language Settings
    Select Language    ${ARABIC_OPTION}
    Confirm Language Change
    Verify Still On Search Results Page
    [Teardown]    Change Language To English

Verify Successful Login
    [Documentation]    Test that user can login with valid credentials
    Close Popup Ads
    User Clicks Sign In Button
    Enters Valid Credentials
    Clicks Submit Button
    User Should Be Redirected To Account Page
    Account Menu Should Be Visible

Verify Login Fails With Invalid Password
    [Documentation]    Test that user cannot login with invalid password
    Close Popup Ads
    User Clicks Sign In Button
    Enters Valid Username
    Enters Invalid Password
    Clicks Submit Button
    Error Message Should Be Displayed
    User Should Not Be Logged In

Verify Login Fails With Invalid Username
    [Documentation]    Test that user cannot login with invalid username
    Close Popup Ads
    User Clicks Sign In Button
    Enters Invalid Username
    Clicks Continue Button
    Username Error Message Should Be Displayed

Verify User Can Change Currency From EGP To USD
    [Documentation]    Test that user can change currency from EGP to USD
    Close Popup Ads
    Open Currency Menu
    Select Currency    ${USD_OPTION}
    Confirm Currency Change
    Verify Currency    ${PRICE_LOCATOR}    ^\\$\\d+(\\.\\d{2})?$

Verify User Can Change Currency Back To EGP
    [Documentation]    Test that user can revert currency from USD to EGP
    Close Popup Ads
    Open Currency Menu
    Select EGP Currency
    Confirm Currency Change
    Verify EGP Currency

Verify User Can Change Currency to SAR
    [Documentation]    Test that user can change currency to SAR
    Close Popup Ads
    Open Currency Menu
    Select Currency    ${SAR_OPTION}
    Confirm Currency Change
    Verify Currency    ${SAR_PRICELOCATOR}    ^\\ر.س.\\s*\\d+(\\.\\d{2})?$

*** Keywords ***
Open Browser To AliExpress Homepage
    Open Browser    ${HOMEPAGE_URL}    ${BROWSER}
    Maximize Browser Window
    Set Selenium Implicit Wait    10 seconds

Close Add
    Click Element    ${CLOSE_ADD}

Open Language Settings
    Click Element    ${LANGUAGE_DROPDOWN}
    Click Element    ${LANGUAGE_SELECTOR}

Select Language
    [Arguments]    ${language_option}
    Click Element    ${language_option}

Confirm Language Change
    Click Element    ${LANGUAGE_CONFIRM_BUTTON}
    Sleep    5s

Verify Language Changed To Arabic
    Wait Until Page Contains Element    class=fw_fy    timeout=5s
    Page Should Contain Element    //*[@id="root"]/div[2]/div[4]/div/div/div/div/div[1]/span

Verify Language Changed To English
    Wait Until Page Contains Element   class=Categoey--categoryTitle--_3bKGRN    timeout=5s
    Page Should Contain Element    class=Categoey--categoryTitle--_3bKGRN

Reload Page And Verify Arabic Language
    Reload Page
    Verify Language Changed To Arabic

Change Language To English
    Open Language Settings
    Select Language    ${ENGLISH_OPTION}
    Confirm Language Change

Search For Language
    [Arguments]    ${language}
    Click Element    ${LANGUAGE_SEARCH_BAR}
    Input Text    ${LANGUAGE_SEARCH_BAR}    ${language}

Perform Search For Item
    Input Text    ${SEARCHITEM}    laptop
    Click Element    ${SEARCHBAR}

Verify Still On Search Results Page
    Page Should Not Contain    عروض اليوم

Close Popup Ads
    Run Keyword And Ignore Error    Click Element    ${CLOSE_ADD}
    Sleep    2s

User Clicks Sign In Button
    Click Element    ${ACCOUNT_MENU}
    Sleep    1s
    Click Element   ${LOGIN_BUTTON}
    Wait Until Page Contains Element    ${USERNAME_FIELD}

Enters Valid Credentials
    Input Text    ${USERNAME_FIELD}    ${VALID_USERNAME}
    Press Keys    ${USERNAME_FIELD}    ENTER
    Input Text    ${PASSWORD_FIELD}    ${VALID_PASSWORD}

Clicks Submit Button
    Click Button    ${SUBMIT_BUTTON}

User Should Be Redirected To Account Page
    Wait Until Page Contains Element    ${ACCOUNT_MENU}    timeout=10s

Account Menu Should Be Visible
    Element Should Be Visible    ${ACCOUNT_MENU}

Enters Valid Username
    Input Text    ${USERNAME_FIELD}    ${VALID_USERNAME}
    Press Keys    ${USERNAME_FIELD}    ENTER

Enters Invalid Password
    Input Text    ${PASSWORD_FIELD}    ${INVALID_PASSWORD}

Enters Invalid Username
    Input Text    ${USERNAME_FIELD}    ${INVALID_USER}

Clicks Continue Button
    Click Button    ${CONTINUE_BUTTON}

ErrorMessage Should Be Displayed
    Wait Until Page Contains    Incorrect password    timeout=5s

User Should Not Be Logged In
    Element Should Not Be Visible    ${ACCOUNT_MENU}

Username Error Message Should Be Displayed
    Wait Until Page Contains    Please enter a valid email address or mobile number    timeout=5s

Open Currency Menu
    Wait Until Element Is Visible    ${SHIP_TO_DROPDOWN}    timeout=10s
    Click Element    ${SHIP_TO_DROPDOWN}
    Wait Until Element Is Visible    ${CURRENCY_DROPDOWN}    timeout=10s
    Click Element    ${CURRENCY_DROPDOWN}
    Sleep    1s

Select Currency
    [Arguments]    ${currency_option}
    Wait Until Element Is Visible    ${currency_option}
    Click Element    ${currency_option}

Confirm Currency Change
    Click Element    ${CURRENCY_CONFIRM}
    Sleep    3s

Verify Currency
    [Arguments]    ${price_locator}    ${expected_pattern}
    ${prices}=    Get WebElements    ${price_locator}
    FOR    ${price}    IN    @{prices}
        ${price_text}=    Get Text    ${price}
        Should Match Regexp    ${price_text}    ${expected_pattern}    msg=Price '${price_text}' doesn't match expected format.
    END

Select EGP Currency
    Wait Until Element Is Visible    ${EGP_OPTION}
    Click Element    ${EGP_OPTION}
Verify EGP Currency
    [Documentation]    Verify prices are displayed in EGP format (EGP XX.XX)
    ${prices}=    Get WebElements    ${PRICE_TEXT}
    FOR    ${price}    IN    @{prices}
        ${price_text}=    Get Text    ${price}
        Should Match Regexp    ${price_text}    ^\\EGP\\s*\\d+(\\.\\d{2})?$    msg=Price '${price_text}' is not in EGP format.
    END