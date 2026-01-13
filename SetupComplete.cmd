@echo off
set LOG=%WINDIR%\Temp\SetupComplete.log
echo ==== SetupComplete start %DATE% %TIME% ====>>"%LOG%"

reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnce" /v PostInstall /t REG_SZ /d "\"C:\Install\Post\PostInstall.cmd\"" /f >>"%LOG%" 2>&1

echo ==== SetupComplete end %DATE% %TIME% ====>>"%LOG%"
exit /b 0
