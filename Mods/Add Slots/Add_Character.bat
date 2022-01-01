::FILEPATH INFO
set _iniLoc=..\Base\_id\
set _iniFile=%_iniLoc%\id.ini
set _iniBack=%_iniLoc%\id.bak
::***END FILEPATH BLOCK***

:start
echo 1. Playable Character
echo 2. Playable Character Sub-Costume
echo 3. NPC
set MCorNPC=
set /p MCorNPC=Select Playable Character, Character Costume, or NPC: 
if not '%MCorNPC%'=='' set MCorNPC=%MCorNPC:~0,1%
if '%MCorNPC%'=='1' goto mainchar
if '%MCorNPC%'=='2' goto subcostume
if '%MCorNPC%'=='3' goto npc
echo "%MCorNPC%" is not valid, try again
echo.
goto start


:mainchar
echo Listing current character slots
echo
for /f tokens=3 delims=, %%a in ('%SystemRoot%\System32\findstr.exe ";LMC=" "%_iniFile%"') do (
    set "LineMC=%%a"
	setlocal ENABLEDELAYEDEXPANSION
	echo !LineMC:
pause

::If we didn't find the string, rename the backup file to the original file name
::Otherwise, delete the _WorkFile as we re-created the original file when the
::string was found and replaced.
if /i "!_Found!"=="Not found" (echo !_Found! && del "%_FilePath%%_FileName%" && ren "%_FilePath%%_WrkFile%" %_FileName%) else (echo !_Found! && del "%_FilePath%%_WrkFile%")
goto :exit

:NotFound
echo.
echo File "%_FilePath%%_FileName%" missing. 
echo Cannot continue...
echo.
:: Pause script for approx. 10 seconds...
PING 127.0.0.1 -n 11 > NUL 2>&1
goto :Exit

:Exit
exit /b