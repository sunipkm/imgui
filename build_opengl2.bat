@REM Build for Visual Studio compiler. Run your copy of vcvars32.bat or vcvarsall.bat to setup command-line compiler.
call build_imgui.bat
@set OUT_DIR=output
@set OUT_EXE=test_gl2
@set INCLUDES=/I .\include /I .\win32_include
@set SOURCES=src\main_gl2.cpp
@set LIBS=/LIBPATH:win32_lib libimgui_win32.lib glfw3.lib
mkdir %OUT_DIR%
cl /nologo /Zi /MD %INCLUDES% /D UNICODE /D _UNICODE %SOURCES% /Fe%OUT_DIR%/%OUT_EXE%.exe /Fo%OUT_DIR%/ /link %LIBS%