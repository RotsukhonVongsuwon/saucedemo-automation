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
    Verify Product count

TC_Product_009 Display product name correctly
    Open URL    ${BASE_URL}
    Login With Credentials    standard_user    secret_sauce
    Verify Product Name    @{product_names}

TC_Product_010 Display product price correctly.
    Open URL    ${BASE_URL}
    Login With Credentials    standard_user    secret_sauce
    Verify Product Price    @{product_prices}


TC_Product_011 Display product image correctly.
    Open URL    ${BASE_URL}
    Login With Credentials    standard_user    secret_sauce
    Verify Product Image    @{product_images}


TC_Product_012 Display product description correctly.
    Open URL    ${BASE_URL}
    Login With Credentials    standard_user    secret_sauce
    Verify Product Description    @{product_descriptions}


TC_Product_013 Sort by Name (A-Z) correctly.
    Open URL    ${BASE_URL}
    Login With Credentials    standard_user    secret_sauce
    Verify Product Sorting    az    ${product_names}    ${product_prices}

TC_Product_014 Sort by Name (Z-A) correctly
    Open URL    ${BASE_URL}
    Login With Credentials    standard_user    secret_sauce
    Verify Product Sorting    za    ${product_names}    ${product_prices}

TC_Product_015 Sort by Price (low-high) correctly
    Open URL    ${BASE_URL}
    Login With Credentials    standard_user    secret_sauce
    Verify Product Sorting    lohi    ${product_names}    ${product_prices}

TC_Product_016 Sort by Price (high-low) correctly
    Open URL    ${BASE_URL}
    Login With Credentials    standard_user    secret_sauce
    Verify Product Sorting    hilo    ${product_names}    ${product_prices}

TC_Product_017 Add to cart successfully.
    Open URL    ${BASE_URL}
    Login With Credentials    standard_user    secret_sauce
    Click    //button[@id="add-to-cart-sauce-labs-backpack"]
    # Verify cart badge
    ${badge}=    Get Text    //span[@class="shopping_cart_badge"]
    Should Be Equal    ${badge}    1
    # Verify Button 'Add to cart' change to 'Remove'
    ${btn_text}=    Get Text    //button[@data-test="remove-sauce-labs-backpack"]
    Should Be Equal    ${btn_text}    Remove

TC_Product_018 Remove from cart successfully.
    Open URL    ${BASE_URL}
    Login With Credentials    standard_user    secret_sauce
    Click    //button[@id="add-to-cart-sauce-labs-backpack"]
    Click    //button[@id="remove-sauce-labs-backpack"]
    # Verify cart badge
    ${badge}=    Get Text    //div[@class="shopping_cart_container"]
    Should Be Empty    ${badge}
    # Verify Button 'Remove' change to 'Add to cart'
    ${btn_text}=    Get Text    //button[@data-test="add-to-cart-sauce-labs-backpack"]
    Should Be Equal    ${btn_text}    Add to cart

TC_Product_019 Add muliple items to cart successfully.
    Open URL    ${BASE_URL}
    Login With Credentials    standard_user    secret_sauce
    Click    //button[@id="add-to-cart-sauce-labs-backpack"]
    Click    //button[@id="add-to-cart-sauce-labs-bike-light"]
    # Verify cart badge
    ${badge}=    Get Text    //span[@class="shopping_cart_badge"]
    Should Be Equal    ${badge}    2

TC_Product_020 Remove one item from multiple
    Open URL    ${BASE_URL}
    Login With Credentials    standard_user    secret_sauce
    Click    //button[@id="add-to-cart-sauce-labs-backpack"]
    Click    //button[@id="add-to-cart-sauce-labs-bike-light"]
    Click    //button[@id="remove-sauce-labs-bike-light"]
    # Verify cart badge
    ${badge}=    Get Text    //span[@class="shopping_cart_badge"]
    Should Be Equal    ${badge}    1

TC_Product_021 Cart badge increases after adding item
    Open URL    ${BASE_URL}
    Login With Credentials    standard_user    secret_sauce
    Click    //button[@id="add-to-cart-sauce-labs-backpack"]
    Click    //button[@id="add-to-cart-sauce-labs-bike-light"]
    Click    //button[@id="remove-sauce-labs-bike-light"]
    Click    //button[@id="add-to-cart-sauce-labs-bolt-t-shirt"]
    # Verify cart badge
    ${badge}=    Get Text    //span[@class="shopping_cart_badge"]
    Should Be Equal    ${badge}    2