@echo off
setlocal enabledelayedexpansion
set /p input=<run.txt
::清除imput末尾的空格，以免查找文件失败
set input=%input: =%
cd ../bin
set binpath=%cd%\
::查找class文件所在路径
for /f %%i in ('dir /s/b %input%.class') do set filepath=%%i
::去掉package之外的路径
set pcgpath=!filepath:%binpath%=!
::去掉文件后缀名
set class=%pcgpath:.class=%
::将包（路径）中的\替换成 .以便带包运行
set class=%class:\=.%
java %class%