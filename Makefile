KDIR ?= /home/derickfernando/Projects/yocto/poky-rpi/build/tmp/work/raspberrypi0_2w_64-poky-linux/linux-raspberrypi/6.6.63+git/linux-raspberrypi0_2w_64-standard-build

CROSS_COMPILE ?= /home/derickfernando/Projects/yocto/poky-rpi/build/tmp/work/raspberrypi0_2w_64-poky-linux/linux-raspberrypi/6.6.63+git/recipe-sysroot-native/usr/bin/aarch64-poky-linux/aarch64-poky-linux-

ARCH ?= arm64

DTC = dtc                            

obj-m += mlx90614.o

all: module overlay

module:
	$(MAKE) -C $(KDIR) M=$(PWD) ARCH=$(ARCH) CROSS_COMPILE=$(CROSS_COMPILE) \
	        modules EXTRA_CFLAGS="-DCONFIG_MODULE_SRCVERSION_ALL"

overlay: mlx90614-overlay.dts
	$(DTC) -@ -I dts -O dtb -o mlx90614.dtbo mlx90614-overlay.dts

clean:
	$(MAKE) -C $(KDIR) M=$(PWD) ARCH=$(ARCH) CROSS_COMPILE=$(CROSS_COMPILE) clean
	rm -f mlx90614.dtbo
