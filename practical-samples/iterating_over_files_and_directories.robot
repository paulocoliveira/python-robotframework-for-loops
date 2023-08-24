*** Settings ***
Library    OperatingSystem

*** Test Cases ***
Process Files In Directory
    ${path} =    Set Variable    test-scripts-directory
    @{files} =    List Files In Directory    ${path}
    FOR    ${file}    IN    @{files}
        Log To Console    Processing file: ${file}
    END
