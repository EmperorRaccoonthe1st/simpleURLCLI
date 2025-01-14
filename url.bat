@echo off
setlocal enabledelayedexpansion

set file=

:fileInnit
if exist "%cd%\urlData\" (
    if exist "%cd%\urlData\urls.txt" (
        set file=urlData\urls.txt
        GOTO main 
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





:main
if "%3"=="" (    
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
        exit
    )

) else (
    if "%3"=="-n" (
        echo %1@%2 >> %file%
        exit
    )   else (
        echo ass "-n" to add a new alias. First argument is the alias then followed by the url
        exit
    )
)
endlocal