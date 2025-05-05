*** Settings ***
Library    SeleniumLibrary
Suite Setup     Open Browser To AliExpress Homepage
Suite Teardown  Close All Browsers

*** Variables ***
${HOMEPAGE_URL}    https://www.aliexpress.com/
${BROWSER}        firefox
${LANGUAGE_DROPDOWN}    class=es--wrap--RYjm1RT
${CLICK_ON_LANGSELECTOR}  xpath=//*[@id="_full_container_header_23_"]/div[2]/div/div[2]/div[2]/div[2]/div[4]/div/div[1]
${ARABIC_OPTION}    xpath=//*[@id="_full_container_header_23_"]/div[2]/div/div[2]/div[2]/div[2]/div[4]/div/div[2]/div[3]
${ENGLISH_OPTION}    xpath=//*[@id="_full_container_header_23_"]/div[2]/div/div[2]/div[2]/div[2]/div[4]/div/div[2]/div[2]
${LANGUAGE_CONFIRM_BUTTON}    class=es--saveBtn--w8EuBuy
${CLOSE_ADD}  class=_24EHh
${LANGUAGE_SEARCH_BAR}  xpath=//*[@id="_full_container_header_23_"]/div[2]/div/div[2]/div[2]/div[2]/div[4]/div/div[2]/div[1]/input
${SPANISH_OPTION}  xpath=//*[@id="_full_container_header_23_"]/div[2]/div/div[2]/div[2]/div[2]/div[6]/div/div[2]/div[3]
${SEARCHITEM}    xpath=//*[@id="search-words"]
${SEARCHBAR}    xpath=/html/body/div[1]/div[1]/div/div/div[2]/div/div[1]/div/input[2]

*** Test Cases ***
Verify User Can Change Website Language To English
    [Documentation]    Test that user can change website language  to English
    Close Add
    Open Language Settings
    Select English Language
    Confirm Language Change
    Verify Language Changed To English


Verify User Can Change Website Language To Arabic
    [Documentation]    Test that user can change website language back to Arabic
    Close Add
    Open Language Settings
    Select Arabic Language
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
    Page Should Contain Element    Español
#it will fail because its a bug the user have limited language optiobs based on the country

Verify Language Change During Search Doesn't Redirect To Homepage
    [Documentation]    Test that changing language during search keeps user on search results
    Perform Search For Item
    Open Language Settings
    Select Arabic Language
    Confirm Language Change
    Verify Still On Search Results Page
    [Teardown]    Change Language To English
*** Keywords ***
Open Browser To AliExpress Homepage
    Open Browser    ${HOMEPAGE_URL}    ${BROWSER}
    Maximize Browser Window
    Set Selenium Implicit Wait    10 seconds
Close Add
  Click Element    ${CLOSE_ADD}
Open Language Settings

    Click Element    ${LANGUAGE_DROPDOWN}
    Click Element    ${CLICK_ON_LANGSELECTOR}
#    Wait Until Element Is Visible    ${ARABIC_OPTION}

Select Arabic Language
    Click Element    ${ARABIC_OPTION}

Select English Language
    Click Element    ${ENGLISH_OPTION}

Confirm Language Change
    Click Element    ${LANGUAGE_CONFIRM_BUTTON}
    Sleep    5s    # Wait for language change to take effect

Verify Language Changed To Arabic
    Wait Until Page Contains Element    class=fw_fy    timeout=5s
    Page Should Contain Element    //*[@id="root"]/div[2]/div[4]/div/div/div/div/div[1]/span

Verify Language Changed To English
    Wait Until Page Contains Element   class=Categoey--categoryTitle--_3bKGRN    timeout=5s
    Page Should Contain Element    class=Categoey--categoryTitle--_3bKGRN


Reload Page And Verify Arabic Language
    Reload Page
    Wait Until Page Contains Element    class=fw_fy    timeout=5s
    Page Should Contain Element    //*[@id="root"]/div[2]/div[4]/div/div/div/div/div[1]/span

Change Language To English
    Click Element    ${LANGUAGE_DROPDOWN}
    Click Element    ${CLICK_ON_LANGSELECTOR}
    Click Element    ${ENGLISH_OPTION}

#Search Any Language
#   Click Element    ${LANGUAGE_DROPDOWN}
#   Click Element    ${SEARCH_BAR}
#   Input Text    ${SEARCH_BAR}    Español
#Select Language
#    Click Element    ${SPANISH_OPTION}
#
#Verify Language Change
#    Wait Until Page Contains Element    //*[@id="root"]/div[2]/div[1]/div/div/div/div[1]/div[1]/div/div/div[1]/div/div/div    timeout=5s
#    Page Should Contain Element    //*[@id="root"]/div[2]/div[1]/div/div/div/div[1]/div[1]/div/div/div[1]/div/div/div
#Search And Select Language
#    [Arguments]    ${language_name}
#    Input Text    ${SEARCH_BAR}    ${language_name}
#    # Use a dynamic XPath to click the language option matching the input
#    Click Element    xpath=//div[contains(@id, '_full_container_header_23_') and contains(text(), '${language_name}')]
#
#Verify Language Changed To
#    [Arguments]    ${expected_language}
#    # Example: Check for a unique element/text in the selected language
#    Wait Until Page Contains Element    xpath=//*[contains(text(), '${expected_language}')]    timeout=10s
#    Page Should Contain Element    xpath=//*[contains(text(), '${expected_language}')]


Search For Language
    [Arguments]    ${language}
#    Wait Until Element Is Visible    ${LANGUAGE_SEARCH_BAR}
    Click Element    ${LANGUAGE_SEARCH_BAR}
    Input Text    ${LANGUAGE_SEARCH_BAR}    ${language}

Perform Search For Item
    Input Text    ${SEARCHITEM}    laptop
    Click Element    ${SEARCHBAR}

Verify Still On Search Results Page
    Page Should Not Contain    عروض اليوم