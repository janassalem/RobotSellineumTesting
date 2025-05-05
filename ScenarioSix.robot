*** Settings ***
Library    SeleniumLibrary
Library    Collections
Suite Setup     Open Browser To AliExpress Homepage
Suite Teardown  Close All Browsers

*** Variables ***
${HOMEPAGE_URL}          https://www.aliexpress.com/
${BROWSER}               firefox
${SHIP_TO_DROPDOWN}      class=ship-to--text--3H_PaoC
${CURRENCY_DROPDOWN}     xpath=//*[@id="_full_container_header_23_"]/div[2]/div/div[2]/div[2]/div[2]/div[6]/div
${USD_OPTION}            xpath=//*[@id="_full_container_header_23_"]/div[2]/div/div[2]/div[2]/div[2]/div[6]/div/div[2]/div[2]
${EGP_OPTION}            xpath=//*[@id="_full_container_header_23_"]/div[2]/div/div[2]/div[2]/div[2]/div[6]/div/div[2]/div[4]
${CURRENCY_CONFIRM}      class=es--saveBtn--w8EuBuy
${PRICE_LOCATOR}         xpath=//*[@id="root"]/div[2]/div[4]/div/div/div/div/div[2]/div[2]/a/div/div[2]/div/div[2]/div[1]/div/div/div/div[2]/div[2]/div/span[1]
${LANGUAGE_DROPDOWN}     class=es--wrap--RYjm1RT
${LANGUAGE_SELECTOR}     xpath=//*[@id="_full_container_header_23_"]/div[2]/div/div[2]/div[2]/div[2]/div[4]/div/div[1]
${ENGLISH_OPTION}        xpath=//*[@id="_full_container_header_23_"]/div[2]/div/div[2]/div[2]/div[2]/div[4]/div/div[2]/div[2]
${CLOSE_ADD}             class=_24EHh
${EPRICE_LOCATOR}        xpath=//*[@id="root"]/div[2]/div[7]/div/div/div/div[2]/div[3]/div/div/a/div[2]/div[3]/div[1]/span[1]
${PRICE_TEXT}             EGP
${SAR_OPTION}            xpath=//*[@id="_full_container_header_23_"]/div[2]/div/div[2]/div[2]/div[2]/div[6]/div/div[2]/div[3]
${SAR_PRICELOCATOR}      xpath=//*[@id="root"]/div[2]/div[4]/div/div/div/div/div[2]/div[1]/a/div/div[2]/div/div[2]/div[3]/div/div/div/div[2]/div[2]/div/span[1]

*** Test Cases ***
Verify User Can Change Currency From EGP To USD
    [Documentation]    Test that user can change currency from EGP to USD
    Close Popup Ads
    Open Currency Menu
    Select USD Currency
    Confirm Currency Change
    Verify USD Currency

Verify User Can Change Currency Back To EGP
    [Documentation]    Test that user can revert currency from USD to EGP
    Close Popup Ads
    Open Currency Menu
    Select EGP Currency
    Confirm Currency Change
    Verify EGP Currency

Verify User Can Change Currency to SAR
       [Documentation]    Test that user can revert currency from USD to EGP
       Close Popup Ads
       Open Currency Menu
       Select SAR Currency
       Confirm Currency Change
       Verify SAR Currency

*** Keywords ***
Open Browser To AliExpress Homepage
    Open Browser    ${HOMEPAGE_URL}    ${BROWSER}
    Maximize Browser Window
    Set Selenium Implicit Wait    10 seconds

Close Popup Ads
    Run Keyword And Ignore Error    Click Element    ${CLOSE_ADD}
    Sleep    2s

Open Currency Menu
  Wait Until Element Is Visible    ${SHIP_TO_DROPDOWN}    timeout=10s
    Click Element    ${SHIP_TO_DROPDOWN}
    Wait Until Element Is Visible    ${CURRENCY_DROPDOWN}    timeout=10s
    Click Element    ${CURRENCY_DROPDOWN}
    Sleep    1s  # Small pause for dropdown animation

Select USD Currency
    Wait Until Element Is Visible    ${USD_OPTION}
    Click Element    ${USD_OPTION}

Select EGP Currency
    Wait Until Element Is Visible    ${EGP_OPTION}
    Click Element    ${EGP_OPTION}

Confirm Currency Change
    Click Element    ${CURRENCY_CONFIRM}
    Sleep    3s  # Wait for currency change to take effect

Verify USD Currency
    [Documentation]    Verify prices are displayed in USD format ($XX.XX)
    ${prices}=    Get WebElements    ${PRICE_LOCATOR}
    FOR    ${price}    IN    @{prices}
        ${price_text}=    Get Text    ${price}
        Should Match Regexp    ${price_text}    ^\\$\\d+(\\.\\d{2})?$    msg=Price '${price_text}' is not in USD format.
    END

Verify EGP Currency
    [Documentation]    Verify prices are displayed in EGP format (EGP XX.XX)
    ${prices}=    Get WebElements    ${PRICE_TEXT}
    FOR    ${price}    IN    @{prices}
        ${price_text}=    Get Text    ${price}
        Should Match Regexp    ${price_text}    ^\\EGP\\s*\\d+(\\.\\d{2})?$    msg=Price '${price_text}' is not in EGP format.
    END

Select SAR Currency
     Wait Until Element Is Visible    ${SAR_OPTION}
    Click Element    ${SAR_OPTION}



Verify SAR Currency

    ${prices}=    Get WebElements    ${SAR_PRICELOCATOR}
    FOR    ${price}    IN    @{prices}
        ${price_text}=    Get Text    ${price}
        Should Match Regexp    ${price_text}    ^\\ر.س.\\s*\\d+(\\.\\d{2})?$    msg=Price '${price_text}' is not in EGP format.
    END