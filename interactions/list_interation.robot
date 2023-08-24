*** Test Cases ***
Log Test Results
    @{tests}=    Create List    TestA    TestB    TestC
    FOR    ${test}    IN    @{tests}
        Log To Console    ${test}
    END