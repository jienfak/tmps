# Includable for irr-like makefiles.
VERSION = 0.1
IRRHOME = $(IRRLICHT_CORE_ROOT_DIRECTORY)
TGT     = $(BINDIR)/rls/a.$(SUF)

SRC     = $(wildcard $(SRCDIR)/*.c) $(ADDSRC)
HDR     = $(wildcard $(INCDIR)/*.c) $(ADDHDR)
ADDSRC  =
ADDHDR  =


SRCDIR  = src
INCDIR  = include
BINDIR  = bin

LIBFLAGS = 
OPTFLAGS = -03 -ffast-math
WRNFLAGS =
INCFLAGS = -I$(IRRHOME)/include -I/usr/X11R6/include
CPPFLAGS = $(INCFLAGS)
CXXFLAGS = $()
LDFLAGS  = $(LIBFLAGS)


CXX = g++
LD  = $(CXX)
