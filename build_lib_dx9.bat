@REM Build for Visual Studio compiler. Run your copy of vcvars32.bat or vcvarsall.bat to setup command-line compiler.
@set OUT_DIR=win32_dx9
@set OUT_EXE=test_dx9
@set INCLUDES=/I .\ /I .\include\ /I .\include\imgui\ /I .\include\backend\ /I "%DXSDK_DIR%/Include"
@set SOURCES=src\win32\imgui_impl_dx9.cpp ^
src\win32\imgui_impl_win32.cpp ^
src\imgui.cpp ^
src\imgui_demo.cpp ^
src\imgui_draw.cpp ^
src\imgui_tables.cpp ^
src\imgui_widgets.cpp
@set LIBS=/LIBPATH:"%DXSDK_DIR%/Lib/x86" d3d9.lib
mkdir %OUT_DIR%
cl /nologo /Zi /MD %INCLUDES% /D UNICODE /D _UNICODE %SOURCES% /Fo%OUT_DIR%/
lib /nologo /out:libimgui_dx9.lib %OUT_DIR%/*.obj