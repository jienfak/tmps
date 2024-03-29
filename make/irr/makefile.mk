# Makefile for Irrlicht  programs. Isn't supposed to be edited.
.PHONY: all dbg clean install uninstall show_info  \
            show_options show_artifacts show_paths

include config.mk
include os.mk
include $(OS).mk
SHOW_INFO = show_options show_artifacts show_paths
CLEAN     = clean_dist clean_artifacts
.SILENT: install uninstall clean $(CLEAN)


all : $(TGT)

dbg : set_dbgflags show_info $(CLEAN) $(TGT)
	$(LD) $(OUTFLAG) $(TGT) $(LDFLAGS) $(OBJ)

set_dbgflags :
	$(eval CXXFLAGS = $(DBGFLAGS))

show_options :
	@$(ECHO) "'$(TGT)' '$@':"
	@$(ECHO) "OS       =  '$(OS)' ;"
	@$(ECHO) "CXXFLAGS   = '$(CXXFLAGS)' ;"
	@$(ECHO) "LDFLAGS  = '$(LDFLAGS)' ;"
	@$(ECHO) "CXX       = '$(CXX)' ;"
	@$(ECHO) "LD       = '$(LD)' ;"

show_artifacts :
	@$(ECHO) "'$(TGT)' '$@' :"
	@$(ECHO) "SRC      = '$(SRC)' ;"
	@$(ECHO) "HDR      = '$(HDR)' ;"
	@$(ECHO) "OBJ      = '$(OBJ)' ;"
	@$(ECHO) "TARDIR   = '$(TARDIR);'"
	@$(ECHO) "TARARC   = '$(TARARC)'. "

show_paths :
	@$(ECHO) "'$(TGT)' '$@' :"
	@$(ECHO) "ROOTDIR  = '$(ROOTDIR)' ;"
	@$(ECHO) "DIRPREFIX= '$(DIRPREFIX)' ;"
	@$(ECHO) "MANPREFIX= '$(MANPREFIX)' ;"
	@$(ECHO) "DESTDIR  = '$(DESTDIR)' ."
	@$(ECHO) "MAKEFILE_LIST = '$(MAKEFILE_LIST)'"

show_info : $(SHOW_INFO)

$(TGT) : $(OBJ)
	@$(ECHO) "[$@]"
	$(LD) $(LDFLAGS) $(OUTFLAG) $@ $(OBJ)

$(MANUAL) :

strip :
	$(STRIP) $(TGT)

%$(OBJEXT) : %$(CXXEXT)
	@$(ECHO) "[$@]"
	$(CXX) $(OUTFLAG) $@ $(CXXFLAGS) $(OBJFLAG) $<

$(SRC) : $(HDR)

clean: $(CLEAN)

clean_dist :
	$(RM) $(TARDIR) $(TARARC) $(TARGZARC)

clean_artifacts :
	$(RM) $(OBJ) $(TGT)

install : $(TGT) $(MANUAL)
	$(INSTALL) $(TGT) $(DESTDIR)/$(BINPREFIX)/
	$(SED) "s/VERSION/$(VERSION)/g" <$(MANUAL) >$(DESTDIR)/$(MANPREFIX)/$(MANSECTPREFIX)/$(MANUAL)

uninstall :
	$(RM) $(DESTDIR)/$(BINPREFIX)/$(TGT)
	$(RM) $(DESTDIR)/$(MANPREFIX)/$(MANSECTPREFIX)/$(MANUAL)

include tarball.mk
