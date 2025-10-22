@echo off
setlocal enabledelayedexpansion

:: User inputs
set /p PLUGINNAME=Enter Plugin Name (PascalCase, Example: MyPlugin): 
set /p THIRDPARTYNAME=Enter Third Party Library Name (Example: Steamworks): 

set OLDPLUGINNAME=UEThirdPartyBoilerplate
set OLDTHIRDPARTYFOLDER=Library
set OLDMODULEFOLDER=Main

echo.

:: Rename module folder under Source
if exist "Source\%OLDMODULEFOLDER%" (
    ren "Source\%OLDMODULEFOLDER%" "%PLUGINNAME%"
    echo Renamed folder Source\%OLDMODULEFOLDER% into Source\%PLUGINNAME%
)

:: Rename third-party folder under Source
if exist "Source\ThirdParty\%OLDTHIRDPARTYFOLDER%" (
    ren "Source\ThirdParty\%OLDTHIRDPARTYFOLDER%" "%THIRDPARTYNAME%"
    echo Renamed folder Source\ThirdParty\%OLDTHIRDPARTYFOLDER% into Source\ThirdParty\%THIRDPARTYNAME%
)

:: Rename .uplugin
if exist "%OLDPLUGINNAME%.uplugin" (
    ren "%OLDPLUGINNAME%.uplugin" "%PLUGINNAME%.uplugin"
    echo Renamed "%OLDPLUGINNAME%.uplugin" into "%PLUGINNAME%.uplugin"
)

pushd "%~dp0.\Source\%PLUGINNAME%"

:: Rename Other Files
for %%E in (.h .cpp .Build.cs) do (
    if exist "%OLDPLUGINNAME%%%E" (
        echo Renaming "%OLDPLUGINNAME%%%E" to "%PLUGINNAME%%%%E"
        ren "%OLDPLUGINNAME%%%E" "%PLUGINNAME%%%E"
    )
)


pushd "%~dp0.\Source\ThirdParty\%THIRDPARTYNAME%"

for %%E in (.h .cpp .Build.cs) do (
    if exist "%OLDTHIRDPARTYFOLDER%%%E" (
        echo Renaming "%OLDTHIRDPARTYFOLDER%%%E" to "%THIRDPARTYNAME%%%%E"
        ren "%OLDTHIRDPARTYFOLDER%%%E" "%THIRDPARTYNAME%%%E"
    )
)

echo.
echo Updating file contents...
echo.

pushd "%~dp0"

:: Replace exact module/class name UEThirdPartyBoilerplate to PluginName
for /r %%f in (*.h *.cpp *.cs *.Build.cs *.ini *.txt *.uplugin) do (
    powershell -Command "(Get-Content -Raw '%%f') -replace '%OLDPLUGINNAME%', '%PLUGINNAME%' | Set-Content '%%f'"
)

:: Replace FriendlyName value inside .uplugin
for /r %%f in (*.uplugin) do (
    powershell -Command "(Get-Content -Raw '%%f') -replace '\"FriendlyName\" *: *\"UE Third Party Boilerplate\"', '\"FriendlyName\": \"%PLUGINNAME%\"' | Set-Content '%%f'"
)

:: Replace ONLY "Name": "UEThirdPartyBoilerplate" in Modules section
for /r %%f in (*.uplugin) do (
    powershell -Command "(Get-Content -Raw '%%f') -replace '\"Name\" *: *\"%OLDPLUGINNAME%\"', '\"Name\": \"%PLUGINNAME%\"' | Set-Content '%%f'"
)

:: Replace only folder references "Library" to "ThirdPartyName" inside code
for /r %%f in (*.h *.cpp *.cs *.Build.cs *.ini *.txt) do (
    powershell -Command "(Get-Content -Raw '%%f') -replace 'Library', '%THIRDPARTYNAME%' | Set-Content '%%f'"
)

echo File contents updated.

echo.

echo The program has finsihed. 
echo The plugin has been renamed to "%PLUGINNAME%" and third party library to "%THIRDPARTYNAME%".

echo Closing the program in 5 seconds...
timeout /t 1 /nobreak > nul
echo Closing the program in 4 seconds...
timeout /t 1 /nobreak > nul
echo Closing the program in 3 seconds...
timeout /t 1 /nobreak > nul
echo Closing the program in 2 seconds...
timeout /t 1 /nobreak > nul
echo Closing the program in 1 second...
timeout /t 1 /nobreak > nul

