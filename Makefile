CC := gcc
AR := ar
V := LD_LIBRARY_PATH=./

LIB := libstatic_lib.a libdynamic_lib.so 
TARGET := main

NO_EXPLICIT_DEPENDENCY := 
# NO_EXPLICIT_DEPENDENCY := y

LDMODE :=
# LDMODE := whole-archive
# LDMODE := no-as-needed
# LDMODE := whole-archive-and-no-as-needed
# LDMODE := multiple-definition

CFLAGS := -fPIC

ifeq ($(NO_EXPLICIT_DEPENDENCY), y)
	CFLAGS += -DNO_EXPLICIT_DEPENDENCY
endif

LDFLAGS := 

ifeq ($(LDMODE), whole-archive)
	LDFLAGS += -Wl,--whole-archive $(LIB) -Wl,--no-whole-archive
else ifeq ($(LDMODE), no-as-needed)
	LDFLAGS += -Wl,--no-as-needed $(LIB) -Wl,--as-needed
else ifeq ($(LDMODE), whole-archive-and-no-as-needed)
	LDFLAGS += -Wl,--whole-archive -Wl,--no-as-needed $(LIB) -Wl,--no-whole-archive -Wl,--as-needed
else ifeq ($(LDMODE), multiple-definition)
	LDFLAGS += -Wl,--whole-archive $(LIB)
else
	LDFLAGS += $(LIB)
endif

$(TARGET): main.o $(LIB)
	$(CC) -o $@ $< $(LDFLAGS)
	@nm --defined-only $(TARGET) | awk '{print $$3}' | grep -v '^_' > $(TARGET).symbol
	@nm -D main | awk '{print $$2}' | grep -v '^_' >> $(TARGET).symbol || true
	@$(V) ldd $(TARGET) >> $(TARGET).symbol

libstatic_lib.a: static_lib_part1.o static_lib_part2.o
	@$(AR) rcs $@ $^	

libdynamic_lib.so: dynamic_lib_part1.o dynamic_lib_part2.o
	$(CC) -o $@ -shared $^

%.o: %.c
	@$(CC) -c $^ $(CFLAGS) -o $@

run: $(TARGET)
	@$(V) ./$(TARGET)

clean:
	rm -f *.o $(TARGET) $(TARGET).symbol $(LIB)