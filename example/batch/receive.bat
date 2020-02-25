@ECHO OFF

PUSHD "%~dp0"

jq --version & curl --version
CLS
IF NOT "%ERRORLEVEL%" == "0" GOTO NOT_INSTALLED

CALL AUTH.BAT

SET TOKEN_FILE=.sendanywhere-token.txt
SET ARGC=0

FOR %%X IN (%*) DO SET /A ARGC+=1
IF %ARGC% LSS 1 GOTO KEY_NOT_FOUND

SET KEY=%1

curl -s -b %TOKEN_FILE% "https://send-anywhere.com/web/v1/key/%KEY%" > ./key.json

FOR /F "tokens=* USEBACKQ" %%F IN (`jq -r ".key" key.json`) DO SET KEY=%%F
FOR /F "tokens=* USEBACKQ" %%F IN (`jq -r ".weblink" key.json`) DO SET FILE_URL=%%F

IF "%KEY%" == "null" GOTO INVALID_KEY

ECHO key: %KEY%
curl -O -J %FILE_URL%

EXIT /b

:NOT_INSTALLED
ECHO jq or curl is not installed!
EXIT /b

:KEY_NOT_FOUND
ECHO Require receive key!
EXIT /b

:INVALID_KEY
ECHO Invalid key!
EXIT /b
