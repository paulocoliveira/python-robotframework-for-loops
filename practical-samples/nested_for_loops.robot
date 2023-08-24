*** Test Cases ***
Check Matrix Elements
    @{passed_tests} =    Create List    TestPassed1    TestPassed2    TestPassed3 
    @{failed_tests} =    Create List    TestFailed1    TestFailed2    TestFailed3
    @{matrix} =    Create List    @{passed_tests}    @{failed_tests}
    FOR    ${row}    IN    @{matrix}
        FOR    ${element}    IN    ${row}
            Log To Console    Test ID is: ${element}
        END
    END