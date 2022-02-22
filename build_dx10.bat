@REM Build for Visual Studio compiler. vcvarsall.bat must be in path.
@if "%~1"=="" (set arg1=x86) else (set arg1=%1)
@call vcvarsall %arg1%
if %arg1%==x86 (set ext=32) else (set ext=64)
call build_imgui.bat
@set OUT_DIR=Build
@set OUT_EXE=test_dx10
@set INCLUDES=/I .\include /I "%WindowsSdkDir%Include\um" /I "%WindowsSdkDir%Include\shared" /I "%DXSDK_DIR%Include"
@set SOURCES=src\main_dx10.cpp
@set LIBS=/LIBPATH:"%DXSDK_DIR%/Lib/%arg1%" d3d10.lib d3dcompiler.lib win32_lib\libimgui_win%ext%.lib
mkdir %OUT_DIR%
cl /nologo /Zi /MD /EHsc /wd4005 %INCLUDES% /D UNICODE /D _UNICODE %SOURCES% /Fe%OUT_DIR%/%OUT_EXE%.exe /Fo%OUT_DIR%/ /link %LIBS%
