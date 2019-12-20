# Includable for Irrlicht makefiles.
# It's a bit more complicated than "c1", it uses familiar "makefile.mk" though.
# There are 2-level deep directories only, so it keeps being simple enough to be usable.

# Program name and version. By the standard program name is the name of project root directory.
PROGNAME= $(notdir $(patsubst %/,%,$(dir $(abspath $(firstword $(MAKEFILE_LIST)) ))))
VERSION = 0.1

# Core Irrlicht directory. By the standard it's supposed to be installed on the home directory.
IRR = $(HOME)/irrlicht

# C++ extension. I use "cc" most the time.
CXXEXT = .cc
# Headers extension.
HXXEXT = .hh

# Artifacts.
TGT = $(PROGNAME)$(EXEEXT)
SRC = $(wildcard $(SRCDIR)/*$(CXXEXT) ) $(ADDSRC)
HDR  = $(wildcard $(INCDIR)/*$(HXXEXT)) $(ADDHDR)
ADDSRC =
ADDHDR  =
OBJ = $(SRC:$(CXXEXT)=$(OBJEXT))

# Tarball.
TARDIR  = $(PROGNAME)-$(VERSION)
TARARC  = $(TARDIR)$(TAREXT)
TARGZARC  = $(TARARC)$(GZEXT)

# Directories.
SRCDIR  = src
INCDIR  = include

# Dynamic/static libraries.
LIBFLAGS = -L$(IRR)/lib/$(OS) -lIrrlicht

# Optimization flags.
OPTFLAGS = -O3

# Warnings.
WRNFLAGS =
INCFLAGS = -I$(IRR)/include -I/usr/X11R6/include

# C preprocessor.
CPPFLAGS = $(INCFLAGS)

# Compilation flags.
DBGFLAGS = -g $(CPPFLAGS) -O0         -Wall       $(DEFFLAGS) -DDBG
CXXFLAGS = $(OPTFLAGS) $(WRNFLAGS) $(CPPFLAGS)
LDFLAGS  = $(LIBFLAGS)

# Compiler and linker.
CXX = g++
LD  = $(CXX)
