*** Settings *** 
Variables    ../resources/config.yaml
Library    Browser  auto_closing_level=Suite
Library    RequestsLibrary
Library    Collections

*** Variables ***
@{RESULT_LIST}
${GSHEET_URL}    https://script.google.com/macros/s/AKfycbx0i6_Q2yE3dlT_iW-c3e1OiWno_nvycLlQwQgxSejDfABBvH9PaE0OQ3euJBTyON3V/exec

*** Keywords ***
Open URL
    [Arguments]    ${url}
    Set Browser Timeout    ${TIMEOUT}
    New Context
    New Page    ${url}

Login With Credentials
    [Arguments]    ${username}    ${password}
    Fill Text    //input[@name="user-name"]    ${username}
    Fill Text    //input[@name="password"]     ${password}
    Click        'Login'

Initialize Result List
    @{empty}=    Create List
    Set Suite Variable    @{RESULT_LIST}    @{empty}

Save Test Result
    ${tc}=        Evaluate    "${TEST NAME}".split(" ")[0]
    ${status}=    Set Variable    ${TEST STATUS}

    ${item}=    Create Dictionary
    ...    Test Case ID=${tc}
    ...    Test Result=${status}

    Append To List    ${RESULT_LIST}    ${item}
    Log    ${RESULT_LIST}

Send Results To Sheet
    Create Session    google    ${GSHEET_URL}

    ${body}=    Evaluate    json.dumps(${RESULT_LIST})    json

    ${headers}=    Create Dictionary
    ...    Content-Type=application/json

    POST On Session    google    ${GSHEET_URL}
    ...    data=${body}
    ...    headers=${headers}


