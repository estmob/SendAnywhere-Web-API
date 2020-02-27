@ECHO OFF

jq --version & curl --version
IF NOT "%ERRORLEVEL%" == "0" GOTO NOT_INSTALLED

CALL AUTH.BAT

SETLOCAL ENABLEDELAYEDEXPANSION

SET TOKEN_FILE=.sendanywhere-token.txt
SET BODY_OBJECT={"file":[
FOR %%A IN (%*) DO (
	SET BODY_OBJECT=!BODY_OBJECT!{"name":"%%~nxA","size":%%~zA},
)
CALL SET BODY_OBJECT=%%BODY_OBJECT:"=\"%%
SET BODY_OBJECT=%BODY_OBJECT:~0,-1%]}

curl -s -b %TOKEN_FILE% ^
	-H "Content-Type: application/json" ^
	-d %BODY_OBJECT% ^
	"https://send-anywhere.com/web/v1/key" > ./key.json

FOR /F "tokens=* USEBACKQ" %%F IN (`jq -r ".key" key.json`) DO SET KEY=%%F
FOR /F "tokens=* USEBACKQ" %%F IN (`jq -r ".weblink" key.json`) DO SET FILE_URL=%%F

FOR %%A IN (%*) DO (
	SET FILE_UPLOAD=%FILE_UPLOAD% -F file=@%%A
)

IF "%KEY%" == "null" GOTO INVALID_KEY

ECHO key: %KEY%
curl %FILE_UPLOAD% %FILE_URL%

EXIT /b

:NOT_INSTALLED
ECHO jq or curl is not installed!
EXIT /b

:INVALID_KEY
ECHO Invalid key!
EXIT /b
