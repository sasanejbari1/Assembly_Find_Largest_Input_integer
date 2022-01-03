# Compile and Link Variable
CC := gcc
CC_FLAGS := -Wall -m64 -gdwarf-2 -c
ASM := yasm
ASM_FLAGS := -f elf64 -gdwarf2
LINKER := gcc
LINKER_FLAGS := -Wall -m64 -gdwarf-2 -no-pie 


# Executable name
BIN_NAME := my-program
BIN := ./$(BIN_NAME)

run:	build
	@echo "Running program!"
	./my-program

build: $(BIN)
.PHONY: build

#
$(BIN): manager.o largest.o output_array.o input_array.o find_largest.o
	g++ -g -Wall -Wextra -Werror -std=c++17 -no-pie manager.o largest.o output_array.o input_array.o find_largest.o libPuhfessorP.v0.9.3.so -o my-program
	@echo "Done"

input_array.o: input_array.cpp
	g++ -g -Wall -Wextra -Werror -std=c++17 -c -o input_array.o input_array.cpp

output_array.o: output_array.asm
	$(ASM) $(ASM_FLAGS) output_array.asm -o output_array.o
	
find_largest.o: find_largest.asm
	$(ASM) $(ASM_FLAGS) find_largest.asm -o find_largest.o	

manager.o: manager.asm
	$(ASM) $(ASM_FLAGS) manager.asm -o manager.o

largest.o: largest.cpp
	g++ -g -Wall -Wextra -Werror -std=c++17 -c -o largest.o largest.cpp

# ca make targets as many as want

clean: 
	-rm *.o
	-rm $(BIN)














