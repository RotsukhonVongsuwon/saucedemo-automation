*** Settings ***
Library    OperatingSystem
Resource    ../keywords/common.robot
Suite Setup       Initialize Result List
Test Teardown     Save Test Result
Suite Teardown    Send Results To Sheet


*** Test Cases ***
TC_Product_008 Display product list correctly.
    Open URL    ${BASE_URL}
    Login With Credentials    standard_user    secret_sauce
    # Verify product display 6 items
    ${count}=    Get Element Count    //div[@class="inventory_item"]
    Should Be Equal As Integers    ${count}    6

TC_Product_009 Display product name correctly
    Open URL    ${BASE_URL}
    Login With Credentials    standard_user    secret_sauce
    #Create list of expected product names
    @{expected}=    Create List
    ...    Sauce Labs Backpack
    ...    Sauce Labs Bike Light
    ...    Sauce Labs Bolt T-Shirt
    ...    Sauce Labs Fleece Jacket
    ...    Sauce Labs Onesie
    ...    Test.allTheThings() T-Shirt (Red)
    #loop for checking each product name
    FOR    ${index}    IN RANGE    1    7
        ${name}=    Get Text    (//div[@class="inventory_item_name "])[${index}]
        Should Be Equal    ${name}    ${expected}[${index-1}]
    END

TC_Product_010 Display product price correctly.
    Open URL    ${BASE_URL}
    Login With Credentials    standard_user    secret_sauce
    #Create list of expected product prices
    @{expected_prices}=    Create List
    ...    $29.99
    ...    $9.99
    ...    $15.99
    ...    $49.99
    ...    $7.99
    ...    $15.99
    #loop for checking each product price
    FOR    ${index}    IN RANGE    1    7
        ${price}=    Get Text    (//div[@class="inventory_item_price"])[${index}]
        Should Be Equal    ${price}    ${expected_prices}[${index-1}]
    END

TC_Product_011 Display product image correctly.
    Open URL    ${BASE_URL}
    Login With Credentials    standard_user    secret_sauce
    #Create list of expected product images
    @{expected_img}=    Create List
    ...    sauce-backpack-1200x1500
    ...    bike-light-1200x1500
    ...    bolt-shirt-1200x1500
    ...    sauce-pullover-1200x1500
    ...    red-onesie-1200x1500
    ...    red-tatt-1200x1500
    #loop for checking each product image
    FOR    ${index}    IN RANGE    1    7
        ${img}=    Get Attribute    (//img[@class="inventory_item_img"])[${index}]    src
        Should Contain    ${img}    ${expected_img}[${index-1}]
    END

TC_Product_012 Display product description correctly.
    Open URL    ${BASE_URL}
    Login With Credentials    standard_user    secret_sauce
    #Create list of expected product descriptions
    @{expected_desc}=    Create List
    ...    carry.allTheThings
    ...    helps when riding your bike at night
    ...    Sauce Labs bolt T-shirt
    ...    jacket capable
    ...    Rib snap infant
    ...    Sauce Labs t-shirt
    #loop for checking each product description
    FOR    ${index}    IN RANGE    1    7
        ${desc}=    Get Text    (//div[@class="inventory_item_desc"])[${index}]
        Should Contain    ${desc}    ${expected_desc}[${index-1}]
    END 