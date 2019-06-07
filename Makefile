#c projects

#dependencies



#toolchains
CFLAGS := -g -Wall -Isrc
LDFLAGS := 


#exectuables
SRC_DIR := src
OBJ_DIR := $(patsubst src%,obj%, $(SRC_DIR))
SRCS := $(wildcard $(addsuffix /*.c, $(SRC_DIR)))
OBJS := $(patsubst src/%.c,obj/%.o, $(SRCS))
DEPS := $(patsubst src/%.c,obj/%.d, $(SRCS))

MAIN_EXEC := bin/main
MAIN_SRCS := $(SRCS)
MAIN_OBJS := $(patsubst src/%.c,obj/%.o, $(MAIN_SRCS)) 


#targets
.PHONY: all build run clean distclean
all: run


build: $(MAIN_EXEC)

$(MAIN_EXEC): $(MAIN_OBJS)
#	@echo objs: $(MAIN_OBJS)
	$(CC) -o $@ $^ $(LDFLAGS)

include $(DEPS) Makefile.dep

obj/%.d: src/%.c
	$(CC) $(CFLAGS) -MM -MT "$(patsubst src/%.c,obj/%.o, $<) $@" -MF "$@" $<

obj/%.o: src/%.c
	$(CC) $(CFLAGS) -o $@ -c $<

Makefile.dep:
	mkdir bin
	mkdir $(OBJ_DIR)
	touch Makefile.dep


run: build
	$(MAIN_EXEC)


clean:
	rm $(MAIN_EXEC)
	rm $(OBJS)

distclean:
	rm -R bin
	rm -R obj
	rm Makefile.dep


