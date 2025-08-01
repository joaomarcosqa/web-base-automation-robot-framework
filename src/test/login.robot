*** Comments ***
Documentation
...Suite with login tests

*** Settings ***
Resource         ../main/support/base.robot
Resource         ../main/pages/login.robot
Resource    ../main/pages/register.robot

Test Setup       Open Website
Test Teardown    Close Website

*** Test Cases ***
Test Case 001: Validate Invalid Cep Page
    [Documentation]    Neste cenário em questão, foi enviado um cep invalido,
    ...    para validação da pagina onde o usuário é direcionado, 
    ...    caso insira um cep não existente.
    [Tags]        Alternative
    Given im on the home page
#     When entering an invalid zip code    ${MainUser}   ${MainUSerPassword}
#     Then I validate the error screen



