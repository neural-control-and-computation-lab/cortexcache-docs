@echo off
setlocal EnableExtensions EnableDelayedExpansion
title CortexCache share setup
echo Connect the cortex VPN first, unless this PC has approved direct access.
echo Run as your normal Windows user, not as Administrator.
echo.
choice /c MAS /n /m "Choose your lab: [M] Michaels, [A] Ma, [S] Schall: "
if errorlevel 4 goto failed
if errorlevel 3 (set "share=Schall-Group") else if errorlevel 2 (set "share=Ma-Group") else if errorlevel 1 (set "share=Michaels-Projects") else (goto failed)
set "york_user="
set /p "york_user=Passport York username (without @yorku.ca): "
if not defined york_user goto baduser
rem Delayed expansion keeps username input literal in the net.exe argument.
echo.
echo Windows will choose an unused drive letter and remember the mapping at sign-in.
echo The password prompt below does not display what you type.
echo This script does not save your password. Windows may ask again after sign-in.
"%SystemRoot%\System32\net.exe" use * "\\cortexcache-data.nas.sci.yorku.ca\!share!" * "/user:YORKU\!york_user!" /persistent:yes
if errorlevel 1 goto failed
echo.
echo Connected. Find the new drive in File Explorer under This PC.
echo After connecting the VPN next time, open that drive to reconnect.
echo To stop automatic reconnection, right-click the drive and choose Disconnect.
echo To remember credentials on a trusted personal PC, see README.txt.
pause
exit /b 0
:baduser
echo Enter your Passport York username without @yorku.ca.
pause
exit /b 1
:failed
echo.
echo Setup did not complete. Check the error above, VPN, username and share access.
echo If Windows reports another connection using different credentials, close files
echo and disconnect that server's existing connections in Explorer before retrying.
echo Existing mappings have not been removed or replaced by this script.
pause
exit /b 1
