# Required Libraries for the automation script.
*** Settings ***
Library    SeleniumLibrary
Library    Collections
Library  String

# Configuration and Test Data variables.
*** Variables ***
# Base Test Configuration
${URL}    https://ecommerce-playground.lambdatest.io/index.php?route=account/register
${domain}    @gmail.com

# Data set for registration forms.
@{first_names} =    Paulo    Maria    John    Tatiane    Kim    Joana
@{last_names} =    Oliveira    Silva    Kennedy    Grey    Kardashian    Prado
@{telephones} =    999888777    888777666    777666555    666555444    555444333    444333222
@{passwords} =    123456    234567    345678    456789    567890    678901
&{users}   # empty dictionary to store users

# LambdaTest Cloud Grid configurations.
&{options}          browserName=Chrome     platform=Windows 11       version=latest      name=For Loop Test Case    buildName=For Loop Build Name        projectName=For Loop Project Name
&{CAPABILITIES}     LT:Options=&{options}
${REMOTE_URL}       http://%{LT_USERNAME}:%{LT_ACCESS_KEY}@hub.lambdatest.com/wd/hub

# Custom Keywords
*** Keywords ***
# Keyword to generate a random string of given length.
Generate Random String
    [Arguments]  ${length}=8
    ${random_string} =  Evaluate  ''.join(random.choices(string.ascii_letters + string.digits, k=${length}))  modules=random,string
    [Return]  ${random_string}

# Keyword to generate a user data set for the registration forms.
Prepare Test Data
    Log To Console    Preparing test data...
    ${len} =   Get Length   ${first_names}
    FOR    ${i}    IN RANGE    ${len}
        ${my_random_string} =  Generate Random String  10
        ${firstname} =     Get From List   ${first_names}   ${i}
        ${lastname} =     Get From List   ${last_names}   ${i}
        ${mail} =     Set Variable    ${my_random_string}${domain}
        ${phone} =     Get From List   ${telephones}   ${i}
        ${pwd} =     Get From List   ${passwords}   ${i}
        
        # Create an inner dictionary for each user
        &{user_info}=    Create Dictionary    firstname=${firstname}    lastname=${lastname}    email=${mail}    phone=${phone}    password=${pwd}
                                              
        # Store this user_info dict under the user's first name (or you can choose another key)
        Set To Dictionary    ${users}    ${firstname}    ${user_info}
    END
    Log To Console    Test data is now ready!

# Keyword to fill the registration form with provided user details.
Fill Form
    [Arguments]    ${firstname}    ${lastname}    ${email}    ${telephone}    ${password}
    Input Text    id=input-firstname    ${firstname}
    Input Text    id=input-lastname    ${lastname}
    Input Text    id=input-email    ${email}
    Input Text    id=input-telephone    ${telephone}
    Input Text    id=input-password    ${password}
    Input Text    id=input-confirm    ${password}
    Click Element    //label[@for='input-agree']
    Click Button    //input[@value='Continue']

# Keyword to reset the test environment after each iteration.
Tear Down
    Click Element    //a[@class='list-group-item'][14]
    Go To	${URL}

# Main Test Case: Register multiple users with the provided data set.
*** Test Cases ***
Test Multiple User Account Creations
    Prepare Test Data
    Log To Console    Starting test execution...
    Open Browser    ${URL}
    ...  remote_url=${REMOTE_URL}
    ...  desired_capabilities=${CAPABILITIES}
    Maximize Browser Window
    FOR    ${username}    ${userinfo}    IN    &{users}
        Fill Form    ${userinfo}[firstname]    ${userinfo}[lastname]    ${userinfo}[email]    ${userinfo}[phone]    ${userinfo}[password]
        Log To Console    Account for ${userinfo}[firstname] ${userinfo}[lastname] was created successfully!!!
        Tear Down
    END
    Close Browser
    Log To Console    Test execution is finished!