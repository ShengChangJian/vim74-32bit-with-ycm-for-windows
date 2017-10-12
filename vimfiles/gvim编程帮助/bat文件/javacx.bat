@echo off
setlocal enabledelayedexpansion
set javaFile=%1%
echo %javaFile%
set jarFile=
if exist *.jar (
set jarFile=.
dir /b *.jar> javac.txt
for /f  %%a in (javac.txt) do (    
    set jarFile=!jarFile!;%%a  
)
)
if "%jarFile%"=="" goto nojar
javac -cp %jarFile% %javaFile% -d ../bin
del /F /S /Q %cd%\javac.txt
goto jar

:nojar
javac %javaFile% -d ../bin

:jar