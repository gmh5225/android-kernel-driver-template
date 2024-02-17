#include "main.h"

static int __init driver_entry(void)
{
	printk(KERN_INFO "Hello, World!\n");
	return 0;
}

static void __exit driver_unload(void)
{
	printk(KERN_INFO "Goodbye, World!\n");
}

module_init(driver_entry);
module_exit(driver_unload);

MODULE_LICENSE("unknown");
MODULE_AUTHOR("unknown");
MODULE_DESCRIPTION("android kernel driver template");
