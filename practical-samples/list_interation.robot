*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${URL}    https://ecommerce-playground.lambdatest.io/index.php?route=account/register
${ELEMENT_CLASS}    css:.col-sm-2

*** Test Cases ***
Iterate Over Web Elements
    Open Browser    ${URL}    Chrome
    Maximize Browser Window
    @{items} =    Get WebElements    ${ELEMENT_CLASS}
    FOR    ${item}    IN    @{items}
        ${text} =    Get Text    ${item}
        Log To Console    ${text}
    END
    Close Browser
