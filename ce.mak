!INCLUDE <$(WCECOMPAT)/wcedefs.mak>

CFLAGS=/W3 /Ox /O2 /Ob2 /GF /Gy /Zl /nologo \
	   $(WCETARGETDEFS) /DUNICODE /D_UNICODE /DWIN32 /DWIN32_LEAN_AND_MEAN \
	   /D_WINDLL /D_DLL /Foobj/ /Fdlib/lua51.pdb \
	   /D_USE_32BIT_TIME_T \
	   /D_CRT_SECURE_NO_WARNINGS \
	   /D_CRT_SECURE_NO_DEPRECATE \
	   -I../wcecompat/include 

!IF "$(WCEPLATFORM)"=="MS_POCKET_PC_2000"
CFLAGS=$(CFLAGS) /DWIN32_PLATFORM_PSPC
!ENDIF

!IFDEF DEBUG
CFLAGS=$(CFLAGS) /Zi /DDEBUG /D_DEBUG
!ELSE
CFLAGS=$(CFLAGS) /Zi /DNDEBUG
!ENDIF

!IF "$(MSVS)"=="2008"
CFLAGS=$(CFLAGS) /GS-
LFLAGS=/DEF:"src\lua51.def" /DLL /MACHINE:$(WCELDMACHINE) /SUBSYSTEM:WINDOWSCE,$(WCELDVERSION) /NODEFAULTLIB /DYNAMICBASE /NXCOMPAT
!ELSE
LFLAGS=/DEF:"src\lua51ex.def" /DLL /MACHINE:$(WCELDMACHINE) /SUBSYSTEM:WINDOWSCE,$(WCELDVERSION) /NODEFAULTLIB
!ENDIF

CORE_SRC = \
	src/lapi.c src/lcode.c src/ldebug.c src/ldo.c src/ldump.c src/lfunc.c src/lgc.c src/llex.c src/lmem.c \
	src/lobject.c src/lopcodes.c src/lparser.c src/lstate.c src/lstring.c src/ltable.c src/ltm.c  \
	src/lundump.c src/lvm.c src/lzio.c
LIB_SRC=	src/lauxlib.c src/lbaselib.c src/ldblib.c src/liolib.c src/lmathlib.c src/loslib.c src/ltablib.c \
	src/lstrlib.c src/loadlib.c src/linit.c

EXE_SRC= src/lua.c

SRC = $(CORE_SRC) $(LIB_SRC)

OBJS = $(SRC:src=obj) # $(WCELIB_SRC:src/wcelibcex/src=obj)
OBJS = $(OBJS:.cpp=.obj)
OBJS = $(OBJS:.c=.obj)

EXE_OBJS = $(EXE_SRC:src=obj)
EXE_OBJS = $(EXE_OBJS:.cpp=.obj)
EXE_OBJS = $(EXE_OBJS:.c=.obj)

{src}.c{obj}.obj:
	$(CC) $(CFLAGS) -c $<

{src/wcelibcex/src}.c{obj}.obj:
	$(CC) $(CFLAGS) -c $<

{src}.cpp{obj}.obj:
	@$(CC) $(CFLAGS) -c $<

all: lib\lua51.lib lua51.exe
#	echo $(OBJS)

obj:
	@md obj 2> NUL

lib:
	@md lib 2> NUL

lua51.exe: lib/lua51.lib $(EXE_OBJS)
	link /out:lua51.exe $(EXE_OBJS) lib/lua51.lib \
	/nologo /NODEFAULTLIB:"OLDNAMES.lib" /opt:ref /SUBSYSTEM:WINDOWSCE,$(WCELDVERSION) /machine:THUMB \
	corelibc.lib coredll.lib ws2.lib \
	$(WCECOMPAT)/lib/wcecompat.lib \
	$(WCECOMPAT)/lib/winmain.lib \
	/debug

clean:
	del lib\*.lib
	del obj\*.obj
	del lua51.exe

$(OBJS): makefile obj

lib\lua51.lib: lib $(OBJS) makefile
	lib /nologo /out:lib\lua51.lib $(OBJS)


