@echo off
setlocal enabledelayedexpansion
set /p input=<run.txt
::���imputĩβ�Ŀո���������ļ�ʧ��
set input=%input: =%
cd ../bin
set binpath=%cd%\
::����class�ļ�����·��
for /f %%i in ('dir /s/b %input%.class') do set filepath=%%i
::ȥ��package֮���·��
set pcgpath=!filepath:%binpath%=!
::ȥ���ļ���׺��
set class=%pcgpath:.class=%
::������·�����е�\�滻�� .�Ա��������
set class=%class:\=.%
java %class%