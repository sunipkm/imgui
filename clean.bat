@echo Cleaning build files...
@rmdir /s /q Build
@del win32_lib\im*.obj
@del win32_lib\libimgui_win32.lib
@del *.pdb