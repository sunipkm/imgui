@REM Build for Visual Studio compiler. vcvarsall.bat must be in path.
@if "%~1"=="" (set arg1=x86) else (set arg1=%1)
@REM Important: to build on 32-bit systems, the DX12 backends needs '#define ImTextureID ImU64', so we pass it here.
@call vcvarsall %arg1%
if %arg1%==x86 (set ext=32) else (set ext=64)
call build_imgui.bat
@set OUT_DIR=Build
@set OUT_EXE=test_dx12
@set INCLUDES=/I .\include /I "%WindowsSdkDir%Include\um" /I "%WindowsSdkDir%Include\shared"
@set SOURCES=src\main_dx12.cpp ^
src\imgui_impl_dx12.cpp
@set LIBS=d3d12.lib d3dcompiler.lib dxgi.lib win32_lib\libimgui_win%ext%.lib
mkdir %OUT_DIR%
cl /nologo /Zi /MD /EHsc /wd4005 %INCLUDES% /D ImTextureID=ImU64 /D UNICODE /D _UNICODE %SOURCES% /Fe%OUT_DIR%/%OUT_EXE%.exe /Fo%OUT_DIR%/ /link %LIBS%
