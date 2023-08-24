*** Test Cases ***
Log Test Results
    &{test_results}=    Create Dictionary    TestA=Pass    TestB=Fail
    FOR    ${test}    ${result}    IN    &{test_results}
        Log To Console    ${test} result is ${result}
    END
