*** Comments ***
Documentation
... Suite with system login resources

*** Settings ***
Resource         ../support/base.robot

*** Variables ***
${LoginVariable}            Login variable
${ErrorMessage}             Algo deu errado. Vou te ajudar...
*** Keywords ***
Given im on the home page
    Capture Screenshot

When entering an invalid zip code
    [Arguments]        ${FakeCep}    ${FakeNumber}
    Validate and Fill Text    ${LoginVariable}    ${FakeCep}
    Validate and Fill Text    ${LoginVariable}    ${FakeNumber}
    Validate and Click    ${LoginVariable}

Then I validate the error screen
    Validate Text on Screen    ${LoginVariable}    ${ErrorMessage}
    Wait For Elements State    ${LoginVariable}