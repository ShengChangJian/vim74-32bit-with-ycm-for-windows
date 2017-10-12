@echo off
setlocal enabledelayedexpansion
set /p run=<run.txt
::del /F /S /Q %cd%\run.txt
set run=%run: =%
set exec=''
set exec=%1%
%exec% .\%run%