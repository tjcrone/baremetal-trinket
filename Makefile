TOOLCHAIN=/usr/local/bin/arm-none-eabi-
AS=$(TOOLCHAIN)as
CC=$(TOOLCHAIN)gcc
LD=$(TOOLCHAIN)ld
AR=$(TOOLCHAIN)ar
GDB=$(TOOLCHAIN)gdb
OBJCOPY=$(TOOLCHAIN)objcopy
OBJDUMP=$(TOOLCHAIN)objdump

CFLAGS = -ffreestanding \
		-fno-builtin \
		-std=gnu99 \
		-Wall \
		-O0 \
		-ggdb \
		-nostdlib \
		-lgcc \
		-nostdinc \
		-save-temps \
		-mthumb \
		-mcpu=cortex-m0plus

default: main.bin

main.bin: main.elf
	$(OBJCOPY) -O binary main.elf main.bin

main.elf: main.o startup.o samd21.ld
	$(LD) -Tsamd21.ld -o main.elf startup.o main.o

main.o: main.c
	$(CC) $(CFLAGS) -c -o main.o main.c

startup.o: startup.c
	$(CC) $(CFLAGS) -c -o startup.o startup.c

download: main.bin
	sh download.sh

gdb: download
	sh gdbserver.sh & \
	arm-none-eabi-gdb main.elf -q -ex \"target remote localhost:2331\"

clean:
	rm -f *.i *.s *.a *.o *.elf *.v *.bin *.hex

#		-ffunction-sections \
#		-fdata-sections \
## language options
# -ffreestanding
# -fno-builtin
# -std=gnu99

## warning options
# -Wall

## debugging options
# -ggdb

## optimization options
# -Og  optimize for debugging
# -ffunction-sections
# -fdata-sections

## linker options
# -nostdlib
# -lgcc

## directory options
# -nostdinc

## arm options
# -mthumb
# -mcpu=cortex-m0plus

# Basic compile process
#arm-none-eabi-gcc -S -mcpu=cortex-m0plus -mthumb main.c
#arm-none-eabi-gcc -Og -c -ggdb -mcpu=cortex-m0plus -mthumb -o startup.o  startup.c
#arm-none-eabi-gcc -Og -c -ggdb -mcpu=cortex-m0plus -mthumb -o main.o  main.c
#arm-none-eabi-ld -Tsamd21.ld -o main.elf startup.o main.o
#arm-none-eabi-objcopy -O binary main.elf main.bin
#arm-none-eabi-gdb main.elf