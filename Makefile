#i686-pc-linux-gnu-gcc -march=corei7 -fpic -ffreestanding -c boot.S -o boot.o
#arm-none-eabi-gcc -mcpu=arm1176jzf-s -fpic -ffreestanding -c boot.S -o boot.o
arch ?= x86_64
asm ?= i686-pc-linux-gnu-gcc 
kernel := build/kernel-$(arch).bin
iso := build/os-$(arch).iso

linker_script := src/arch/$(arch)/linker.ld
grub_cfg := src/arch/$(arch)/grub.cfg
assembly_source_files := $(wildcard src/arch/$(arch)/*.S)
assembly_object_files := $(patsubst src/arch/$(arch)/%.S, \
	build/arch/$(arch)/%.o, $(assembly_source_files))

.PHONY: all clean run iso

all: $(kernel)

clean:
	@rm -r build
	
run: $(iso)
	@qemu-system-x86_64 -drive format=raw,file=$(iso)
	
iso: $(iso)

$(iso): $(kernel) $(grub_cfg)
	@mkdir -p build/isofiles/boot/grub
	@cp $(kernel) build/isofiles/boot/kernel.bin
	@cp $(grub_cfg) build/isofiles/boot/grub
	@grub-mkrescue -o $(iso) build/isofiles 2> /dev/null
	@rm -r build/isofiles

$(kernel): $(assembly_object_files) $(linker_script)
	@$(asm) -T $(linker_script) -o $(kernel) -ffreestanding -O2 -nostdlib $(assembly_object_files) -lgcc
	#@ld -n -T $(linker_script) -o $(kernel) $(assembly_object_files)
	
# compile assembly files
build/arch/$(arch)/%.o: src/arch/$(arch)/%.S
	@mkdir -p $(shell dirname $@)
	@$(asm) -march=corei7 -fpic -ffreestanding -c $< -o $@

#@nasm -felf32 $< -o $@
#@nasm -f elf64 $< -o $@

