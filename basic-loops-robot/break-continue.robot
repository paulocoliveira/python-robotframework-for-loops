*** Test Cases ***
Test Using Continue and Exit
    # Create the users list
    @{user_list}=    Create List    User1    User2    BlockedUser    User4    User5    User6    BlockedUser    User8    ThiefUser    User10

    # Iterate through the users list and perform the validation
    FOR    ${user}    IN    @{user_list}
        Continue For Loop If    '${user}' == 'BlockedUser'
        Exit For Loop If    '${user}' == 'ThiefUser'
        Log To Console    ${user} processed successfully.
    END

    Log To Console    Process finished successfully.