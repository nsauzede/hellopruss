FILE_DTO=overlay
TARGET=loader
TARGET+=pru0.bin
TARGET+=$(FILE_DTO)-00A0.dtbo
PASM=pasm
PASM_FLAGS=-b -V3 -L -d -l
DTC=dtc
DDR_SIZE=0x40000
SLOTS=/sys/devices/bone_capemgr.8/slots
PINS=/sys/kernel/debug/pinctrl/44e10800.pinmux/pins

all: $(TARGET)

loader: LDFLAGS+=-lprussdrv

%-00A0.dtbo: %.dtso
	$(DTC) -O dtb -o $@ -b 0 -@ $^

%.bin: %.p
	$(PASM) $(PASM_FLAGS) $^ > /dev/null

modprobe:
	sudo modprobe uio_pruss extram_pool_sz=$(DDR_SIZE)

load_pru: load_overlay pru0.bin loader
	sudo ./loader

install_overlay: $(FILE_DTO)-00A0.dtbo
	sudo cp $(FILE_DTO)-00A0.dtbo /lib/firmware

_load_overlay: modprobe
	echo $(FILE_DTO) > $(SLOTS)
	cat $(SLOTS)

load_overlay: modprobe install_overlay
	sudo make _load_overlay

clean:
	$(RM) $(TARGET) *.o *.dtbo *.dbg *.lst pru0.txt
