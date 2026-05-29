KDIR ?= /home/derickfernando/Projects/yocto/poky-rpi/build/tmp/work/raspberrypi0_2w_64-poky-linux/linux-raspberrypi/6.6.63+git/linux-raspberrypi0_2w_64-standard-build

CROSS_COMPILE ?= /home/derickfernando/Projects/yocto/poky-rpi/build/tmp/work/raspberrypi0_2w_64-poky-linux/linux-raspberrypi/6.6.63+git/recipe-sysroot-native/usr/bin/aarch64-poky-linux/aarch64-poky-linux-

ARCH ?= arm64

obj-m += mlx90614.o

all:
	$(MAKE) -C $(KDIR) M=$(PWD) ARCH=$(ARCH) CROSS_COMPILE=$(CROSS_COMPILE) modules EXTRA_CFLAGS="-DCONFIG_MODULE_SRCVERSION_ALL"

clean:
	$(MAKE) -C $(KDIR) M=$(PWD) ARCH=$(ARCH) CROSS_COMPILE=$(CROSS_COMPILE) clean
