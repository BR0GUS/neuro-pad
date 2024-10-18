# Compiler and flags
CC = gcc
CFLAGS = -Wall -Wextra -Werror -pedantic -std=c99 -O2

# Directories
SRC_DIR = src
OBJ_DIR = obj
BIN_DIR = bin

# Source files
SRCS = $(wildcard $(SRC_DIR)/*.c)
OBJS = $(patsubst $(SRC_DIR)/%.c,$(OBJ_DIR)/%.o,$(SRCS))

# Executable name
TARGET = $(BIN_DIR)/nuro-pad

# Phony targets
.PHONY: all clean

# Default target
all: $(TARGET)

# Linking
$(TARGET): $(OBJS) | $(BIN_DIR)
	$(CC) $(CFLAGS) $^ -o $@

# Compiling
$(OBJ_DIR)/%.o: $(SRC_DIR)/%.c | $(OBJ_DIR)
	$(CC) $(CFLAGS) -c $< -o $@

# Create directories
$(BIN_DIR) $(OBJ_DIR):
	mkdir -p $@

# Clean
clean:
	rm -rf $(OBJ_DIR) $(BIN_DIR)

# Include dependencies
-include $(OBJS:.o=.d)

# Generate dependencies
$(OBJ_DIR)/%.d: $(SRC_DIR)/%.c | $(OBJ_DIR)
	@$(CC) $(CFLAGS) -MM -MT $(@:.d=.o) $< > $@

