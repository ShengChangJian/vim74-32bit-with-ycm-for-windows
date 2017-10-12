@echo off
setlocal enabledelayedexpansion
set uml=%1%
set png=%uml:.uml=.png%
set batpath=%~f0
set batpath=%batpath:plantuml.bat=%
java -jar %batpath%\plantuml.jar -charset UTF-8 -tpng %uml%
::start mspaint %png%
start %png%