# Makefile for Irrlicht applications.

.PHONY: all all_win32 static_win32 clean clean_linux clean_win32
# Default TGT is Linux.
all : all_linux

# Target specific settings.
all_linux all_win32 static_win32 : LDFLAGS += -L$(IrrlichtHome)/lib/$(SYSTEM) -lIrrlicht
all_linux : LDFLAGS += -L/usr/X11R6/lib$(LIBSELECT) -lGL -lXxf86vm -lXext -lX11 -lXcursor
all_linux clean_linux : SYSTEM=Linux
all_win32 clean_win32 static_win32 : SYSTEM=Win32-gcc
all_win32 clean_win32 static_win32 : SUF=.exe
static_win32 : CPPFLAGS += -D_IRR_STATIC_LIB_
all_win32 : LDFLAGS += -lopengl32 -lm
static_win32 : LDFLAGS += -lgdi32 -lwinspool -lcomdlg32 -lole32 -loleaut32 -luuid -lodbc32 -lodbccp32 -lopengl32
	# Name of the binary - only valid for targets which set SYSTEM.
DESTPATH = $(BinPath)/$(TGT)$(SUF)

all_linux all_win32 static_win32 :
	$(warning Building...)
	$(CXX) $(CPPFLAGS) $(CXXFLAGS) $(Sources) -o $(DESTPATH) $(LDFLAGS)

clean : clean_linux clean_win32
	$(warning Cleaning...)

clean_linux clean_win32 :
	@$(RM) $(DESTPATH)


# Multilib handling.
ifeq ($(HOSTTYPE), x86_64)
	LIBSELECT=64
endif
# Solaris real-time features.
ifeq ($(HOSTTYPE), sun4)
	LDFLAGS += -lrt
endif
