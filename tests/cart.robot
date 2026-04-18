*** Settings ***
Library    OperatingSystem
Resource    ../keywords/common.robot
Suite Setup       Initialize Result List
Test Teardown     Save Test Result
Suite Teardown    Send Results To Sheet


*** Test Cases ***
TC_Cart_026 Display cart screen correctly.
    Open URL    ${BASE_URL}
    Login With Credentials    standard_user    secret_sauce
    Click    //a[@class="shopping_cart_link"]
    # Verify cart screen
    ${page_title}=    Get Text   //span[@class="title"]
    Should Be Equal    ${page_title }    Your Cart 
    ${cart_quantity}=    Get Text    //div[@class="cart_quantity_label"]
    Should Be Equal    ${cart_quantity }    QTY
    ${cart_desc}=    Get Text    //div[@class="cart_desc_label"]
    Should Be Equal    ${cart_desc}    Description
    ${Button_cont}=    Get Text    //button[@class="btn btn_secondary back btn_medium"]
    Should Be Equal    ${Button_cont}    Continue Shopping
    ${Button_check}=    Get Text    //button[@class="btn btn_action btn_medium checkout_button "]
    Should Be Equal    ${Button_check}    Checkout   

TC_Cart_027 Display added item correctly.
    Open URL    ${BASE_URL}
    Login With Credentials    standard_user    secret_sauce
    Click    //button[@id="add-to-cart-sauce-labs-backpack"]
    Click    //a[@class="shopping_cart_link"]
    # Verify added item in cart
    ${item_name}=    Get Text    //div[@class="inventory_item_name"]
    Should Be Equal    ${item_name}    Sauce Labs Backpack

TC_Cart_028 Display added multiple items correctly.
    Open URL    ${BASE_URL}
    Login With Credentials    standard_user    secret_sauce
    Click    //button[@id="add-to-cart-sauce-labs-backpack"]
    Click    //button[@id="add-to-cart-sauce-labs-bike-light"]
    Click    //a[@class="shopping_cart_link"]
    # Verify added item in cart
    FOR    ${index}    IN RANGE    1    3
        ${item_name}=    Get Text    (//div[@class="inventory_item_name"])[${index}]
        Run Keyword If    '${item_name}' == 'Sauce Labs Backpack'    Should Be Equal    ${item_name}    Sauce Labs Backpack
        ...    ELSE IF    '${item_name}' == 'Sauce Labs Bike Light'    Should Be Equal    ${item_name}    Sauce Labs Bike Light
        ...    ELSE    Fail    Item name is not correct: ${item_name}
    END