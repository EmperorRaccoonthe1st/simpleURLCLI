@echo off
setlocal enabledelayedexpansion



if not exist %cd%\urlData (
    echo /n
    echo No data folder in dir
    echo Making urlData folder and urls.text file 
    mkdir urlData
    cd urlData
    "" > urls.txt
) else (
    echo Hay Folder
    set file="urlData\urls.txt"
)


if "%2"=="" (    
   if not "%1"=="" (
    for /F "tokens=1,2 usebackq delims=@" %%G in (%file%) do (
            set alias=%%G
            set url=%%H
            if !alias!==%1 (
                start !url!
                GOTO end
            )
        )

    ) else (
        echo Make sure to pass an alias or tag
    )

) else (
    if "%2"=="-n" (
        echo %1 >> %file%

    )   else (
        echo Pass "-n" to add a new alias. Split the alias and url by an "@"
    )
)
endlocal

:end