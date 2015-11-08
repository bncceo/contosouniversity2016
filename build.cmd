@echo off
cd %~dp0

SETLOCAL
SET NUGET_VERSION=latest
SET CACHED_NUGET=%LocalAppData%\NuGet\nuget.%NUGET_VERSION%.exe

IF EXIST %CACHED_NUGET% goto copynuget
echo Downloading latest version of NuGet.exe...
IF NOT EXIST %LocalAppData%\NuGet md %LocalAppData%\NuGet
@powershell -NoProfile -ExecutionPolicy unrestricted -Command "$ProgressPreference = 'SilentlyContinue'; Invoke-WebRequest 'https://dist.nuget.org/win-x86-commandline/%NUGET_VERSION%/nuget.exe' -OutFile '%CACHED_NUGET%'"

:copynuget
IF EXIST .nuget\nuget.exe goto restore
md .nuget
copy %CACHED_NUGET% .nuget\nuget.exe > nul

:restore
IF EXIST packages\Sake goto getdnx
.nuget\NuGet.exe install Sake -ExcludeVersion -Source https://www.nuget.org/api/v2/ -Out packages

:getdnx
rem echo Installing DNX - 1.0.0-beta8 clr x86
rem CALL dnvm install 1.0.0-beta8 -runtime CLR -arch x86 -alias default

:run
echo Building... %1
packages\Sake\tools\Sake.exe -I sake-build -f makefile.shade %1