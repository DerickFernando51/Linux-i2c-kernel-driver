#include <linux/module.h> 
#include <linux/init.h> 
#include <linux/i2c.h>
#include <linux/kernel.h>

#define MLX90614_ADDR 0x5A 
#define MLX90614_TOBJ1 0x07 
#define MLX90614_TAMB 0x06

static int mlx90614_probe(struct i2c_client *client)
{
	s32 raw;
	int temp_mdeg;

	pr_info("mlx90614: sensor found at 0x%02x\n", client->addr);

	raw = i2c_smbus_read_word_data(client, MLX90614_TOBJ1);
	if (raw < 0) {
		pr_err("mlx90614: failed to read temperature\n");

		return raw;
	}

	temp_mdeg = (raw * 2) - 27315;

	pr_info("mlx90614: object temperature = %d.%02d C\n", temp_mdeg / 100, abs(temp_mdeg % 100));
	return 0;
}

static void mlx90614_remove(struct i2c_client *client)
{
	pr_info("mlx90614: sensor removed\n");
}

/*Device ID table */ 
static const struct i2c_device_id mlx90614_id[] = {
	{ "mlx90614", 0 },
	{ }
};
MODULE_DEVICE_TABLE(i2c, mlx90614_id);

/* Device tree match table */
static const struct of_device_id mlx90614_of_match[] = {
	{ .compatible = "melexis,mlx90614" },
	{ }
};
MODULE_DEVICE_TABLE(of, mlx90614_of_match);

static struct i2c_driver mlx90614_driver = {
	.driver = {
		.name           = "mlx90614",	
		.of_match_table = mlx90614_of_match,
	},
	.probe    = mlx90614_probe,
	.remove   = mlx90614_remove,
	.id_table = mlx90614_id,
};

module_i2c_driver(mlx90614_driver);

MODULE_LICENSE("GPL");
MODULE_AUTHOR("Derick");
MODULE_DESCRIPTION("MLX90614 temperature sensor driver");

