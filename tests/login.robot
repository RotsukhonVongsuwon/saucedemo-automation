*** Settings ***
Library    OperatingSystem
Resource    ../keywords/common.robot
Suite Setup       Initialize Result List
Test Teardown     Save Test Result
Suite Teardown    Send Results To Sheet


*** Test Cases ***
TC_Login_001 User input invalid username
    Open URL    ${BASE_URL}
    Login With Credentials    invalid_username    secret_sauce
    Get Text    [data-test="error"]    ==    Epic sadface: Username and password do not match any user in this service


TC_Login_002 User input invalid password
    Open URL    ${BASE_URL}
    Login With Credentials    standard_user    invalid_password
    Get Text    [data-test="error"]    ==    Epic sadface: Username and password do not match any user in this service

TC_Login_003 User leave blank on username
    Open URL    ${BASE_URL}
    Login With Credentials    ${EMPTY}    secret_sauce
    Get Text    [data-test="error"]    ==    Epic sadface: Username is required

TC_Login_004 User leave blank on password
    Open URL    ${BASE_URL}
    Login With Credentials    standard_user    ${EMPTY}
    Get Text    [data-test="error"]    ==    Epic sadface: Password is required

TC_Login_005 User login with username has been locked out
    Open URL    ${BASE_URL}
    Login With Credentials    locked_out_user    secret_sauce
    Get Text    [data-test="error"]    ==    Epic sadface: Sorry, this user has been locked out.

TC_Login_006 User login with username have problem
    Open URL    ${BASE_URL}
    Login With Credentials    problem_user    secret_sauce
    # Verify login success
    Get Url    contains    inventory
    # Verify image incorrect (example: src not match expected)
    ${img}=    Get Attribute    (//img[@class="inventory_item_img"])[1]    src
    Should Not Contain    ${img}    sauce-backpack-1200x1500

TC_Login_007 User input valid username and password #(E2E)
    Open URL    ${BASE_URL}
    Login With Credentials    standard_user    secret_sauce
    # Verify login success
    Get Url    contains    inventory
    # Verify image correct (example: src match expected)
    ${img}=    Get Attribute    (//img[@class="inventory_item_img"])[1]    src
    Should Contain    ${img}    sauce-backpack-1200x1500

