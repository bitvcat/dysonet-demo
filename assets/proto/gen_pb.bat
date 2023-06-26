@echo off

setlocal enabledelayedexpansion
set all_proto_filenames=common.proto
for /r "%~p0" %%i in ("*.proto") do (
    if  not %%~nxi==common.proto (
        set "pth=%%~pnxi"
        set all_proto_filenames=!all_proto_filenames! !pth:%~p0=!
    )
)
echo %all_proto_filenames%

pause