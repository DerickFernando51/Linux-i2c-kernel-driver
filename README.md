## Environment
- Host: Ubuntu ARM64
- Build system: Yocto Project (Poky 5.0.13 / Scarthgap)
- Target: Raspberry Pi Zero 2W (aarch64 / Cortex-A53)
- Kernel: 6.6.63-v8
- Toolchain: aarch64-poky-linux-gcc 13.4.0
<br>

## Driver Implementation
- **Probe Function:** Called automatically by kernel when a sensor is detected on I2C bus
- **Remove Function:** Called when device is unplugged
- **Device ID Table:** Maps the driver to devices named `mlx90614` on the I2C bus
- **Device Tree Table:** Maps the driver to the compatible string `melexis,mlx90614` for automatic registration
- **I2C Read:** Uses `i2c_smbus_read_word_data()` to read raw bytes from sensor register `0x07`
- **Temperature Conversion:** Converts raw ADC value to Celsius using MLX90614 datasheet formula
<br>

## Build
    source oe-init-build-env build
    bitbake mlx90614
<br>

## Deploy
    scp mlx90614.ko root@<rpi-ip>:/root/
<br>

## Run
    insmod mlx90614.ko
    echo mlx90614 0x5A > /sys/bus/i2c/devices/i2c-1/new_device
    dmesg | tail -10
<br>

## Result
mlx90614: sensor found at 0x5a <br>
mlx90614: object temperature = 22.93 C
