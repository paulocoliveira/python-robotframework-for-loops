*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${URL}    https://www.lambdatest.com/selenium-playground/simple-form-demo

*** Keywords ***
Message Action
    [Arguments]    ${message}
    Input Text    id=user-message    ${message}
    Click Button    id=showInput
    ${text} =    Get Text    id=message
    Log To Console    ${text}

*** Test Cases ***
Test Multiple Form Messages
    @{messages} =    Create List    message1    message2    message3    message4    message5    message6    message7
    Open Browser    ${URL}    Chrome
    Maximize Browser Window
    FOR    ${message}    IN    @{messages}
        Message Action    ${message}
    END