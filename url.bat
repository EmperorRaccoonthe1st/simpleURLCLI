@echo off
setlocal enabledelayedexpansion

set file=

:fileInnit
if exist "%cd%\urlData\" (
    if exist "%cd%\urlData\urls.txt" (
        set file=urlData\urls.txt
        GOTO subCommands 
    ) else (
        echo. > urls.txt
        echo no urls file found
        echo created new urls file
        exit
    )
) else (
    echo cannot find urlData folder
    echo creating urlData folder and urls.text file in local directory
    mkdir urlData
    cd urlData
    echo. > urls.txt
    exit
)


:subCommands
if "%1"=="-l" (GOTO list)
if "%1"=="-h" (GOTO help)
if "%1"=="-ea" (GOTO editAlias)
if "%1"=="-eu" (GOTO changeURL)
if "%1"=="-r" (GOTO removeLastChange)
if "%1"=="-n" (GOTO newAlias)
GOTO main

:list
echo all created alias:
for /F "tokens=1,2 usebackq delims=@" %%G in (%file%) do (
    set alias=%%G
    set url=%%H
    set "echoStatement=!alias! -> !url!"
    echo !echoStatement!
)
GOTO end


:help



:editAlias
if not "%2"=="" ( 
    if not "%3"=="" (
        for /F "tokens=1,2 usebackq delims=@" %%G in (%file%) do (
            set alias=%%G
            set url=%%H
            if %2==!alias! (
                
            )
        )
        echo %2 changed to %3
    ) else (
        echo make sure to pass the new alias
    )
) else (
    echo make sure to pass the alias you want changed
    )
GOTO end


:changeURL



:removeLastChange



:newAlias
if not "%2"=="" ( 
    if not "%3"=="" (
        echo %2@%3 >> %file%
        echo new alias created: %2 as %3
    ) else (
        echo make sure to pass a url
    )
) else (
    echo make sure to pass the alias and url 
)


:main
if not "%1"=="" (
    for /F "tokens=1,2 usebackq delims=@" %%G in (%file%) do (
            set alias=%%G
            set url=%%H
            if !alias!==%1 (
                start !url!
                exit
            )
        )
) else (
    echo make sure to pass an alias or tag
    echo pass  "-h" to get help
)

:end
endlocal