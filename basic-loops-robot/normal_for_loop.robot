*** Test Cases ***
Log Test Results
    FOR    ${test}    IN    Test1    Test2    Test3
        Log To Console   ${test}
        ${length}=    Get Length    ${test}
        Should Be True    ${length} > 4
    END
