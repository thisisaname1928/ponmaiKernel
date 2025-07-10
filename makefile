X86CodeFolder=kernel/arch/x86
X86_64CodeFolder=kernel/arch/x86_64 kernel/IDPDCode
X86SRC=$(foreach folder,$(X86CodeFolder),$(shell find ./$(folder) -type f -name "*.cpp") $(shell find ./$(folder) -type f -name "*.asm")) 
X86OBJ=$(patsubst %, %.x86.o, $(X86SRC))
X86_64SRC=$(foreach folder,$(X86_64CodeFolder),$(shell find ./$(folder) -type f -name "*.cpp") $(shell find ./$(folder) -type f -name "*.asm")) 
X86_64OBJ=$(patsubst %, %.x86_64.o, $(X86_64SRC))
CXX=g++
CXX_X86_FLAGS=-m32 -ffreestanding -O2 -Wall -Wextra -fno-exceptions -fno-rtti -I ./
CXX_X86_64_FLAGS=
ASM=nasm
ASM_X86_FLAGS=-f elf32
ASM_X86_64_FLAGS=
LD=ld
LD_X86_FLAGS=-m elf_i386 -O2 -nostdlib -T linker.ld
LD_X86_64_FLAGS=
OUTPUT=ponmai
ISO_OUTPUT=ponmai.iso

test: $(ISO_OUTPUT)
	@qemu-system-x86_64 -cdrom $< -m 1G

$(ISO_OUTPUT): $(OUTPUT)
	@echo "Creating iso..."
	@cp ponmai iso/boot
	@cp -r grub iso/boot
	@grub-mkrescue /usr/lib/grub/i386-pc -o $(ISO_OUTPUT) iso/

$(OUTPUT): $(X86OBJ)
	@echo [Linking $@]
	@$(LD) $(X86OBJ) -o $@ $(LD_X86_FLAGS)

%.cpp.x86.o: %.cpp
	@echo [CXX_X86] $< -> $@
	@$(CXX) -c $< -o $@ $(CXX_X86_FLAGS)

%.asm.x86.o: %.asm
	@echo [ASM_X86] $< -> $@
	@$(ASM) $< -o $@ $(ASM_X86_FLAGS)


%.cpp.x86_64.o: %.cpp
	# not support yet

%.asm.x86_64.o: %.asm
	# not support yet

clean:
	rm $(shell find ./ -type f -name "*.o")