@ECHO OFF

PUSHD "%~dp0"

curl --version
CLS
IF NOT "%ERRORLEVEL%" == "0" GOTO NOT_INSTALLED

SET TOKEN_FILE=.sendanywhere-token.txt
SET API_KEY=YOUR_API_KEY

curl -s -c %TOKEN_FILE% "https://send-anywhere.com/web/v1/device?api_key=%API_KEY%&profile_name=SendAnywhereSDK"

ECHO.
EXIT /b

:NOT_INSTALLED
ECHO curl is not installed!
EXIT /b
