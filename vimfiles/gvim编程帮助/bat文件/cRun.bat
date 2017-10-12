@echo off
setlocal enabledelayedexpansion
set /p run=<run.txt
::run中末尾的空格
set run=%run: =%
set exec=''
::从命令行中接收第一个参数
set exec=%1%
%exec% .\%run%