*** Settings *** 
Variables    ../resources/config.yaml
Variables    ../resources/test_data.yaml
Library    Browser  auto_closing_level=Suite
Library    RequestsLibrary
Library    Collections

*** Variables ***
@{RESULT_LIST}
${GSHEET_URL}    https://script.google.com/macros/s/AKfycbx0i6_Q2yE3dlT_iW-c3e1OiWno_nvycLlQwQgxSejDfABBvH9PaE0OQ3euJBTyON3V/exec

*** Keywords ***
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

Open URL
    [Arguments]    ${url}
    Set Browser Timeout    ${TIMEOUT}
    New Browser    ${BROWSER}    headless=${HEADLESS}
    New Context
    New Page    ${url}

Login With Credentials
    [Arguments]    ${username}    ${password}
    Fill Text    //input[@name="user-name"]    ${username}
    Fill Text    //input[@name="password"]     ${password}
    Click        'Login'

Verify Product count
    # Verify product display 6 items
    ${count}=    Get Element Count    //div[@class="inventory_item"]
    ${expected}=    Get Length    ${count}
    Should Be Equal As Integers    ${count}    ${expected}

Verify Product Name
    [Arguments]    @{expected}
    # ดึงชื่อสินค้า
    @{items}=    Get Elements    //div[@class="inventory_item_name "]

    @{display_item}=    Create List
    FOR    ${el}    IN    @{items}
        ${name}=    Get Text    ${el}
        Append To List    ${display_item}    ${name}
    END
    Lists Should Be Equal    ${display_item}    ${expected}

Verify Product Price   
    [Arguments]    @{expected}
    # ดึงราคาสินค้า
    @{prices}=    Get Elements    //div[@class="inventory_item_price"]

    @{display_price}=    Create List
    FOR    ${el}    IN    @{prices}
        ${text_price}=    Get Text    ${el}
        ${num}=    Evaluate    float("${text_price}".replace('$',''))
        Append To List    ${display_price}    ${num}
    END
    Lists Should Be Equal    ${display_price}    ${expected}

Verify Product Image    
    [Arguments]    @{expected}
    # ดึงรูปสินค้า
    @{images}=    Get Elements    //img[@class="inventory_item_img"]

    @{display_img}=    Create List
    FOR    ${el}    IN    @{images}
        ${src}=    Get Attribute    ${el}    src
        Append To List    ${display_img}    ${src}
    END

    ${length}=    Get Length    ${expected}

    FOR    ${index}    IN RANGE    0    ${length}
        Should Contain    ${display_img}[${index}]    ${expected}[${index}]
    END

Verify Product Description     
    [Arguments]    @{expected}
    # ดึง description สินค้า
    @{descs}=    Get Elements    //div[@class="inventory_item_desc"]

    @{display_desc}=    Create List
    FOR    ${el}    IN    @{descs}
        ${text_desc}=    Get Text    ${el}
        Append To List    ${display_desc}    ${text_desc}
    END

        ${length}=    Get Length    ${expected}
    FOR    ${index}    IN RANGE    0    ${length}
        Should Contain    ${display_desc}[${index}]    ${expected}[${index}]
    END

Verify Product Sorting
    [Arguments]    ${sort_value}    ${expected_names}    ${expected_prices}

    # เลือก sorting
    Select Options By    //select[@class="product_sort_container"]    value    ${sort_value}

    # ดึงชื่อสินค้า
    @{items}=    Get Elements    //div[@class="inventory_item_name "]
    # ดึงราคาสินค้า
    @{prices}=    Get Elements    //div[@class="inventory_item_price"]

    @{actual_name}=    Create List
    FOR    ${el}    IN    @{items}
        ${name}=    Get Text    ${el}
        Append To List    ${actual_name}    ${name}
    END
    
    @{actual_price}=    Create List
    FOR    ${el}    IN    @{prices}
        ${text_price}=    Get Text    ${el}
        ${num}=    Evaluate    float("${text_price}".replace('$',''))
        Append To List    ${actual_price}    ${num}
    END

    # expected จาก YAML
    @{expected_name}=    Copy List    ${expected_names}
    @{expected_price}=    Copy List    ${expected_prices}

    # logic sorting
    IF    '${sort_value}' == 'az'
        Sort List    ${expected_name}
    ELSE IF    '${sort_value}' == 'za'
        Sort List    ${expected_name}    
        Reverse List    ${expected_name}
    ELSE IF    '${sort_value}' == 'lohi'
        Sort List    ${expected_price}    
    ELSE IF    '${sort_value}' == 'hilo'
        Sort List    ${expected_price}
        Reverse List    ${expected_price}
    END

    # compare
    IF    '${sort_value}' in ['az','za']
        Lists Should Be Equal    ${actual_name}    ${expected_name}
    ELSE
        Lists Should Be Equal    ${actual_price}    ${expected_price}
    END