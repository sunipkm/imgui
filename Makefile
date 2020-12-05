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

CXXFLAGS:= -I include/imgui -I include/implot -I include/backend -I ./ -Wall -O2 -fpermissive -std=gnu++11
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
src/imgui_impl_opengl2.o \
src/imgui.o \
src/imgui_demo.o \
src/imgui_draw.o \
src/imgui_widgets.o \

BUILDPLOT=src/implot.o \
src/implot_items.o \
src/implot_demo.o

GUITARGET=libimgui_glfw.$(LIBEXT)

all: $(GUITARGET)


$(GUITARGET): $(BUILDGUI) $(BUILDPLOT)
	$(CXX) $(LINKOPTIONS) -o $@ \
	$(BUILDGUI) $(BUILDPLOT) $(LIBS)

%.o: %.cpp
	$(CXX) $(CXXFLAGS) -o $@ -c $<

.PHONY: clean

clean:
	$(RM) $(GUITARGET)

spotless: clean
	$(RM) $(BUILDGUI)
	$(RM) $(BUILDPLOT)

