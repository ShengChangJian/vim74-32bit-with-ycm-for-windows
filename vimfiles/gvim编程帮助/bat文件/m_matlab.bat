@echo off 
set m =1%
set m =%m:.m=%
set Program="matlab.exe"
tasklist -v | findstr %Program% > NUL
if ErrorLevel 1 (
    goto LAST
  ) else (
  wmic process where name="matlab.exe" call terminate
)

:LAST
matlab -nojvm -nodesktop -nodisplay -r %m%
