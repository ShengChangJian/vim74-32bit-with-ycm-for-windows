@echo off
setlocal enabledelayedexpansion
set /p run=<run.txt
::run��ĩβ�Ŀո�
set run=%run: =%
set exec=''
::���������н��յ�һ������
set exec=%1%
%exec% .\%run%