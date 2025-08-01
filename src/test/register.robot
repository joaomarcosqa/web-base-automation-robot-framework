*** Comments ***
Documentation
...Suite with registration tests

*** Settings ***
Resource         ../main/support/commom-resources.robot
Resource         ../main/pages/login.robot

Test Setup       Open Website
Test Teardown    Close Website

*** Test Cases ***