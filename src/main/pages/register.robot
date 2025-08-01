*** Comments ***
Documentation
... Suite with system register resources

*** Settings ***
Resource         ../support/base.robot

*** Variables ***
${registerVariable}

*** Keywords ***
Given im on the site


When accessing the website login page
    Wait for Elements State               
    Click
    Wait for Elements State          

Then i must login successfully
    Fill Text
    Fill Text
    Wait for Elements State            
    Click
    Wait for Elements State