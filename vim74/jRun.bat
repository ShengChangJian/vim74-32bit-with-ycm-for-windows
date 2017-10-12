@echo off
setlocal enabledelayedexpansion
set /p input=<run.txt
del /F /S /Q %cd%\run.txt
set input=%input: =%
cd ../bin
set binpath=%cd%\
for /f %%i in ('dir /s/b %input%.class') do set filepath=%%i
set pcgpath=!filepath:%binpath%=!
set class=%pcgpath:.class=%
set class=%class:\=.%
java %class%