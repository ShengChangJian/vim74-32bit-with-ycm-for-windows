@echo off
setlocal enabledelayedexpansion
set input=%1%
cd ../bin
set binpath=%cd%\
for /f %%i in ('dir /s/b %input%.class') do set filepath=%%i
set pcgpath=!filepath:%binpath%=!
set class=%pcgpath:.class=%
set class=%class:\=.%
java %class%