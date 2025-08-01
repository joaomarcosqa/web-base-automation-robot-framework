*** Comments ***
Documentation
... Suite with base system features
... Resources used in all scenarios

*** Settings ***
Library     Browser
Resource    commom-resources.robot

*** Variables ***
${loginVariable}       loginVariable
${RegisterVariable}    registerVariable
${EmailTextField}
${PasswordTextfield}
${Submit}
${MainUser}   
${MainUSerPassword}

*** Keywords ***
Fill in Login
    [Arguments]              ${email}               ${password}
    Wait for Elements State    ${emailTextField}
    Fill Text                       ${emailTextField}                ${email}
    Fill Text                       ${passwordTextfield}             ${password}
    Click                    ${submit}

Fill in Registration
    [Arguments]                      ${firstNameTextField}            ${firstName}                        ${lastNameTextField}    ${lastName}    ${emailTextField}    ${email}    ${passwordTextField}    ${password}    ${registerButton}
    Wait for Elements State    ${firstNameTextField}
    Fill Text                       ${firstNameTextField}            ${firstName}
    Fill Text                       ${lastNameTextField}             ${lastName}
    Fill Text                       ${emailTextField}                ${email}
    Fill Text                       ${passwordTextField}             ${password}
    Click                    ${registerButton}

Validate and Fill Text
    [Arguments]                      ${selector}                       ${text}
    Wait for Elements State    ${selector}           timeout=30 s             
    Fill Text                       ${selector}                       ${text}
    Capture Screenshot

Validate Element
    [Arguments]                      ${selector}
    Wait for Elements State    ${selector}   timeout=30 s                    

Validate and Click
    [Arguments]                      ${selector}
    Wait for Elements State    ${selector}   timeout=30 s                    
    Click                    ${selector}
    Capture Screenshot

Validate Text on Screen
    [Arguments]    ${selector}    ${text}
    ${get_text}=    Get Text    ${selector}
    Should Contain    ${get_text}    ${text}

Wait For Complete Load
    Wait For Load State     domcontentloaded

Switch New Page
    [Arguments]                           ${Index}
    ${Pages}         Get Page Ids
    Switch Page                           id=${Pages[${Index}]}

Validate And Select
    [Arguments]                           ${Selector}               ${Text}
    Validate Element                      ${Selector}
    Select Options By                     ${Selector}    text    ${Text}

Select ${Type} Of Step
    IF    '${Type}' == 'Single'
        Validate And Click         ${Selector} 
    ELSE IF    '${Type}' == 'Multiple'
        Validate Simple Element    ${Selector} 
        Validate Simple Element    ${Selector} 
    ELSE
        Fail    Invalid Type: ${Type}
    END