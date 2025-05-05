*** Settings ***
Library    SeleniumLibrary
Suite Setup     Open Browser To AliExpress Homepage
Suite Teardown  Close All Browsers

*** Variables ***
${HOMEPAGE_URL}                     https://www.aliexpress.com/
${BROWSER}                          firefox
${PRODUCT_URL}                      //*[@id="card-list"]/div[1]/div/div/a/div[2]/div[3]
${PRODUCT_IMAGE}                    //*[@id="root"]/div/div[1]/div/div[1]/div[1]/div[1]/div/div[1]/div[1]/div/div/div[1]/div/img
${ZOOM_CONTAINER}                   //*[@id="root"]/div/div[1]/div/div[1]/div[1]/div[1]/div/div/div[2]/div[1]/div/div
${LIGHTBOX}                         /html/body/div[9]/div[2]/div/div[2]
${CLOSE_BUTTON}                     /html/body/div[9]/div[2]/div/button/span/svg
${SEARCHH_BUTTON_XPATH}             //*[@id="_full_container_header_23_"]/div[2]/div/div[1]/div/input[2]
${INPUT_TEXT_XPATH}                 //*[@id="search-words"]
${SEARCH_TERM}                      smart watch

*** Test Cases ***
Verify Product Images Can Be Zoomed
    [Documentation]    Test that product images can be zoomed on hover or open in lightbox view

    Input Search Term
    Click Search Button
    Wait Until Page Contains    ${SEARCH_TERM}      timeout=10s

    Go To Product Page

    #Hover Over Main Product Image
    #Verify Zoom Area Appears
    Click On Main Product Image
    Verify Lightbox Opens
    Close Lightbox

Verify Product Image Zoom Works After Refresh
    [Documentation]    Ensure zoom feature works after page refresh
    Hover Over Product Image
    Verify Zoom Is Displayed
    Reload Page
    Hover Over Product Image
    Verify Zoom Is Displayed Again

*** Keywords ***
Open Browser To AliExpress Homepage
    Open Browser    ${HOMEPAGE_URL}    ${BROWSER}
    Maximize Browser Window
    Set Selenium Implicit Wait    10 seconds

Go To Product Page
    Click Element   ${PRODUCT_URL}
    Wait Until Element Is Visible       ${ZOOM_CONTAINER}    timeout=15s
    #sleep  3

#Hover Over Main Product Image
#    Mouse Over    ${ZOOM_CONTAINER}
#    Sleep    2s

#Verify Zoom Area Appears
#    Wait Until Element Is Visible    ${ZOOM_CONTAINER}    timeout=5s
#    #Page Should Contain Element    ${ZOOM_CONTAINER}

Click On Main Product Image
    Click Element        ${ZOOM_CONTAINER}
    #Sleep    2s

Verify Lightbox Opens
    Wait Until Element Is Visible    ${LIGHTBOX}    timeout=5s
    Page Should Contain Element    ${LIGHTBOX}

Close Lightbox
    Click Element    ${CLOSE_BUTTON}
    Sleep    2s

Open Product Page
    Open Browser    ${PRODUCT_URL}    ${BROWSER}
    Maximize Browser Window
    Set Selenium Implicit Wait    10 seconds

Hover Over Product Image
    Mouse Over    ${ZOOM_CONTAINER}
    Sleep    2s

Verify Zoom Is Displayed
    Wait Until Page Contains Element    ${ZOOM_CONTAINER}    timeout=5s
    Page Should Contain Element    ${ZOOM_CONTAINER}

Verify Zoom Is Displayed Again
    Wait Until Page Contains Element    ${ZOOM_CONTAINER}    timeout=5s
    Page Should Contain Element    ${ZOOM_CONTAINER}


Input Search Term
    Input Text          ${INPUT_TEXT_XPATH}         ${SEARCH_TERM}

Click Search Button
    Click Element       ${SEARCHH_BUTTON_XPATH}

