*** Comments ***
Documentation
... Suite with common system features
... Resources used in all scenarios

*** Settings ***
Library     random
Library     String
Library     Browser
Library     BuiltIn
Library     Process
Library     BuiltIn
Library     DateTime
Library     Collections
Library     JSONLibrary
Library     RequestsLibrary
Library     OperatingSystem
Library     FakerLibrary    locale=pt_BR

*** Variables ***
${SCRIPT_PDF}                     support/convert_to_pdf.py
${Dev}      https://www.google.com/
${Stg}      URL do ambiente
${Prd}      URL do ambiente
# ${browser}      chromium
${browser}      firefox
# ${browser}      webkit
${Headless}     False
# ${Headless}     True

*** Keywords ***
Open Website
    Set Browser Timeout  30
    New Persistent Context      browser=${browser}    headless=${Headless}     ignoreHTTPSErrors=true     viewport={'width': 1536, 'height': 700}
    Run Keyword if  "${device}" == "s1"
    ...    Start S1
    Run Keyword if  "${device}" == "s2"
    ...    Start S2
    Run Keyword if  "${device}" == "s3"
    ...    Start S3
    Set Execution Base Folder

Start S1
    Go To    ${Dev}
    Wait For Load State     domcontentloaded

Start S2
    Go To   ${Stg}
    Wait For Load State     domcontentloaded

Start S3
    Go To   ${Prd}
    Wait For Load State     domcontentloaded

Set Execution Base Folder
    ${Timestamp}=    Evaluate    __import__('datetime').datetime.now().strftime('%d-%m-%Y')
    Set Global Variable    ${EXECUTION_DATE_FOLDER}    ${Timestamp}
    Set Suite Variable     ${PDF_TIMESTAMP}          ${Timestamp}

Close Website
    Generate PDF with All Prints
    Clear Generated Evidence
    Close Browser

Capture Screenshot
    ${SuiteName}=        Replace String    ${SUITE NAME}    ${SPACE}    -
    ${SuiteName}=        Replace String    ${SuiteName}     :           -
    ${TestName}=         Replace String    ${TEST NAME}     ${SPACE}    -
    ${TestName}=         Replace String    ${TestName}      :           -
    ${ScreenshotDir}=    Set Variable      evidence/screenshots/${SuiteName}/${TestName}
    Create Directory     ${ScreenshotDir}
    ${Timestamp}=        Evaluate          datetime.datetime.now().strftime('%H-%M-%S')    datetime
    ${FileName}=         Set Variable      ${TestName}_${Timestamp}.png
    ${FilePath}=         Set Variable      ${ScreenshotDir}/${FileName}
    Sleep                2
    Take Screenshot      ${OUTPUTDIR}/${FilePath}    fullPage=True

Ensure Directory Is Ready
    [Arguments]    ${Directory}    ${Timeout}=5s    ${RetryInterval}=0.5s
    Wait Until Keyword Succeeds
    ...    ${Timeout}
    ...    ${RetryInterval}
    ...    Directory Should Exist    ${Directory}

Generate PDF with All Prints
    ${SuiteName}=         Replace String    ${SUITE NAME}    ${SPACE}    -
    ${SuiteName}=         Replace String    ${SuiteName}     :           -
    ${TestName}=          Replace String    ${TEST NAME}     ${SPACE}    -
    ${TestName}=          Replace String    ${TestName}      :           -
    ${ScreenshotDir}=     Join Path         ${OUTPUTDIR}    evidence    screenshots    ${SuiteName}    ${TestName}
    ${PdfOutputDir}=      Join Path         ${OUTPUTDIR}    evidence    pdf    ${EXECUTION_DATE_FOLDER}    ${SuiteName}
    Create Directory    ${PdfOutputDir}
    Ensure Directory Is Ready    ${PdfOutputDir}
    ${ResultsPdf}=        Join Path         ${PdfOutputDir}    ${TestName}.pdf
    ${ScriptPdf}=         Normalize Path    ${CURDIR}/convert_to_pdf.py
    ${Prints}=            List Files In Directory    ${ScreenshotDir}    pattern=(?i).*\.png$
    ${Python}=            Evaluate    sys.executable    sys
    ${Result}=            Run Process
    ...    ${Python}
    ...    ${ScriptPdf}
    ...    ${ScreenshotDir}
    ...    ${ResultsPdf}
    ...    shell=True
    ...    stdout=TRUE
    ...    stderr=TRUE

Clear Generated Evidence
    ${ScreenshotDir}=    Join Path    ${OUTPUTDIR}    evidence    screenshots
    Run Keyword And Ignore Error    Remove Directory    ${ScreenshotDir}    recursive=True
    ${TrueFile}=         Join Path    ${OUTPUTDIR}    TRUE
    Run Keyword And Ignore Error    Remove File    ${TrueFile}
    ${LogFile}=          Join Path    ${OUTPUTDIR}    playwright-log.txt
    Run Keyword And Ignore Error    Remove File    ${LogFile}