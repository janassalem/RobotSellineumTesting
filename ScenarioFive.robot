*** Settings ***
Documentation     Verify user can login to their account on AliExpress
Library           SeleniumLibrary
Suite Setup       Open Browser To AliExpress
Suite Teardown    Close All Browsers

*** Variables ***
${BROWSER}        firefox
${ALIEXPRESS_URL}    https://www.aliexpress.com/
${VALID_USERNAME}   janamohamed248@gmail.com
${VALID_PASSWORD}    ONEDIRECTION
${LOGIN_BUTTON}    class=my-account--signin--RiPQVPB
${CONTINUE_BUTTON}   xpath=//*[@id="batman-dialog-wrap"]/div/div/div/div[1]/div/div[3]/div[3]/button
${USERNAME_FIELD}    xpath=//*[@id="batman-dialog-wrap"]/div/div/div/div[1]/div/div[3]/div[2]/div/span/span[1]/span[1]/input
${INVALID_USER}       invalid_user@example.com
${PASSWORD_FIELD}    xpath=//*[@id="fm-login-password"]
${INVALID_PASSWORD}    invalid_password123
${SUBMIT_BUTTON}    xpath=//*[@id="batman-dialog-wrap"]/div/div/div/div[1]/div[9]/button
${ACCOUNT_MENU}    xpath=//*[@id="_full_container_header_23_"]/div[2]/div/div[2]/div[3]
${CLOSE_ADD}             class=_24EHh



*** Test Cases ***
Verify Successful Login
    [Documentation]    Test that user can login with valid credentials
    Close Popup Ads
    When User Clicks Sign In Button
    And Enters Valid Credentials
    And Clicks Submit Button
    Then User Should Be Redirected To Account Page
    And Account Menu Should Be Visible
Verify Login Fails With Invalid Password
    [Documentation]    Test that user cannot login with invalid password
    Close Popup Ads
    When User Clicks Sign In Button
    And Enters Valid Username
    And Enters Invalid Password
    And Clicks Submit Button
    Then Error Message Should Be Displayed
    And User Should Not Be Logged In

Verify Login Fails With Invalid Username
    [Documentation]    Test that user cannot login with invalid username
    Close Popup Ads
    When User Clicks Sign In Button
    And Enters Invalid Username
    And Clicks Continue Button
    Then Username Error Message Should Be Displayed

*** Keywords ***
Open Browser To AliExpress
    Open Browser    ${ALIEXPRESS_URL}    ${BROWSER}
    Maximize Browser Window
    Set Selenium Speed    0.5 seconds

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
#    Click Button    ${CONTINUE_BUTTON}
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