CC=gcc
CXX=g++
RM= /bin/rm -vf
ARCH=UNDEFINED
PWD=pwd
CDR=$(shell pwd)

EDCFLAGS:=$(CFLAGS)
EDLDFLAGS:=$(LDFLAGS)
EDDEBUG:=$(DEBUG)

ifeq ($(ARCH),UNDEFINED)
	ARCH=$(shell uname -m)
endif

UNAME_S := $(shell uname -s)

EDCFLAGS+= -I include/ -I ./ -Wall -O2 -std=gnu11 -I libs/gl3w -DIMGUI_IMPL_OPENGL_LOADER_GL3W
CXXFLAGS:= -I include/ -I ./ -Wall -O2 -fpermissive -std=gnu++11 -I libs/gl3w -DIMGUI_IMPL_OPENGL_LOADER_GL3W
LIBS = 

ifeq ($(UNAME_S), Linux) #LINUX
	ECHO_MESSAGE = "Linux"
	LIBS += -lGL `pkg-config --static --libs glfw3`
	LIBEXT= so
	LINKOPTIONS:= -shared
	CXXFLAGS += `pkg-config --cflags glfw3`
	CFLAGS = $(CXXFLAGS)
endif

ifeq ($(UNAME_S), Darwin) #APPLE
	ECHO_MESSAGE = "Mac OS X"
	LIBEXT= dylib
	LINKOPTIONS:= -dynamiclib -single_module
	CXXFLAGS:= -arch $(ARCH) $(CXXFLAGS)
	LIBS += -arch $(ARCH) -framework OpenGL -framework Cocoa -framework IOKit -framework CoreVideo
	LIBS += -L/usr/local/lib -L/opt/local/lib
	#LIBS += -lglfw3
	LIBS += -lglfw

	CXXFLAGS += -I/usr/local/include -I/opt/local/include
	CFLAGS = $(CXXFLAGS)
endif

BUILDGUI=src/imgui_impl_glfw.o \
src/imgui_impl_opengl3.o \
src/imgui_impl_opengl2.o \
libs/gl3w/GL/gl3w.o \
src/imgui.o \
src/imgui_demo.o \
src/imgui_draw.o \
src/imgui_widgets.o

IMPLOTOBJ=src/implot.o \
src/implot_items.o \
src/implot_demo.o

BUILDPLOT=

GUITARGET=libimgui_glfw.a

ifdef implot
BUILDPLOT=$(IMPLOTOBJ)
endif

all: $(GUITARGET) test testgl3

test: $(GUITARGET)
	$(CXX) -o test.out src/main.cpp $(CXXFLAGS) $(GUITARGET) \
	$(LIBS)

testgl3: $(GUITARGET)
	$(CXX) -o test_gl3.out src/main_gl3.cpp $(CXXFLAGS) $(GUITARGET) \
	$(LIBS)


$(GUITARGET): $(BUILDGUI) $(BUILDPLOT)
	ar -crus $(GUITARGET) $(BUILDGUI) $(BUILDPLOT)

%.o: %.cpp
	$(CXX) $(CXXFLAGS) -o $@ -c $<
%.o: %.c
	$(CC) $(EDCFLAGS) -o $@ -c $<
	
.PHONY: clean

clean:
	$(RM) $(GUITARGET)
	$(RM) test.out
	$(RM) test_gl3.out

spotless: clean
	$(RM) $(BUILDGUI)
	$(RM) $(IMPLOTOBJ)

