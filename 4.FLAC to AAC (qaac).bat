@echo off
echo #########################################
echo ## FLAC-To-AAC v1.0		       ##
echo #########################################

REM Set the title of the cmd window. %~n0 is script name, %cd% is current working directory.
TITLE Executing %~n0 in (%cd%)

REM Make some required folders if they dont exist.
if not exist "%cd%/AAC" mkdir "%cd%/AAC"

REM Do some magic. %~x1 = file exention. Stops the script from running on anything but .flac files.
if %~x1 == .flac (
    REM Move files so that batch can happen without false positives
    echo [93mNote: Moving files to ~temp folder for simultaneous transfers.[0m 
    echo.

    for %%f in (%*) do (
        if not exist ~temp mkdir ~temp
        move %%f "%cd%\~temp\%%~nxf"
    )
    :override
    for %%i in (*.flac) do (
    "%~dp0/qaac/qaac_2.55/x64/qaac64.exe" "%cd%/~temp/%%~i" --tvbr 127 --rate keep --no-delay --no-smart-padding --quality 2 -o "%cd%\AAC\%%~ni.aac"
    )
    
    REM Move files back from ~temp folder to thier original location, delete ~temp folder after
    echo Moving files back to their original location and deleting ~temp foler.

    echo off
    REM move files back
    for /r %%i in ("~temp\*.*") do move "%%i" "%cd%\%%~nxi"

    goto EOF
)

if not %~x1 == .flac echo [93mStop! The selected / highlighted file is NOT a flac file (%~x1), please check the format or use eac3to.exe instead.[0m
echo. 
set /p override=Do you wish to continue? 
if %override% == y goto override
if not %override% == y goto EOF

:EOF
@echo [92mCompleted! Nothing else to do[0m
echo.
@pause