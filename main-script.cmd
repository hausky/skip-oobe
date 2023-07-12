@echo off
setlocal enabledelayedexpansion

:: Get the current script directory
set "script_dir=%~dp0"

:: Remove trailing slash if it exists
set "script_dir=%script_dir:~0,-1%"

echo This script will copy the Unattend.xml file to the Windows installation, preparing it for first boot while skipping the OOBE process.
echo.

set /P drive="Please enter the drive letter where Windows is installed (for example, D): "
echo.

echo Checking if the Unattend.xml file exists in the script directory...
if not exist "%script_dir%\unattend.xml" (
    echo Error: Unattend.xml file not found in the script directory. Please make sure the Unattend.xml file is in the same folder as this script.
    pause
    exit /b
)

echo Copying Unattend.xml file to the %drive%:\Windows\Panther\ folder...
copy "%script_dir%\unattend.xml" "%drive%:\Windows\Panther\"

if errorlevel 1 (
    echo Error: Failed to copy Unattend.xml to the Windows installation. Please make sure you have the necessary permissions and the target location exists.
    pause
    exit /b
)

echo.
echo Unattend.xml file copied successfully!

set /P response="The system will now be prepared for first boot, skipping the OOBE process. Do you want to reboot the system now? (Y/N): "
echo.

if /I "%response%"=="Y" (
    echo Rebooting the system...
    wpeutil reboot
) else (
    echo Operation complete! You can reboot the system manually when ready.
)

exit /b
