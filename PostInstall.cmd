@echo off
setlocal EnableExtensions
set "LOG=%WINDIR%\Temp\PostInstall.log"
echo ==== PostInstall start %DATE% %TIME% ====>>"%LOG%"

timeout /t 15 /nobreak >nul

REM --- Brave (StandaloneSetup) ---
if exist "C:\Install\Brave\BraveBrowserStandaloneSetup.exe" (
  echo Installing Brave...>>"%LOG%"
  start /wait "" "C:\Install\Brave\BraveBrowserStandaloneSetup.exe" /silent /install >>"%LOG%" 2>&1
  echo Brave exitcode=%ERRORLEVEL%>>"%LOG%"
) else (
  echo Brave installer not found>>"%LOG%"
)

REM --- 7-Zip (EXE: /S y /D=... case-sensitive) ---
if exist "C:\Install\7zip\7zip.exe" (
  echo Installing 7-Zip...>>"%LOG%"
  "C:\Install\7zip\7zip.exe" /S /D="C:\Program Files\7-Zip" >>"%LOG%" 2>&1
  echo 7-Zip exitcode=%ERRORLEVEL%>>"%LOG%"
) else (
  echo 7-Zip installer not found>>"%LOG%"
)

REM --- Accesos directos (Public Desktop) ---
powershell -NoProfile -ExecutionPolicy Bypass -Command ^
"$Wsh=New-Object -ComObject WScript.Shell; $d='C:\Users\Public\Desktop';" ^
"if (Test-Path 'C:\Apps\FBNeo\fbneo.exe') {" ^
"  $s=$Wsh.CreateShortcut($d+'\FBNeo.lnk');" ^
"  $s.TargetPath='C:\Apps\FBNeo\fbneo.exe';" ^
"  $s.WorkingDirectory='C:\Apps\FBNeo';" ^
"  $s.Save();" ^
"}" ^
"if (Test-Path 'C:\Program Files\7-Zip\7zFM.exe') {" ^
"  $s2=$Wsh.CreateShortcut($d+'\7-Zip File Manager.lnk');" ^
"  $s2.TargetPath='C:\Program Files\7-Zip\7zFM.exe';" ^
"  $s2.WorkingDirectory='C:\Program Files\7-Zip';" ^
"  $s2.Save();" ^
"}" ^
>>"%LOG%" 2>&1

echo Powershell exitcode=%ERRORLEVEL%>>"%LOG%"

REM --- Wallpaper (usuario actual + usuarios nuevos) ---
set "WALL=C:\Windows\Web\Wallpaper\Custom\Ivan.jpg"

if exist "%WALL%" (
  echo Setting wallpaper to %WALL%>>"%LOG%"

  REM 1) Usuario actual (HKCU)
  reg add "HKCU\Control Panel\Desktop" /v Wallpaper /t REG_SZ /d "%WALL%" /f >>"%LOG%" 2>&1
  reg add "HKCU\Control Panel\Desktop" /v WallpaperStyle /t REG_SZ /d 10 /f >>"%LOG%" 2>&1
  reg add "HKCU\Control Panel\Desktop" /v TileWallpaper /t REG_SZ /d 0 /f >>"%LOG%" 2>&1

  REM 2) Default User (para cuentas nuevas)
  reg load "HKU\DefUser" "C:\Users\Default\NTUSER.DAT" >>"%LOG%" 2>&1
  reg add "HKU\DefUser\Control Panel\Desktop" /v Wallpaper /t REG_SZ /d "%WALL%" /f >>"%LOG%" 2>&1
  reg add "HKU\DefUser\Control Panel\Desktop" /v WallpaperStyle /t REG_SZ /d 10 /f >>"%LOG%" 2>&1
  reg add "HKU\DefUser\Control Panel\Desktop" /v TileWallpaper /t REG_SZ /d 0 /f >>"%LOG%" 2>&1
  reg unload "HKU\DefUser" >>"%LOG%" 2>&1

  REM 3) Aplicar inmediatamente (SystemParametersInfo)
  powershell -NoProfile -ExecutionPolicy Bypass -Command ^
    "$img='%WALL%';" ^
    "Add-Type @'using System; using System.Runtime.InteropServices; public class W{[DllImport(\"user32.dll\",SetLastError=true)] public static extern bool SystemParametersInfo(int u,int p,string v,int f);} '@;" ^
    "[W]::SystemParametersInfo(20,0,$img,3) | Out-Null" ^
    >>"%LOG%" 2>&1

) else (
  echo Wallpaper file not found: %WALL%>>"%LOG%"
)
REM (Opcional) aplicar políticas ya
gpupdate /target:computer /force >>"%LOG%" 2>&1


echo ==== PostInstall end %DATE% %TIME% ====>>"%LOG%"
exit /b 0
