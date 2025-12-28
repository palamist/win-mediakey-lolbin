@echo off
setlocal EnableExtensions

set "SRC=%~dp0..\src\MediaKey.cs"
set "OUTDIR=%~dp0..\bin"
set "OUT=%OUTDIR%\MediaKey.exe"
set "CSC_FLAGS=/nologo /optimize+ /debug- /target:winexe /platform:anycpu"

echo Compiling %OUT%...

REM ---- 1) Validate source
if not exist "%SRC%" (
  echo ERROR: "%SRC%" not found in: "%CD%"
  pause
  exit /b 1
)

REM ---- 2) Resolve csc.exe (x64 -> x86 -> PATH)
set "CSC=%WINDIR%\Microsoft.NET\Framework64\v4.0.30319\csc.exe"
if not exist "%CSC%" set "CSC=%WINDIR%\Microsoft.NET\Framework\v4.0.30319\csc.exe"

if not exist "%CSC%" (
  for /f "delims=" %%I in ('where csc.exe 2^>nul') do ( set "CSC=%%I" & goto :got_csc )
  echo ERROR: csc.exe not found. Install .NET Framework 4.x or add csc to PATH.
  pause
  exit /b 1
)
:got_csc

REM ---- 3) Prepare output
if not exist "%OUTDIR%" mkdir "%OUTDIR%" >nul 2>&1

REM ---- 4) Compile
"%CSC%" %CSC_FLAGS% /out:"%OUT%" "%SRC%"
if errorlevel 1 (
  echo.
  echo ERROR: Compilation failed.
  pause
  exit /b 1
)

echo.
echo OK: Compilation successful.
for %%F in ("%OUT%") do (
  echo Generated: "%%~fF" (%%~zF bytes^)
  echo.
  echo Usage:
  echo   %%~fF playpause
  echo   %%~fF next
  echo   %%~fF prev
)
echo.
pause

exit /b 0
