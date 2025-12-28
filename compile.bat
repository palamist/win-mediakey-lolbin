@echo off
setlocal EnableExtensions

set "SRC=MediaKey.cs"
set "OUTDIR=bin"
set "OUT=%OUTDIR%\MediaKey.exe"
set "CSC_FLAGS=/nologo /optimize+ /debug- /target:winexe /platform:anycpu"

echo Compilando %OUT%...

REM ---- 1) Validar fuente
if not exist "%SRC%" (
  echo ERROR: No se encuentra "%SRC%" en: "%CD%"
  pause
  exit /b 1
)

REM ---- 2) Resolver csc.exe (x64 -> x86 -> PATH)
set "CSC=%WINDIR%\Microsoft.NET\Framework64\v4.0.30319\csc.exe"
if not exist "%CSC%" set "CSC=%WINDIR%\Microsoft.NET\Framework\v4.0.30319\csc.exe"

if not exist "%CSC%" (
  for /f "delims=" %%I in ('where csc.exe 2^>nul') do ( set "CSC=%%I" & goto :got_csc )
  echo ERROR: No se encontro csc.exe. Instala .NET Framework 4.x o agrega csc al PATH.
  pause
  exit /b 1
)
:got_csc

REM ---- 3) Preparar salida
if not exist "%OUTDIR%" mkdir "%OUTDIR%" >nul 2>&1

REM ---- 4) Compilar
"%CSC%" %CSC_FLAGS% /out:"%OUT%" "%SRC%"
if errorlevel 1 (
  echo.
  echo ERROR: La compilacion fallo.
  pause
  exit /b 1
)

echo.
echo OK: Compilacion exitosa.
for %%F in ("%OUT%") do (
  echo Generado: "%%~fF" (%%~zF bytes^)
  echo.
  echo Uso:
  echo   %%~fF playpause
  echo   %%~fF next
  echo   %%~fF prev
)
echo.
pause

exit /b 0
