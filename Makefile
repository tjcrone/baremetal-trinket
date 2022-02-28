CC=/usr/local/bin/arm-none-eabi-gcc
LD=/usr/local/bin/arm-none-eabi-ld
OBJCOPY=/usr/local/bin/arm-none-eabi-objcopy

CFLAGS=-ffreestanding \
		-fno-builtin \
		-x c \
		-std=gnu99 \
		-Wall \
		-Og \
		-ggdb \
		-nostdlib \
		-lgcc \
		-mthumb \
		-mcpu=cortex-m0plus \
		-mlong-calls \
		-D__SAMD21E18A__

# potential production flags
#-Os
#-ffunction-sections
#-fdata-sections

PACK_INCLUDES=-I"/Users/tjc/github/arm-software/CMSIS_5/CMSIS/Core/Include" \
		-I"/Users/tjc/microchip/SAMD21_DFP/2.0.4/samd21a/include"

default: main.bin

main.bin: main.elf
	$(OBJCOPY) -O binary main.elf main.bin

main.elf: main.o startup_samd21.o system_samd21.o
	$(LD) -Tsamd21e18a_flash.ld -o main.elf main.o startup_samd21.o system_samd21.o

main.o: main.c
	$(CC) $(CFLAGS) $(PACK_INCLUDES) -H -c -o main.o main.c

startup_samd21.o: startup_samd21.c
	$(CC) $(CFLAGS) $(PACK_INCLUDES) -c -o startup_samd21.o startup_samd21.c

system_samd21.o: system_samd21.c
	$(CC) $(CFLAGS) $(PACK_INCLUDES) -c -o system_samd21.o system_samd21.c

download: main.bin
	sh download.sh

#gdb: download
#	sh gdbserver.sh & \
#	arm-none-eabi-gdb main.elf -q -ex \"target remote localhost:2331\"

clean:
	rm -f *.i *.s *.a *.o *.elf *.v *.bin *.hex


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