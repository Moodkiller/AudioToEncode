@echo off
TITLE Executing %~n0 in (%cd%)

if not exist "%cd%/FLAC" mkdir "%cd%/FLAC"
for %%i in (*.dts) do (
"%~dp0/eac3to/eac3to.exe" "%%~i" "%cd%\FLAC\%%~ni.flac" -down24
)

@echo [92mCompleted! Nothing else to do![0m
@pause