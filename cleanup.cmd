@echo off
echo "Delete Binaries and cached files"
rd /Q /S Build\WindowsNoEditor
rd /Q /S Binaries
rd /Q /S DerivedDataCache

echo "Cleanup Saves exept user configs and savegames"
rd /Q /S Saved\Autosaves
rd /Q /S Saved\Backup
rd /Q /S Saved\Cooked
rd /Q /S Saved\CookingTemp
rd /Q /S Saved\Logs
rd /Q /S Saved\StagedBuilds
rd /Q /S Saved\Diff
rd /Q /S Saved\Stats
del Saved\Stats\*.tmp


echo "Delete Binaries and Intermediate from Plugins"
rd /Q /S Plugins\VictoryPlugin\Binaries
rd /Q /S Plugins\VictoryPlugin\Intermediate

:choice
set /P c=Rebuild VS Files[Y/N/A] (A deletes sdf file too) default [N] ?
if /I "%c%" EQU "Y" goto :rebuildvs
if /I "%c%" EQU "N" goto :exit
if /I "%c%" EQU "A" goto :vsdelall
goto :exit

:vsdelall
echo "Delete VS Database"
del *.sdf

:rebuildvs
echo "Delete VS Project File"
rd /Q /S Intermediate
del *.sln


echo "Rebuild VS Files"
if exist "C:/Program Files/Epic Games/4.14/Engine/Binaries/DotNET/UnrealBuildTool.exe" (
  "C:/Program Files/Epic Games/4.14/Engine/Binaries/DotNET/UnrealBuildTool.exe" -projectfiles -project="%cd%/AdInfinitum.uproject" -game -rocket -2015 -progress
) else (
  if exist "C:/Program Files x86/Epic Games/4.14/Engine/Binaries/DotNET/UnrealBuildTool.exe" (
    "C:/Program Files x86/Epic Games/4.14/Engine/Binaries/DotNET/UnrealBuildTool.exe" -projectfiles -project="%cd%/AdInfinitum.uproject" -game -rocket -2015 -progress 
  )
)

:exit
exit
