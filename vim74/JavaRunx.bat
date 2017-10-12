@echo off
setlocal enabledelayedexpansion
set /p input=<run.txt
::del /F /S /Q %cd%\run.txt
set javaFile=%input: =%
set jarFile=
if not exist *.jar goto nojar1
set jarFile=.
dir /b *.jar> javaRun.txt
for /f  %%a in (javaRun.txt) do (    
    set jarFile=!jarFile!;%cd%\%%a
)
del /F /S /Q %cd%\javaRun.txt
:nojar1
cd ../bin
set binpath=%cd%\
for /f %%i in ('dir /s/b %javaFile%.class') do set filepath=%%i
set pcgpath=!filepath:%binpath%=!
set class=%pcgpath:.class=%
set class=%class:\=.%
if "%jarFile%"=="" goto nojar2
java -cp %jarFile% %class%
goto jar

:nojar2
java %class%

:jar
