# Dear ImGui base library with GLFW backend

To compile a program with the library,

1. Install libglfw backend (Ubuntu based linux: `sudo apt install libglfw3-dev`, macOS: `brew install libglfw`)
2. Compile your program with `-limgui_glfw` flag (with linker search path flag, `-L`, pointing to the correct link path)
3. Make sure to pass the following flags as well for complete linkage:
    macOS: `-arch $(ARCH) -framework OpenGL -framework Cocoa -framework IOKit -framework CoreVideo -L/usr/local/lib -lglfw`,
    assuming `brew` linked the GLFW library files to `/usr/local/lib`. Update this path as necessary.

    Linux: ``-lGL `pkg-config --static --libs glfw3` ``