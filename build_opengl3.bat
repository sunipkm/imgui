@REM Build for Visual Studio compiler. Run your copy of vcvars32.bat or vcvarsall.bat to setup command-line compiler.
call build_imgui.bat
@echo OFF
reg Query "HKLM\Hardware\Description\System\CentralProcessor\0" | find /i "x86" > NUL && set OS=32s|| set OS=64s
@echo ON
@set OUT_DIR=output
@set OUT_EXE=test_gl3
@set INCLUDES=/I .\include /I .\win32_include
@set SOURCES=src\main_gl3.cpp
@set LIBS=/LIBPATH:win32_lib libimgui_win32.lib glfw3.lib glew%OS%.lib
mkdir %OUT_DIR%
cl /nologo /Zi /MD %INCLUDES% /D UNICODE /D _UNICODE /D IMGUI_IMPL_OPENGL_LOADER_GLEW /D GLEW_STATIC %SOURCES% /Fe%OUT_DIR%/%OUT_EXE%.exe /Fo%OUT_DIR%/ /link %LIBS%